import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import 'package:diabites_buddy/common/google_sign_in.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(0),
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              Container(
                  margin: EdgeInsets.all(30.0),
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Flash Screen-logo.png"),
                      fit: BoxFit.fitWidth,
                    ),
                    //    borderRadius: BorderRadius.circular(10),
                    // color: Colors.white.withOpacity(0.1),
                  )),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Hey There,\nWelcome Back',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SocialLoginButton(
                  buttonType: SocialLoginButtonType.google,
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);

                    provider.googleLogin();
                  },
                  mode: SocialLoginButtonMode.multi,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
      );
}
