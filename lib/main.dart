import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdsafe_defhacks/screens/wrapper.dart';
import 'package:pdsafe_defhacks/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent)); //transparent status bar
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

//check
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: "",
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: {
          SpiralStatic.id: (context) => SpiralStatic(),
          SpiralDynamic.id: (context) => SpiralDynamic(),
          WaveStatic.id: (context) => WaveStatic(),
          WaveDynamic.id: (context) => WaveDynamic(),
          TestSelection.id: (context) => TestSelection(),
          SpiralModel.id: (context) => SpiralModel(),
          Profile.id: (context) => Profile(),
          WaveModel.id: (context) => WaveModel(),
          SpiralPhoto.id: (context) => SpiralPhoto(),
          WavePhoto.id: (context) => WavePhoto(),
          AddDocument.id: (context) => AddDocument(),
          
        },
      ),
    );
  }
}
