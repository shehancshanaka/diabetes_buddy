import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  // loged user
  final user = FirebaseAuth.instance.currentUser!.uid;
  dynamic uid1;
  static final db = FirebaseFirestore.instance;

  // text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  //final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passengerController = TextEditingController();
  final TextEditingController _PhoneNumberController = TextEditingController();
  final TextEditingController _descreiptionController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final CollectionReference _giveride =
      FirebaseFirestore.instance.collection('GiveRide');

  final List<String> items = [
    'Male',
    'Female',
    'Other',
  ];
  final List<String> vehicles = [
    'Car',
    'Van',
    'MotorBike',
  ];

  String? selectedValue;
  String? selectedValue1;

  Future<void> _createOrUpdate(
      [String? documentId, Map<String, dynamic>? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _genderController.text = documentSnapshot['gender'];
      _startController.text = documentSnapshot['start'];
      _endController.text = documentSnapshot['end'];
      _dateController.text = documentSnapshot['date'];
      _timeController.text = documentSnapshot['time'];
      //_addressController.text = documentSnapshot['address'];
      _passengerController.text = documentSnapshot['passenger'].toString();
      _PhoneNumberController.text = documentSnapshot['PhoneNumber'].toString();
      _descreiptionController.text = documentSnapshot['description'].toString();
      _countryCodeController.text = documentSnapshot['countrycode'].toString();
    }
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.black,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Theme(
            data: ThemeData(
                colorScheme: ColorScheme.light(primary: Colors.orange).copyWith(
                    primary: Colors.orange, secondary: Colors.orange)),
            child: Padding(
              padding: EdgeInsets.only(
                top: 40,
                left: 20,
                right: 20,
                // // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _nameController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white)),
                          hintText: 'Your Name',
                          hintStyle: TextStyle(color: Colors.white),
                          //   helperText:
                          //  'Keep it short, this is just a demo.',
                          labelText: 'Enter Your  Name',
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.yellow,
                          ),
                          labelStyle: TextStyle(color: Colors.white)),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    // DropdownButtonHideUnderline(
                    //   child: DropdownButton2(
                    //     selectedItemHighlightColor:
                    //         Colors.white.withOpacity(0.5),
                    //     focusColor: Theme.of(context).colorScheme.secondary,
                    //     isExpanded: true,

                    //     hint: Text(
                    //       'Select Your Gender',
                    //       style: TextStyle(
                    //         fontSize: 18,
                    //         color: Theme.of(context).colorScheme.secondary,
                    //       ),
                    //     ),
                    //     items: items
                    //         .map((item) => DropdownMenuItem<String>(
                    //               value: item,
                    //               child: Text(
                    //                 item,
                    //                 style: const TextStyle(
                    //                   color: Color.fromARGB(255, 248, 248, 65),
                    //                   fontSize: 18,
                    //                 ),
                    //               ),
                    //             ))
                    //         .toList(),
                    //     value: selectedValue,
                    //     onChanged: (value) {
                    //       setState(() {
                    //         selectedValue = value as String;
                    //       });
                    //     },

                    //     buttonDecoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     dropdownDecoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(4),
                    //       color: Colors.black.withOpacity(0.5),
                    //     ),
                    //     buttonHeight: 30,
                    //     buttonWidth: 200,
                    //     itemHeight: 40,
                    //     dropdownMaxHeight: 200,
                    //     searchController: _genderController,
                    //     searchInnerWidget: Padding(
                    //       padding: const EdgeInsets.only(
                    //         top: 8,
                    //         bottom: 4,
                    //         right: 8,
                    //         left: 8,
                    //       ),
                    //       child: TextFormField(
                    //         controller: _genderController,
                    //         decoration: InputDecoration(
                    //           isDense: true,
                    //           contentPadding: const EdgeInsets.symmetric(
                    //             horizontal: 10,
                    //             vertical: 8,
                    //           ),
                    //           hintText: 'Select your gender',
                    //           hintStyle: const TextStyle(
                    //               fontSize: 12, color: Colors.white),
                    //           border: OutlineInputBorder(
                    //             borderSide: BorderSide(
                    //                 color: Colors.black.withOpacity(0.5)),
                    //             borderRadius: BorderRadius.circular(8),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     searchMatchFn: (item, searchValue) {
                    //       return (item.value.toString().contains(searchValue));
                    //     },
                    //     //This to clear the search value when you close the menu
                    //     onMenuStateChange: (isOpen) {
                    //       if (!isOpen) {
                    //         _genderController.text = selectedValue.toString();
                    //         _genderController.clear();
                    //       }
                    //     },
                    //   ),
                    // ),
                    Divider(
                      color: Colors.white,
                    ),
                    // ElevatedButton.icon(
                    //   icon: Icon(Icons.calendar_today),
                    //   label: Text('Select Date'),
                    //   onPressed: () {
                    //     DatePicker.showDatePicker(
                    //       context,
                    //       showTitleActions: true,
                    //       minTime: DateTime(2018, 1, 1),
                    //       maxTime: DateTime(2025, 1, 7),
                    //       onChanged: (date) {
                    //         print('change $date');
                    //       },
                    //       onConfirm: (date) {
                    //         print('confirm $date');
                    //         _dateController.text = date.year.toString() +
                    //             "/" +
                    //             date.month.toString() +
                    //             "/" +
                    //             date.day.toString();
                    //       },
                    //     );
                    //   },
                    // ),
                    Divider(
                      color: Colors.white,
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.timer),
                      label: Text('Select Time'),
                      onPressed: () {
                        // DatePicker.showTimePicker(context,
                        //     showTitleActions: true, onChanged: (time) {
                        //   print('change $time');
                        // }, onConfirm: (time) {
                        //   print('confirm $time');
                        //   _timeController.text = time.hour.toString() +
                        //       ":" +
                        //       time.minute.toString();
                        // }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    TextFormField(
                      controller: _startController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white)),
                          hintText: 'Enter Start Location',
                          hintStyle: TextStyle(color: Colors.white),
                          //  helperText:
                          //    'Keep it short, this is just a demo.',
                          labelText: 'Start Location',
                          prefixIcon: const Icon(
                            Icons.location_on,
                            color: Colors.yellow,
                          ),
                          labelStyle: TextStyle(color: Colors.white)),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    TextFormField(
                      // onTap: () {
                      //   _handlePressButton();
                      // },
                      controller: _endController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white)),
                          hintText: 'Enter End Location',
                          hintStyle: TextStyle(color: Colors.white),
                          //   helperText:
                          //     'Keep it short, this is just a demo.',
                          labelText: 'End Location',
                          prefixIcon: const Icon(
                            Icons.location_searching,
                            color: Colors.yellow,
                          ),
                          labelStyle: TextStyle(color: Colors.white)),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    // TextFormField(
                    //   controller: _addressController,
                    //   style: TextStyle(color: Colors.white),
                    //   decoration: InputDecoration(
                    //       border: new OutlineInputBorder(
                    //           borderSide: new BorderSide(color: Colors.white)),
                    //       hintText: 'Address',
                    //       hintStyle: TextStyle(color: Colors.white),
                    //       //   helperText:
                    //       //  'Keep it short, this is just a demo.',
                    //       labelText: 'Enter Your Address',
                    //       prefixIcon: const Icon(
                    //         Icons.person,
                    //         color: Colors.yellow,
                    //       ),
                    //       labelStyle: TextStyle(color: Colors.white)),
                    // ),
                    // Divider(
                    //   color: Colors.white,
                    // ),
                    TextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: _passengerController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white)),
                          hintText: 'Number of Passengers',
                          hintStyle: TextStyle(color: Colors.white),
                          //   helperText:
                          //  'Keep it short, this is just a demo.',
                          labelText: 'Enter Your Number of Passengers',
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.yellow,
                          ),
                          labelStyle: TextStyle(color: Colors.white)),
                    ),
                    Divider(
                      color: Colors.white,
                    ),

                    IntlPhoneField(
                      controller: _PhoneNumberController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: 'Phone Number',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                      ),
                      onChanged: (phone) {
                        // print(phone.completeNumber);
                      },
                      onCountryChanged: (country) {
                        _countryCodeController.text = country.name;
                        print('Country changed to: ' +
                            country.name +
                            ' ' +
                            country.code);
                      },
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    TextFormField(
                      controller: _descreiptionController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white)),
                          hintText: 'Description',
                          hintStyle: TextStyle(color: Colors.white),
                          //   helperText:
                          //  'Keep it short, this is just a demo.',
                          labelText: 'Enter Your Description',
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.yellow,
                          ),
                          labelStyle: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      child: Text(action == 'create' ? 'Create' : 'Update'),
                      onPressed: () async {
                        final String? name = _nameController.text;
                        final String? date = _dateController.text;
                        final String? time = _timeController.text;
                        final String? gender = _genderController.text;
                        final String? start = _startController.text;
                        final String? end = _endController.text;
                        final String? countrycode = _countryCodeController.text;
                        //  final String? address = _addressController.text;
                        final double? passenger =
                            double.tryParse(_passengerController.text);
                        final double? phoneNumber =
                            double.tryParse(_PhoneNumberController.text);
                        final String? description =
                            _descreiptionController.text;
                        if (name != null &&
                            gender != null &&
                            date != null &&
                            time != null &&
                            start != null &&
                            end != null &&
                            //    address != null &&
                            passenger != null &&
                            phoneNumber != null &&
                            description != null) {
                          if (action == 'create') {
                            // Persist a new product to Firestore
                            await _giveride.add({
                              "name": name,
                              "date": date,
                              "time": time,
                              "gender": gender,
                              "start": start,
                              "end": end,
                              // "address": address,
                              "passenger": passenger,
                              "PhoneNumber": phoneNumber,
                              "description": description,
                              "countrycode": countrycode,
                              "userid": user,
                              "createdAt": FieldValue.serverTimestamp(),
                            });
                          }

                          if (action == 'update' && documentId != null) {
                            // Update the product
                            await _giveride.doc(documentId).update({
                              "name": name,
                              "date": date,
                              "time": time,
                              "gender": gender,
                              "start": start,
                              "end": end,
                              // "address": address,
                              "passenger": passenger,
                              "PhoneNumber": phoneNumber,
                              "description": description,
                              "countrycode": countrycode,
                            });
                          }

                          // Clear the text fields
                          _nameController.text = '';
                          _dateController.text = '';
                          _timeController.text = '';
                          _genderController.text = '';
                          _startController.text = '';
                          _endController.text = '';
                          // _addressController.text = '';
                          _passengerController.text = '';
                          _PhoneNumberController.text = '';
                          _descreiptionController.text = '';
                          _countryCodeController.text = '';

                          // Hide the bottom sheet
                          Navigator.of(context).pop();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _deleteProduct(String productId) async {
    await _giveride.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully deleted a Ride')));
  }

  Stream<QuerySnapshot> _getUserStream(String userId) {
    return FirebaseFirestore.instance
        .collection('GiveRide')
        .where('userid', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Widget _buildCards(List<QueryDocumentSnapshot> data) {
    List<Widget> children =
        data.map((QueryDocumentSnapshot snap) => _buildCard(snap)).toList();

    return Column(
      children: children,
    );
  }

  Widget _buildCard(DocumentSnapshot doc) {
    String cardId = doc.id;
    Map<String, dynamic> mappedData = doc.data()! as Map<String, dynamic>;

    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Card(
        color: Colors.black.withOpacity(0),
        shape: Border.all(
            color: Color.fromARGB(255, 226, 161, 64),
            style: BorderStyle.solid,
            width: 3),
        elevation: 25,
        child: ListTile(
          title: Column(
            children: [
              Text(
                'Name :  ' + mappedData['name'],
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          subtitle: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Designation :",
                        style: TextStyle(color: Colors.white)),
                    // SizedBox(
                    //   width: 5,
                    // ),
                    Text(mappedData['start'],
                        style: TextStyle(color: Colors.white)),
                    SizedBox(
                      width: 5,
                    ),
                    Text('To', style: TextStyle(color: Colors.white)),
                    SizedBox(
                      width: 5,
                    ),
                    Text(mappedData['end'],
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              Divider(
                height: 25,
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Date :', style: TextStyle(color: Colors.white)),
                  SizedBox(
                    width: 5,
                  ),
                  Text(mappedData['date'],
                      style: TextStyle(color: Colors.white)),
                  SizedBox(
                    width: 5,
                  ),
                  Text('At', style: TextStyle(color: Colors.white)),
                  SizedBox(
                    width: 5,
                  ),
                  Text(mappedData['time'],
                      style: TextStyle(color: Colors.white)),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Gender :', style: TextStyle(color: Colors.white)),
                  SizedBox(
                    width: 5,
                  ),
                  Text(mappedData['gender'],
                      style: TextStyle(color: Colors.white)),
                  SizedBox(
                    width: 5,
                  ),
                  // Text('To'),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  // Text(mappedData['end']),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Passemgers :", style: TextStyle(color: Colors.white)),
                  SizedBox(
                    width: 5,
                  ),
                  Text(mappedData['passenger'].toString(),
                      style: TextStyle(color: Colors.white)),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Mobile :", style: TextStyle(color: Colors.white)),
                  SizedBox(
                    width: 5,
                  ),
                  Text(mappedData['PhoneNumber'].toString().substring(0, 9),
                      style: TextStyle(color: Colors.white)),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Description :",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(mappedData['description'],
                        style: TextStyle(color: Colors.white)),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteProduct(cardId)),
                  IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      onPressed: () => _createOrUpdate(cardId, mappedData)),
                  // Text(mappedData['passenger'].toString().substring(0, 1)),
                ],
              )
            ],
          ),
          leading: Column(
            children: [
              // IconButton(
              //     icon: const Icon(Icons.delete, color: Colors.red),
              //     onPressed: () =>
              //         _deleteProduct(mappedData.)),
              //Text(mappedData['passenger'].toString().substring(0, 1)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _getUserStream(user),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong',
              style: TextStyle(color: Colors.white));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          List<QueryDocumentSnapshot> data = snapshot.data!.docs;
          return Scaffold(
              backgroundColor: Color.fromARGB(255, 29, 28, 28),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(66),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: AppBar(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                      icon: Icon(
                        Icons.home,
                        color: Color.fromARGB(255, 226, 161, 64),
                      ),
                    ),
                    title: Text(
                      'My Given Rides',
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.displayMedium,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Color.fromARGB(255, 226, 161, 64),
                      ),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.black, // appbar color.
                    actions: [
                      TextButton(
                        onPressed: () {
                          _createOrUpdate();
                        },
                        child: Text(
                          'Add',
                          style: GoogleFonts.poppins(
                            textStyle:
                                Theme.of(context).textTheme.displayMedium,
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(child: _buildCards(data)));
        }

        return Text('');
      },
    );
  }
}
