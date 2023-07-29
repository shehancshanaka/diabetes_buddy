// ignore_for_file: public_member_api_docs

import 'package:about/about.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isIos = theme.platform == TargetPlatform.iOS ||
        theme.platform == TargetPlatform.macOS;

    final aboutPage = AboutPage(
      values: {
        'version': '1.0.0',
        'build': '1',
        'year': DateTime.now().year.toString(),
        'author': 'DIABETES BUDDY',
      },
      title: const Text('About'),
      applicationVersion: 'Version {{ version }}, ',
      applicationDescription: Center(
        child: const Text(
          ' ',
        ),
      ),
      applicationIcon:
          const Image(image: AssetImage('assets/Flash Screen-logo.png')),
      applicationLegalese: 'Copyright © {{ author }}, {{ year }}',
      children: const <Widget>[],
    );

    if (isIos) {
      return CupertinoApp(
        title: 'About Demo (Cupertino)',
        home: aboutPage,
        theme: CupertinoThemeData(
          brightness: theme.brightness,
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'About ',
      home: aboutPage,
      theme: ThemeData(),
      darkTheme: ThemeData(brightness: Brightness.dark),
    );
  }
}
