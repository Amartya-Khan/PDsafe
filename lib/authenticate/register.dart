import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdsafe_defhacks/services/auth.dart';
import 'package:pdsafe_defhacks/shared/constants.dart';
class RegisterPage extends StatefulWidget {
  final Function toggleView;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RegisterPage({this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();

  String _email = '';
  String _password = '';
  String _phoneNumber = '';
  String error = '';
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
          decoration: BoxDecoration(color: bg),
          child: Scaffold(
            backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.deepPurpleAccent,
                title: Text("Register", style: textStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w500),),
                actions: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      child:
                          Center(child: Text( "Sign In")),
                      onTap: () async {
                        widget.toggleView();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      child:
                          Tooltip(child: Icon(Icons.person), message: "Sign in"),
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
                          cursorColor: Colors.deepPurple,
                          // autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            focusColor:Colors.deepPurple,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple), borderRadius: BorderRadius.circular(5)),
                              labelText: "Email", border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepPurple, width: 5.0, ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle: TextStyle(color: Colors.deepPurple)),
                              
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
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
                          // autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            focusColor: Colors.deepPurple,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple), borderRadius: BorderRadius.circular(5)),
                              labelText: "Password", border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepPurple, width: 5.0, ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle: TextStyle(color: Colors.deepPurple)),
                              
                          validator: (val) => val.length < 6
                              ? 'Password should be longer than 6 characters'
                              : null,
                          onChanged: (val) {
                            _password = val;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          keyboardType: TextInputType.number,
                           cursorColor: Colors.deepPurple,
                          // autofocus: true,
                          decoration: InputDecoration(
                            focusColor: Colors.deepPurple,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple), borderRadius: BorderRadius.circular(5)),
                              labelText: "Phone Number", border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.deepPurple, width: 5.0, ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle: TextStyle(color: Colors.deepPurple)),
                          validator: (val) => val.length != 10
                              ? 'Phone Number should be 10 characters'
                              : null,
                          onChanged: (val) {
                            _phoneNumber = val;
                          },
                        ),
                        SizedBox(height: 20),
                        RaisedButton(
                          color: Colors.deepPurpleAccent,
                          shape:circularButton,
                            child: Text("Register", style: textStyle.copyWith(fontSize: 17),),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                var result =
                                    await _auth.registerWithEmailAndPassword(
                                        _email, _password, _phoneNumber);
                                if (result == null)
                                  setState(() {
                                    error = 'Need valid email and password';
                                    isLoading = false;
                                  });
                              }
                            }),
                        SizedBox(height: MediaQuery.of(context).size.height*0.01),
                        Text(error),
                        SizedBox(height: MediaQuery.of(context).size.height*0.01),
                        SvgPicture.asset('assets/logo.svg', height: 120,)
                      ],
                    ),
                  )),
            ),
        );
  }
}
