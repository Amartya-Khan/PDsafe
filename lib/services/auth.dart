import 'package:firebase_auth/firebase_auth.dart';
import 'package:pdsafe_defhacks/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences prefs;

  Stream<User> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  User _userFromFirebaseUser(User user) {
    return user != null ? user : null;
  }

  Future registerWithEmailAndPassword(
      String email, String password, String phoneNumber) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      // await addPhoneNumber(user, phoneNumber);
      await DatabaseService(uid: user.uid)
          .updatePersonalData("new name", "Male", 50, false, false, false, false, false, false, false,false, false, false, false);

          return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
      // return user != null;
    } catch (e) {
      print(e);
      return null;
    }
  }
//sign in anon
    Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  

  Future addPhoneNumber(User user, String phoneNumber) async {
    print(phoneNumber);
    await _auth.verifyPhoneNumber(
        phoneNumber: '+91 ' + phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("verified");
          user.linkWithCredential(credential);
//          prefs = await SharedPreferences.getInstance();
//          prefs.setBool("phoneVerified", true);
          return _userFromFirebaseUser(user);
          // return UserCredential != null;
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e);
          print("Verification Failed");
        },
        codeSent: (String verificationId, int resendToken) {
          print("code sent");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("timeout");
        });
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
