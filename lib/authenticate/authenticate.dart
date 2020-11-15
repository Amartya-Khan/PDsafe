import 'package:flutter/material.dart';
import 'register.dart';
import 'sign_in.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = false;

  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn)
      return SignInPage(toggleView: toggleView);
    else
      return RegisterPage(toggleView: toggleView);
  }
}
