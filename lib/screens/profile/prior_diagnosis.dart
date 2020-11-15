import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdsafe_defhacks/models/user.dart';
import 'package:pdsafe_defhacks/services/database.dart';
import 'package:pdsafe_defhacks/widgets/loading.dart';
import 'package:provider/provider.dart';

class PriorPD extends StatefulWidget {
  @override
  _PriorPDState createState() => _PriorPDState();
}

class _PriorPDState extends State<PriorPD> {
  final _formKey = GlobalKey<FormState>();
  final List<String> genders = ['Male', 'Female', 'Other'];

  //form values
  bool _currentpriorTreatment = false;

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
                      "Click on Yes/No to flip",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                 
                      Center(
                        child: Container(
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            color: (_currentpriorTreatment)
                                ? Colors.deepPurpleAccent
                                : Colors.grey,
                            textColor:  Colors.white,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {
                              setState(() {
                                _currentpriorTreatment =
                                    !_currentpriorTreatment;
                              });
                            },
                            child: Text(
                              _currentpriorTreatment?"Yes":"no",
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                  Center(
                    child: Container(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        color: Colors.blueAccent,
                        textColor: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        onPressed: () async {
                          await DatabaseService(uid: user.uid)
                              .updatePersonalData(
                                  userData.name,
                                  userData.gender,
                                  userData.age,
                                  _currentpriorTreatment,
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
                        },
                        child: Text(
                          "Update Symptoms",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
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
