
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdsafe_defhacks/models/user.dart';
import 'package:pdsafe_defhacks/services/database.dart';
import 'package:pdsafe_defhacks/shared/constants.dart';
import 'package:pdsafe_defhacks/widgets/loading.dart';

import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> genders = ['Male', 'Female', 'Other'];

  //form values
  String _currentName;
  String _currentGender;
  int _currentAge;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Update Personal Details",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Name:'),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //dropdown
                  Text('Gender:'),
                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField(
                      decoration: textInputDecoration,
                      value: _currentGender ?? userData.gender,
                      items: genders.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text('$gender'),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _currentGender = val)),
                  //slider
                  SizedBox(height: 10),
                  Text('Age:'),

                  Slider(
                    value: (_currentAge ?? userData.age).toDouble(),
                    // activeColor: Colors.brown[_currentAge ?? 20],
                    // inactiveColor: Colors.brown[_currentAge ?? 20],
                    min: 20,
                    max: 100,
                    divisions: 80,
                    label: "$_currentAge",
                    onChanged: (val) =>
                        setState(() => _currentAge = val.round()),
                  ),

                  //button
                  Center(
                    child: RaisedButton(
                        color: Colors.blueAccent,
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid)
                                .updatePersonalData(
                                    _currentName ?? userData.name,
                                    _currentGender ?? userData.gender,
                                    _currentAge ?? userData.age,
                                    userData.priorTreatment,
                                    userData.depression,
                                    userData.sleepDisorders,
                                    userData.bladderProblems,
                                    userData.constipation,
                                    userData.bloodPressureDrop,
                                    userData.smellDysfunction,
                                    userData.fatigue,
                                    userData.localisedPain,
                                    userData.bodyPain,
                                    userData.sexualDysfunction);
                            Navigator.pop(context);
                          }
                          print(_currentName);
                          print(_currentGender);
                          print(_currentAge);
                        }),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
