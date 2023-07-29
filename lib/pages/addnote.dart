import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:diabites_buddy/pages/home.dart';
import '../main.dart';

class addnote extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            onPressed: () {
              ref.add({
                'title': title.text,
                'content': content.text,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Home()));
              });
            },
            child: Text(
              "save",
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                decorationColor: Colors.red,
                decorationStyle: TextDecorationStyle.wavy,
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(), shape: BoxShape.rectangle),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: 'title',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(), shape: BoxShape.rectangle),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: 'title',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(), shape: BoxShape.rectangle),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: 'title',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(), shape: BoxShape.rectangle),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: 'title',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(), shape: BoxShape.rectangle),
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: 'title',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
