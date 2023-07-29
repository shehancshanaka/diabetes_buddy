import 'package:flutter/material.dart';

class Donate extends StatelessWidget {
  const Donate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donate For App"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Container(
              child: Text(" * Turn on you location Services"),
            ),
          )
        ],
      ),
    );
  }
}
