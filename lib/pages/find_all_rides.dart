import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class FindAllRideViewePage extends StatefulWidget {
  const FindAllRideViewePage({
    Key? key,
  }) : super(key: key);

  @override
  _FindAllRideViewePageState createState() => _FindAllRideViewePageState();
}

class _FindAllRideViewePageState extends State<FindAllRideViewePage> {
  // text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passengerController = TextEditingController();
  final TextEditingController _PhoneNumberController = TextEditingController();
  final TextEditingController _descreiptionController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('Users');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
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
                    TextFormField(
                      controller: _genderController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white)),
                          hintText: 'Male / Female',
                          hintStyle: TextStyle(color: Colors.white),
                          //   helperText:
                          //  'Keep it short, this is just a demo.',
                          labelText: 'Enter Your Gender',
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.yellow,
                          ),
                          labelStyle: TextStyle(color: Colors.white)),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.calendar_today),
                      label: Text('Select Date'),
                      onPressed: () {
                        // DatePicker.showDatePicker(
                        //   context,
                        //   showTitleActions: true,
                        //   minTime: DateTime(2018, 1, 1),
                        //   maxTime: DateTime(2025, 1, 7),
                        //   onChanged: (date) {
                        //     print('change $date');
                        //   },
                        //   onConfirm: (date) {
                        //     print('confirm $date');
                        //     _dateController.text = date.year.toString() +
                        //         "/" +
                        //         date.month.toString() +
                        //         "/" +
                        //         date.day.toString();
                        //   },
                        // );
                      },
                    ),
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
                            await _users.add({
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

                          if (action == 'update') {
                            // Update the product
                            await _users.doc(documentSnapshot!.id).update({
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

  // Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await _users.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully deleted a Ride')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 29, 28, 28),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'All Request Rides Details',
          style: TextStyle(color: Color.fromARGB(255, 226, 161, 64)),
        ),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: Theme(
        data: ThemeData(
            colorScheme:
                ColorScheme.light(primary: Color.fromARGB(255, 226, 161, 64))
                    .copyWith(
                        primary: Color.fromARGB(255, 226, 161, 64),
                        secondary: Color.fromARGB(255, 226, 161, 64))),
        child: StreamBuilder(
          stream: _users.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Future.delayed(Duration(seconds: 20), () {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 10.0,
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            leading: Container(
                              padding: EdgeInsets.only(right: 12.0),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                      right: new BorderSide(
                                          width: 1.0, color: Colors.white24))),
                              child: Column(
                                children: [
                                  Icon(FontAwesomeIcons.car,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    documentSnapshot['passenger'].toString(),
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                ],
                              ),
                            ),

                            title: Column(
                              children: [
                                Text(
                                  documentSnapshot['start']
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "To".toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  documentSnapshot['end']
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                            subtitle: SizedBox(
                              width: 20,
                              child: Column(
                                children: <Widget>[
                                  Divider(
                                    color: Color.fromARGB(255, 133, 127, 127),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(Icons.person,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        documentSnapshot['name'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(Icons.where_to_vote_outlined,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        documentSnapshot['countrycode'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.call,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          documentSnapshot['PhoneNumber']
                                                  .toString()
                                                  .substring(0, 3) +
                                              " " +
                                              documentSnapshot['PhoneNumber']
                                                  .toString()
                                                  .substring(3, 6) +
                                              " " +
                                              documentSnapshot['PhoneNumber']
                                                  .toString()
                                                  .substring(6, 9),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  //  Icon(FontAwesomeIcons.clock,
                                  //color: Colors.yellowAccent),
                                  // SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(FontAwesomeIcons.calendar,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(documentSnapshot['date'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(FontAwesomeIcons.clock,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(documentSnapshot['time'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(FontAwesomeIcons.male,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(documentSnapshot['gender'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color: Color.fromARGB(255, 133, 127, 127),
                                  ),
                                  // SizedBox(
                                  //   child: SingleChildScrollView(
                                  //     scrollDirection: Axis.horizontal,
                                  //     child: Column(
                                  //       children: [
                                  //         ButtonBar(
                                  //           children: [
                                  //             IconButton(
                                  //                 icon: const Icon(
                                  //                   Icons.edit,
                                  //                   color: Colors.blue,
                                  //                 ),
                                  //                 onPressed: () =>
                                  //                     _createOrUpdate(
                                  //                         documentSnapshot)),
                                  //             // This icon button is used to delete a single product
                                  //             IconButton(
                                  //                 icon: const Icon(Icons.delete,
                                  //                     color: Colors.red),
                                  //                 onPressed: () =>
                                  //                     _deleteProduct(
                                  //                         documentSnapshot.id)),
                                  //           ],
                                  //         ),
                                  //         // Press this button to edit a single product
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),

      // Add new product
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.orange,
      //   onPressed: () => _createOrUpdate(),
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
