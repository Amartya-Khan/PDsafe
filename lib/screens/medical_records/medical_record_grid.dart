import 'dart:typed_data';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pdsafe_defhacks/screens/medical_records/add_documents.dart';
import 'package:pdsafe_defhacks/services/auth.dart';
import 'package:pdsafe_defhacks/shared/constants.dart';
import 'dart:async';

import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'image_view.dart';

class MedicalRecordList extends StatefulWidget {
  static String id = 'Medical Record List';
  String uidPassed;
  MedicalRecordList({this.uidPassed});
  @override
  _MedicalRecordListState createState() => _MedicalRecordListState();
}

class _MedicalRecordListState extends State<MedicalRecordList> {
  final AuthService _auth = AuthService();

  final GlobalKey globalKey = new GlobalKey();
  File _image;
  final picker = ImagePicker();
  Future _future;
  List medical;
  Future fetchMed(String uid) async {
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('personalData')
        .doc(uid)
        .get();
    if (doc.exists)
      setState(() {
        medical = doc.data()['medical'];
      });
    else
      setState(() {
        medical = [];
      });
  }

  @override
  void initState() {
    super.initState();
    _future = fetchMed(widget.uidPassed);
  }

  @override
  Widget build(BuildContext context) {

    String link;
    final user = Provider.of<User>(context);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // stops: [0.4, 0.7, 0.95],
            colors: [
              
              Colors.deepPurpleAccent,
              Colors.deepPurple,
              Colors.deepPurple[600]
            ]),

      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // Colors.deepPurple,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Medical Records', style: GoogleFonts.montserrat()),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                child:
                    Tooltip(child: Icon(Icons.exit_to_app), message: "Logout"),
                onTap: () => _auth.signOut(),
              ),
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: height*0.03),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.030),
                width: width * 0.45,
                height: height * 0.077,
                decoration: BoxDecoration(),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, AddDocument.id);
                  },
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.deepPurple,
                      ),
                      Spacer(),

                      // Text('[ON]')
                      Text(
                        'Add new documents',
                        style: textStyle.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color:
                                  // toggleBlink?
                                  Colors.deepPurple,
                              //  :Colors.deepPurple
                            
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
                height: 400,
                width: 100,
                child: FutureBuilder(
                    future: _future,
                    builder: (ctx, index) {
                      if (medical == null) return Text(widget.uidPassed, style: TextStyle(color: Colors.transparent),);
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 15,
                        crossAxisSpacing: 5,),

                          itemCount: medical == null ? 0 : medical.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 100,
                              width: 100,
                              child: Container(
                                height: 100,
                                width: 100,
                                  child: InkWell(
                                child: Image.network(medical[index]),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ImageExp(
                                              medical: medical[index])));
                                },
                              )),
                            );
                          });
                    }))
          ],
        ),
      ),
    );
  }

  Future<void> takeScreenShot() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    print(pngBytes);
    //Request permissions if not already granted
    if (!(await Permission.storage.status.isGranted))
      await Permission.storage.request();

    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(pngBytes),
      quality: 100,
      // name: "spiral_static"
    );
    print(result);
  }
}
