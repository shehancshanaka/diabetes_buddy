import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebasetest.dart';
import 'header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:diabites_buddy/common/google_sign_in.dart';
import 'home.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'home2.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  String? _currentAddress;
  String? _currentCountry;
  Position? _currentPosition;

  void initState() {
    super.initState();
   // _getCurrentPosition();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.country} - ${place.subAdministrativeArea}';
        _currentCountry = '${place.country}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).colorScheme.secondary,
              ])),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(
              top: 16,
              right: 16,
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  child: IconButton(
                    icon: const Icon(Icons.logout),
                    color: Colors.white,
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);

                      provider.logout();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 100,
              child: HeaderWidget(100, false, Icons.abc_outlined),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL!),
                    minRadius: 50,
                    maxRadius: 65,
                  ),
                  // Container(
                  //     padding: EdgeInsets.all(10),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(50),
                  //       border: Border.all(width: 5, color: Colors.white),
                  //       color: Colors.white,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black12,
                  //           blurRadius: 20,
                  //           offset: const Offset(5, 5),
                  //         ),
                  //       ],
                  //     ),
                  //     child: Image(image: NetworkImage(user.photoURL!))),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    user.displayName!,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${_currentAddress ?? ""}',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "User Information",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Container(
                            color: Colors.black87,
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.white,
                                      tiles: [
                                        // ListTile(
                                        //   contentPadding: EdgeInsets.symmetric(
                                        //       horizontal: 12, vertical: 4),
                                        //   leading: Icon(
                                        //     Icons.my_location,
                                        //     color: Colors.white,
                                        //   ),
                                        //   title: Text("Location",
                                        //       style: TextStyle(
                                        //         color: Colors.white,
                                        //       )),
                                        //   subtitle:
                                        //       Text(" ${_currentCountry ?? ""}",
                                        //           style: TextStyle(
                                        //             color: Colors.white,
                                        //           )),
                                        // ),
                                        // ListTile(
                                        //   leading: Icon(Icons.phone,
                                        //       color: Colors.white),
                                        //   title: Text("Phone",
                                        //       style: TextStyle(
                                        //         color: Colors.white,
                                        //       )),
                                        //   subtitle: Text(user.phoneNumber!,
                                        //       style: TextStyle(
                                        //         color: Colors.white,
                                        //       )),
                                        // ),
                                        ListTile(
                                          leading: Icon(Icons.phone,
                                              color: Colors.white),
                                          title: Text("Email",
                                              style: TextStyle(
                                                color: Colors.white,
                                              )),
                                          subtitle: Text(user.email!,
                                              style: TextStyle(
                                                color: Colors.white,
                                              )),
                                        ),
                                        ListTile(
                                          title: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage()));
                                              },
                                              icon: Icon(
                                                FontAwesomeIcons.forward,
                                                color: Colors.amber,
                                              )),
                                          subtitle: Center(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage()));
                                              },
                                              child: Text(
                                                  "Continue".toUpperCase(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.amber)),
                                            ),
                                          ),
                                          //subtitle: Text("99--99876-56"),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
