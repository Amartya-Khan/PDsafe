import 'package:flutter/material.dart';
import 'package:pdsafe_defhacks/models/personal.dart';
import 'package:pdsafe_defhacks/models/user.dart';
import 'package:pdsafe_defhacks/profile/prior_diagnosis.dart';
import 'package:pdsafe_defhacks/profile/settings_form.dart';
import 'package:pdsafe_defhacks/profile/sympstoms_form.dart';
import 'package:pdsafe_defhacks/services/auth.dart';
import 'package:pdsafe_defhacks/services/database.dart';
import 'package:pdsafe_defhacks/shared/constants.dart';

import 'package:pdsafe_defhacks/widgets/loading.dart';
import 'package:pdsafe_defhacks/widgets/symptom_container.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  static String id = 'Profile';
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Provider.value(
              value: user,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: SettingsForm(),
              ),
            );
          });
    }

    void _showSymptomsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Provider.value(
              value: user,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: SymptomsForm(),
              ),
            );
          });
    }

    void _showPriorPD() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            final screen = MediaQuery.of(context).size;
            return Provider.value(
              value: user,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: PriorPD(),
              ),
            );
          });
    }

    return StreamProvider<List<Personal>>.value(
        value: DatabaseService().personalData,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: Text(
              "Profile",
              style: textStyle.copyWith(fontSize: 17),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: GestureDetector(
                  child: Tooltip(
                      child: Icon(Icons.exit_to_app), message: "Logout"),
                  onTap: () => _auth.signOut(),
                ),
              ),
            ],
          ),
          body: StreamBuilder<UserData>(
              stream: DatabaseService(uid: user.uid).userData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserData userData = snapshot.data;

                  return ListView(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: Text(
                        'Initial data is placeholder',
                        style: textStyle.copyWith(color: Colors.black),
                      )),
                      Center(
                          child: Text(
                        'Editing that saves your data to our database',
                        style: textStyle.copyWith(
                            color: Colors.black, fontSize: 12.5),
                      )),
                       SizedBox(
                        height: 25,
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:10.0),
                        child: Row(
                          children: [
                            Text(
                              'Personal details',
                              style: textStyle.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Text("Edit"),
                            IconButton(
                              iconSize: 30,
                              icon: Icon(
                                Icons.settings,
                                // color: Colors.white,
                              ),
                              color: Colors.deepPurpleAccent,
                              onPressed: () {
                                _showSettingsPanel();
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        
                        // color: Colors.grey[200],
                      
                       
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Name: ${userData.name}', style: textStyle.copyWith(color: Colors.black),),
                              Text('Gender: ${userData.gender}', style: textStyle.copyWith(color: Colors.black),),
                              Text('Age: ${userData.age}', style: textStyle.copyWith(color: Colors.black),)
                            ],
                          ),
                        ),
                      
                      SizedBox(
                        height: 20,
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              'Symptoms Noticed',
                              style: textStyle.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Text("Reset & Edit"),
                            IconButton(
                              iconSize: 30,
                              icon: Icon(
                                Icons.settings,
                                // color: Colors.white,
                              ),
                              color: Colors.deepPurpleAccent,
                              onPressed: () {
                                _showSymptomsPanel();
                              },
                            ),
                          ],
                        ),
                      ),
                      
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SymptomContainer(
                                currentState: userData.bladderProblems,
                                symptom: 'Bladder Problems',
                              ),
                              SymptomContainer(
                                currentState: userData.bloodPressureDrop,
                                symptom: 'Drop in Blood Pressure',
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SymptomContainer(
                                currentState: userData.bodyPain,
                                symptom: 'Body Ache',
                              ),
                              SymptomContainer(
                                currentState: userData.constipation,
                                symptom: 'Constipation',
                              ),
                              SymptomContainer(
                                currentState: userData.depression,
                                symptom: 'Depression',
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SymptomContainer(
                                currentState: userData.fatigue,
                                symptom: 'Fatigue',
                              ),
                              SymptomContainer(
                                currentState: userData.localisedPain,
                                symptom: 'Localised Pain',
                              ),
                              SymptomContainer(
                                currentState: userData.sexualDysfunction,
                                symptom: 'Sexual Dysfunction',
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SymptomContainer(
                                currentState: userData.sleepDisorders,
                                symptom: 'Sleep Disorders',
                              ),
                              SymptomContainer(
                                currentState: userData.smellDysfunction,
                                symptom: 'Smell Dysfunction',
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 25,),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Any prior PD',
                                  style: textStyle.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'diagnosis/treatment?',
                                  style: textStyle.copyWith(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Spacer(),
                            SymptomContainer(
                              currentState: userData.priorTreatment,
                              symptom: userData.priorTreatment ? 'Yes' : "No",
                            ),
                            Spacer(),
                            Text('Reset & Edit'),
                            IconButton(
                              iconSize: 30,
                              icon: Icon(
                                Icons.settings,
                                // color: Colors.white,
                              ),
                              color: Colors.deepPurpleAccent,
                              onPressed: () {
                                _showPriorPD();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  Loading();
                }
              }),
        ));
  }
}
