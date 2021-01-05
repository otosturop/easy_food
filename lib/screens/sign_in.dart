import 'package:easy_food/ui/social_log_in_button.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign In",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
                ),
                SizedBox(height: 8.0),
                SocialLoginButton(
                  buttonText: "Login with Google Account",
                  onPressed: () {},
                  buttonColor: Colors.white,
                  textColor: Colors.black87,
                  buttonIcon: Image.asset("assets/google.png"),
                )
              ],
            ),
          )),
    );
  }
}
