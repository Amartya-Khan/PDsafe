import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdsafe_defhacks/authenticate/authenticate.dart';
import 'package:pdsafe_defhacks/screens/home/home.dart';
import 'package:pdsafe_defhacks/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool _isOTPVerified = true;
  AuthService _auth = AuthService();
  SharedPreferences _prefs;

  @override
  void initState() {
//    checkIfVerified();
    super.initState();
  }
  checkIfVerified() async {
    _prefs = await SharedPreferences.getInstance();
    _isOTPVerified = _prefs.getBool('phoneVerified');
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null)
      return Authenticate();
    else
      return Home();
  }
}
