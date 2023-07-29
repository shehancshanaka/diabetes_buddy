import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diabites_buddy/pages/profile_page.dart';
import 'package:diabites_buddy/pages/tips.dart';
import 'package:social_media_flutter/widgets/icons.dart';
import 'package:social_media_flutter/widgets/text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:diabites_buddy/pages/aboutus.dart';
import 'package:diabites_buddy/pages/all_given_rides.dart';
import 'package:diabites_buddy/pages/donate.dart';
import 'package:diabites_buddy/pages/find_all_rides.dart';
import 'firebasetest.dart';
//import 'firebasetest1.dart';
import 'package:diabites_buddy/pages/google_place.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'home.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    //_getCurrentPosition();
  }

  final Uri _url = Uri.parse('https://www.facebook.com/dele.rideshare');
  String? _currentAddress;
  Position? _currentPosition;
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  // Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location services are disabled. Please enable the services')));
  //     return false;
  //   }
  //   permission =await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Location permissions are denied')));
  //       return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text(
  //             'Location permissions are permanently denied, we cannot request permissions.')));
  //     return false;
  //   }
  //   return true;
  // }

  // Future<void> _getCurrentPosition() async {
  //   final hasPermission = await _handleLocationPermission();

  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {
  //     setState(() => _currentPosition = position);
  //     _getAddressFromLatLng(_currentPosition!);
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.country} -${place.locality}';
        //${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 40, 39, 39),
        appBar: AppBar(
          elevation: 0.5,
          iconTheme: IconThemeData(color: Color.fromARGB(255, 226, 161, 64)),
          backgroundColor: Colors.black,
          actions: [
            Container(
              margin: EdgeInsets.only(
                top: 16,
                right: 16,
              ),
              // child: Text(
              //   "Your Location : ${_currentAddress ?? ""}",
              //   style: TextStyle(
              //       fontSize: 15,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.white),
              // ),
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              // BoxDecoration
              color: Color.fromARGB(255, 40, 39, 39),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
              ),
            ),
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                  ),
                  child: Stack(children: [
                    Container(
                        decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/Flash Screen-logo.png"),
                        fit: BoxFit.fitWidth,
                      ),
                      //    borderRadius: BorderRadius.circular(10),
                      // color: Colors.white.withOpacity(0.1),
                    )),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 10,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    selected: true,
                    selectedTileColor: Theme.of(context).colorScheme.secondary,
                    leading: Icon(
                      Icons.home_outlined,
                      size: _drawerIconSize,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    title: Text(
                      'Home',
                      style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  ),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 10,
                  ),
                  child: ListTile(
                    leading: Icon(Icons.person,
                        size: _drawerIconSize, color: Colors.white),
                    title: Text(
                      'Profile',
                      style: TextStyle(
                          fontSize: _drawerFontSize, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 10,
                  ),
                  child: ListTile(
                    leading: Icon(Icons.tips_and_updates,
                        size: _drawerIconSize, color: Colors.white),
                    title: Text(
                      'Tips',
                      style: TextStyle(
                          fontSize: _drawerFontSize, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Tips()),
                      );
                    },
                  ),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 10,
                  ),
                  child: ListTile(
                    leading: Icon(Icons.search,
                        size: _drawerIconSize, color: Colors.white),
                    title: Text(
                      'Search Places',
                      style: TextStyle(
                          fontSize: _drawerFontSize, color: Colors.white),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => SearchPlacesScreen()),
                      // );
                    },
                  ),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 10,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 10,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    selected: true,
                    selectedTileColor: Theme.of(context).colorScheme.secondary,
                    leading: Icon(
                      Icons.bookmark_border,
                      size: _drawerIconSize,
                      color: Colors.white,
                    ),
                    title: Text(
                      'About Us',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutUs()));
                    },
                  ),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 10,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 10,
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.logout_rounded,
                      size: _drawerIconSize,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: _drawerFontSize, color: Colors.white),
                    ),
                    onTap: () {
                      SystemNavigator.pop();
                    },
                  ),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                // Container(
                //   margin: EdgeInsets.only(
                //     left: 8,
                //     right: 8,
                //     top: 10,
                //   ),
                //   child: ListTile(
                //     leading: Icon(
                //       Icons.handshake,
                //       size: _drawerIconSize,
                //       color: Colors.white,
                //     ),
                //     title: Text(
                //       'Donate',
                //       style: TextStyle(
                //           fontSize: _drawerFontSize, color: Colors.white),
                //     ),
                //     onTap: () {
                //       Navigator.push(context,
                //           MaterialPageRoute(builder: (context) => Donate()));
                //     },
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 10,
                    
                  ),
                  
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SocialWidget(
                        placeholderText: '',
                        iconData: SocialIconsFlutter.instagram,
                        iconColor: Colors.pink,
                        link: 'https://www.instagram.com/invites/contact/?i=qhcanum8ieqg&utm_content=g7quhyg',
                        placeholderStyle:
                            TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      InkWell(
                        onTap: _launchUrl,
                        child: SocialWidget(
                          placeholderText: '',
                          iconData: SocialIconsFlutter.facebook_box,
                          link: 'https://www.facebook.com/profile.php?id=100095282440611&mibextid=ZbWKwL',
                          iconColor: Colors.blue,
                          placeholderStyle:
                              TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      SocialWidget(
                        placeholderText: '',
                        iconData: SocialIconsFlutter.linkedin_box,
                        link: 'https://www.linkedin.com/in/shanaka-chathuranga-198374187',
                        iconColor: Colors.blue,
                        placeholderStyle:
                            TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: Center(
          child: Container(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please be ready for tomorrow'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                //SizedBox
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: InkWell(
                    onTap: () {
                      // _getCurrentPosition();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => CurrentLocationScreen()),
                      // );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/map.png"),
                          fit: BoxFit.fitWidth,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ), //BoxDecoration
                    ),
                  ), //Container
                ),
                SizedBox(
                  height: 20,
                ),
                // Flexible(
                //   flex: 1,
                //   fit: FlexFit.tight,
                //   child: Row(
                //     children: <Widget>[
                //       Flexible(
                //         flex: 1,
                //         fit: FlexFit.tight,
                //         child: Container(
                //           child: Stack(
                //             children: [
                //               Positioned(
                //                 child: Container(
                //                     width: 155,
                //                     height: 135,
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(80),
                //                       //  color: Colors.white.withOpacity(0.1),
                //                     )),
                //               ),
                //               InkWell(
                //                 onTap: () {
                //                   Navigator.push(
                //                     context,
                //                     MaterialPageRoute(
                //                         builder: (context) =>
                //                             FindAllRideViewePage()),
                //                   );
                //                 },
                //                 child: Container(
                //                     decoration: BoxDecoration(
                //                   image: DecorationImage(
                //                     image: AssetImage(
                //                         "assets/ride_searchgirl.png"),
                //                     fit: BoxFit.fitWidth,
                //                   ),
                //                   borderRadius: BorderRadius.circular(15),
                //                   color: Colors.white.withOpacity(0.1),
                //                 )),
                //               ),
                //               Positioned(
                //                 bottom: 2,
                //                 left: 5,
                //                 child: Container(
                //                   color: Colors.black.withOpacity(0.7),
                //                   child: Text(
                //                     'All  Requested Rides',
                //                     style: TextStyle(
                //                         fontSize: 15,
                //                         fontWeight: FontWeight.bold,
                //                         color: Colors.white),
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             // color: Colors.white.withOpacity(0.1),
                //           ), //BoxDecoration
                //         ), //Container
                //       ), //Flexible
                //       SizedBox(
                //         width: 20,
                //       ), //SizedBox
                //       Flexible(
                //         flex: 1,
                //         fit: FlexFit.tight,
                //         child: Container(
                //           child: Stack(
                //             children: [
                //               Positioned(
                //                 top: 65,
                //                 child: Container(
                //                     width: 155,
                //                     height: 135,
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.circular(10),
                //                       //color: Colors.white.withOpacity(1),
                //                     )),
                //               ),
                //               InkWell(
                //                 onTap: () {
                //                   // Navigator.push(
                //                   //   context,
                //                   //   MaterialPageRoute(
                //                   //       builder: (context) =>
                //                   //           UserInformation1()),
                //                   // );
                //                 },
                //                 child: Container(
                //                     decoration: BoxDecoration(
                //                   image: DecorationImage(
                //                     image: AssetImage("assets/map_view.png"),
                //                     fit: BoxFit.fill,
                //                   ),
                //                   borderRadius: BorderRadius.circular(15),
                //                   color: Colors.white.withOpacity(0.1),
                //                 )),
                //               ),
                //               Positioned(
                //                 bottom: 2,
                //                 left: 5,
                //                 child: Container(
                //                   color: Colors.black.withOpacity(1),
                //                   child: Text(
                //                     'My Requested Rides',
                //                     style: TextStyle(
                //                         fontSize: 15,
                //                         fontWeight: FontWeight.bold,
                //                         color: Colors.white),
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(20),
                //             //color: Colors.white.withOpacity(0.1),
                //           ), //BoxDecoration
                //         ), //Container
                //       ) //Flexible
                //     ], //<Widget>[]
                //     mainAxisAlignment: MainAxisAlignment.center,
                //   ), //Row
                // ), //Flexible
                
                SizedBox(
                  height: 20,
                ), //SizedBox
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          child: Stack(
                            children: [
                              Positioned(
                                top: 65,
                                child: Container(
                                    width: 155,
                                    height: 135,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      //  color: Colors.white.withOpacity(0.1),
                                    )),
                              ),
                             // InkWell(
                              //  onTap: () {
                               //   Navigator.push(
                               //     context,
                                 //   MaterialPageRoute(
                                   //     builder: (context) =>
                                //            AllGivenRideDetailsPage()),
                               //   );
                               // },
                                // child: Container(
                                //     decoration: BoxDecoration(
                                //   image: DecorationImage(
                                //     image: AssetImage("assets/Cha4.png"),
                                //     fit: BoxFit.fitWidth,
                                //   ),
                                //   borderRadius: BorderRadius.circular(10),
                                //   color: Colors.white.withOpacity(0.1),
                                // )),
                           //   ),
                              // Positioned(
                              //   bottom: 2,
                              //   left: 30,
                              //   child: Container(
                              //     color: Colors.black.withOpacity(0.7),
                              //     child: Text(
                              //       'All Given Rides',
                              //       style: TextStyle(
                              //           fontSize: 15,
                              //           fontWeight: FontWeight.bold,
                              //           color: Colors.white),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.white.withOpacity(0.1),
                          ), //BoxDecoration
                        ), //Container
                      ), //Flexible
                      SizedBox(
                        width: 20,
                      ), //SizedBox
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Container(
                          child: Stack(
                            children: [
                              Positioned(
                                top: 65,
                                child: Container(
                                    width: 155,
                                    height: 135,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      //color: Colors.white.withOpacity(0.1),
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                  );
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/req_ride.png"),
                                    fit: BoxFit.fitWidth,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white.withOpacity(0.1),
                                )),
                              ),
                              Positioned(
                                bottom: 1,
                                left: 15,
                                child: Container(
                                  color: Colors.black.withOpacity(0.7),
                                  child: Text(
                                    'Check my Stage',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.white.withOpacity(0.1),
                          ), //BoxDecoration
                        ), //Container
                      ) //Flexible
                    ], //<Widget>[]
                    mainAxisAlignment: MainAxisAlignment.center,
                  ), //Row
                ), //Flexible
              ], //<Widget>[]
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            ), //Column
          ) //Padding
              ), //Container
        ) //Container
        );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
