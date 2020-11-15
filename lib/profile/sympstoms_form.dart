import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdsafe_defhacks/models/user.dart';
import 'package:pdsafe_defhacks/services/database.dart';
import 'package:pdsafe_defhacks/widgets/loading.dart';
import 'package:provider/provider.dart';

class SymptomsForm extends StatefulWidget {
  @override
  _SymptomsFormState createState() => _SymptomsFormState();
}

class _SymptomsFormState extends State<SymptomsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> genders = ['Male', 'Female', 'Other'];

  //form values
  bool _currentpriorTreatment = false;
  bool _currentdepression = false;
  bool _currentsleepDisorders = false;
  bool _currentbladderProblems = false;
  bool _currentconstipation = false;
  bool _currentbloodPressureDrop = false;
  bool _currentsmellDysfunction = false;
  bool _currentfatigue = false;
  bool _currentlocalisedPain = false;
  bool _currentbodyPain = false;
  bool _currentsexualDysfunction = false;

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: (_currentbladderProblems)
                              ? Colors.deepPurpleAccent
                              : Colors.grey,
                          textColor:  Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            setState(() {
                              _currentbladderProblems =
                                  !_currentbladderProblems;
                            });
                          },
                          child: Text(
                            "Bladder Problems",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: (_currentconstipation)
                              ? Colors.deepPurpleAccent
                              : Colors.grey,
                          textColor: 
                              Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            setState(() {
                              _currentconstipation = !_currentconstipation;
                            });
                          },
                          child: Text(
                            "Constipation",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: (_currentbodyPain)
                              ? Colors.deepPurpleAccent
                              : Colors.grey,
                          textColor:
                              Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            setState(() {
                              _currentbodyPain = !_currentbodyPain;
                            });
                          },
                          child: Text(
                            "Body Ache",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: (_currentbloodPressureDrop)
                              ? Colors.deepPurpleAccent
                              : Colors.grey,
                          textColor:  Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            setState(() {
                              _currentbloodPressureDrop =
                                  !_currentbloodPressureDrop;
                            });
                          },
                          child: Text(
                            "Drop in Blood pressure",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: (_currentdepression)
                              ? Colors.deepPurpleAccent
                              : Colors.grey,
                          textColor:  Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            setState(() {
                              _currentdepression = !_currentdepression;
                            });
                          },
                          child: Text(
                            "Depression",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: (_currentlocalisedPain)
                              ? Colors.deepPurpleAccent
                              : Colors.grey,
                          textColor:  Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            setState(() {
                              _currentlocalisedPain = !_currentlocalisedPain;
                            });
                          },
                          child: Text(
                            "Localised pain",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: (_currentfatigue)
                              ? Colors.deepPurpleAccent
                              : Colors.grey,
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            setState(() {
                              _currentfatigue = !_currentfatigue;
                            });
                          },
                          child: Text(
                            "Fatigue",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: (_currentsexualDysfunction)
                              ? Colors.deepPurpleAccent
                              : Colors.grey,
                          textColor: 
                              Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            setState(() {
                              _currentsexualDysfunction =
                                  !_currentsexualDysfunction;
                            });
                          },
                          child: Text(
                            "Sexual Dysfunction",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: (_currentsleepDisorders)
                              ? Colors.deepPurpleAccent
                              : Colors.grey,
                          textColor:  Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            setState(() {
                              _currentsleepDisorders = !_currentsleepDisorders;
                            });
                          },
                          child: Text(
                            "Sleeping disorder",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: (_currentsmellDysfunction)
                              ? Colors.deepPurpleAccent
                              : Colors.grey,
                          textColor:  Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            setState(() {
                              _currentsmellDysfunction =
                                  !_currentsmellDysfunction;
                            });
                          },
                          child: Text(
                            "Smell dysfunction",
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ],
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
                                  _currentdepression,
                                  _currentsleepDisorders,
                                  _currentbladderProblems,
                                  _currentconstipation,
                                  _currentbloodPressureDrop,
                                  _currentsmellDysfunction,
                                  _currentfatigue,
                                  _currentlocalisedPain,
                                  _currentbodyPain,
                                  _currentsexualDysfunction);
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
