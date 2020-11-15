class CustomUser {
  //collection ref
  // final CollectionReference userCollection = Firestore.collection('users');

  String uid;

  CustomUser({
    this.uid,
  });

//   CustomUser.fromData(Map<String, dynamic> data)
//       : uid = data['uid'],
//         name = data['name'],
//         email = data['email'];

//   //function to upload to firebase, converts user obj to a firebase json obj
//   Map<String, dynamic> toJson() {
//     return {
//       'uid': uid,
//       'name': name,
//       'email': email,
//     };
//   }
}

class UserData {
  final String uid;
  final String name;
  final String gender;
  final int age;
   bool priorTreatment;
   bool depression;
   bool sleepDisorders;
   bool bladderProblems;
   bool constipation;
   bool bloodPressureDrop;
   bool smellDysfunction;
   bool fatigue;
   bool localisedPain;
  bool bodyPain;
   bool sexualDysfunction;


  UserData({this.uid, this.name, this.gender, this.age, this.priorTreatment, this.depression, this.sleepDisorders, this.bladderProblems, this.constipation, this.bloodPressureDrop, this.smellDysfunction, this.fatigue, this.localisedPain, this.bodyPain, this.sexualDysfunction});
}
