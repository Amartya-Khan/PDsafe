import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdsafe_defhacks/services/auth.dart';
import 'package:pdsafe_defhacks/shared/constants.dart';

class SignInPage extends StatefulWidget {
  final Function toggleView;

  SignInPage({this.toggleView});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();

  
  String _email = '';
  String _password = '';
  String error = '';
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
          decoration: BoxDecoration(color: bg),
          child: Scaffold(
            backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.deepPurpleAccent,
                title: Text("Sign In"),
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      child:
                          Center(child: Text( "Register")),
                      onTap: () async {
                        widget.toggleView();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      child: Tooltip(child: Icon(Icons.person), message: "Register"),
                      onTap: () async {
                        widget.toggleView();
                      },
                    ),
                  ),
                  
                ],
              ),
              body: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        SizedBox(height: 20),
                        TextFormField(
                          // autofocus: true,
                           cursorColor: Colors.deepPurple,
                          // autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            focusColor: Colors.deepPurple,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple), borderRadius: BorderRadius.circular(5)),
                              labelText: "Email", border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepPurple, width: 5.0, ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle: TextStyle(color: Colors.deepPurple)),
                          validator: (val) => val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() {
                              _email = val;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          cursorColor: Colors.deepPurple,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            focusColor: Colors.deepPurple,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple), borderRadius: BorderRadius.circular(5)),
                              labelText: "Password", border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepPurple, width: 5.0, ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle: TextStyle(color: Colors.deepPurple)),
                          validator: (val) => val.length < 6 ? 'Password should be longer than 6 characters' : null,
                          onChanged: (val) {
                            _password = val;
                          },
                        ),
                        SizedBox(height: 20),
                        RaisedButton(
                          
                          color: Colors.deepPurpleAccent,
                          shape:circularButton,
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text("Sign in", style: textStyle.copyWith(fontSize: 17),),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                print('valid');
                                var result = await _auth.signInWithEmailAndPassword(_email, _password);
                                if (result == null)
                                  setState(() {
                                    error = 'Could not sign in';
                                    isLoading = false;
                                  });
                              }
                            }),
                        SizedBox(height: 20),
                        Text(error),
                        SizedBox(height: MediaQuery.of(context).size.height*0.11),
                        SvgPicture.asset('assets/logo.svg', height: 120,)
                      ],
                    ),
                  )),
            ),
        );
  }
}
