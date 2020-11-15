import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdsafe_defhacks/models/personal.dart';
import 'package:pdsafe_defhacks/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference personalDataCollection =
      FirebaseFirestore.instance.collection('personalData');

  Future<void> updatePersonalData(String name, String gender, int age, bool priorTreatment, bool depression, bool sleepDisorders, bool bladderProblems, bool constipation, bool bloodPressureDrop, bool smellDysfunction, bool fatigue, bool localisedPain, bool bodyPain, bool sexualDysfunction   ) async {
//we're searching for the document based on uid
    return await personalDataCollection.doc(uid).set({
      'name': name,
      'gender': gender,
      'age': age,
      'priorTreatment': priorTreatment,
      'depression': depression,
      'sleepDisorders': sleepDisorders,
      'bladderProblems': bladderProblems,
  'constipation': constipation,
   'bloodPressureDrop': bloodPressureDrop,
  'smellDysfunction': smellDysfunction,
  'fatigue': fatigue,
  'localisedPain': localisedPain,
  'bodyPain': bodyPain,
  'sexualDysfunction': sexualDysfunction,
    });
  }

  //personal data list from snapshot
  List<Personal> _personalDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Personal(
        name: e.data()['name'] ?? '',
        gender: e.data()['gender'] ?? '',
        age: e.data()['age'] ?? 0,
        bladderProblems: e.data()['bladderProblems'] ?? false,
        bloodPressureDrop: e.data()['bloodPressureDrop'] ?? false,
        bodyPain: e.data()['bodyPain'] ?? false,
        constipation: e.data()['constipation'] ?? false,
        depression: e.data()['depression'] ?? false,
        fatigue: e.data()['fatigue'] ?? false,
        localisedPain: e.data()['localisedPain'] ?? false,
        priorTreatment: e.data()['priorTreatment'] ?? false,
        sexualDysfunction: e.data()['sexualDysfunction'] ?? false,
        sleepDisorders: e.data()['sleepDisorders'] ?? false,
        smellDysfunction: e.data()['smellDysfunction'] ?? false,

        
        
      );
    }).toList();
  }

//personal user data from stream
  UserData _personalDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      gender: snapshot.data()['gender'],
      age: snapshot.data()['age'],
      bladderProblems: snapshot.data()['bladderProblems'],
      bloodPressureDrop: snapshot.data()['bloodPressureDrop'],
      bodyPain: snapshot.data()['bodyPain'],
      constipation: snapshot.data()['constipation'],
      depression: snapshot.data()['depression'],
      fatigue: snapshot.data()['fatigue'],
      localisedPain: snapshot.data()['localisedPain'],
      priorTreatment: snapshot.data()['priorTreatment'],
      sexualDysfunction: snapshot.data()['sexualDysfunction'],
      sleepDisorders: snapshot.data()['sleepDisorders'],
      smellDysfunction: snapshot.data()['smellDysfunction'] 
    );
  }

//get personalData stream
  Stream<List<Personal>> get personalData {
    return personalDataCollection
        .snapshots()
        .map(_personalDataListFromSnapshot);
  }

//get user doc stream
  Stream<UserData> get userData {
    return personalDataCollection
        .doc(uid)
        .snapshots()
        .map(_personalDataFromSnapshot);
  }
}
