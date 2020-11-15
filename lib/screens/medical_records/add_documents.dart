import 'dart:typed_data';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:math';
// import 'package:flutter/services.dart';
import 'package:image/image.dart' as Im;
import 'package:pdsafe_defhacks/services/auth.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as Path;
import 'package:random_string/random_string.dart';

final Reference storageRef = FirebaseStorage.instance.ref();

class AddDocument extends StatefulWidget {
  final AuthService _auth = AuthService();
  static String id = 'Add Document';

  @override
  _AddDocumentState createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  final AuthService _auth = AuthService();
  final GlobalKey globalKey = new GlobalKey();
  File _image;
  File file;
  final picker = ImagePicker();
  String _uploadFileURL;
  CollectionReference imgColRef;
  String postId = Uuid().v4();

  @override
  void initState() {
    imgColRef = FirebaseFirestore.instance.collection('imageURLs');
    super.initState();
  }

  Future getCameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        retrieveLostData();
      }
    });
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image = File(response.file.path);
      });
    } else {
      print(response.file);
    }
  }

  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _image.path,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepPurple,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),

      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      // ratioX: 1.0,
      // ratioY: 1.0,
      // maxWidth: 512,
      // maxHeight: 512,
      // toolbarColor: Colors.purple,
      // toolbarWidgetColor: Colors.white,
      // toolbarTitle: 'Crop It'
    );

    setState(() {
      _image = cropped ?? _image;
    });
  }

  void _clear() {
    setState(() {
      _image = null;
    });
  }

  //---------------------------------
  Future uploadImageAkash(String uid) async {
    UploadTask _uploadTask;
    debugPrint("UID IS" + uid);
    Reference _storageReference = FirebaseStorage.instance
        .ref()
        .child("images/${Path.basename(_image.path)}");
    _uploadTask = _storageReference.putFile(_image);
    await _uploadTask.whenComplete(() async {
      final DocumentSnapshot medical = await FirebaseFirestore.instance
          .collection("personalData")
          .doc(uid)
          .get();
      _storageReference.getDownloadURL().then((fileURL) async {
        var med = medical.data()['medical'];
        med = med == null ? [] : med;
        await med.add(fileURL);
        debugPrint(uid.toString());
        await FirebaseFirestore.instance
            .collection("personalData")
            .doc(uid)
            .update({'medical': med});
        await imgColRef.add({'url': _uploadFileURL});
        print('link added to database');
      });
    });
  }
  //---------------------------------

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);
    // final user = Provider.of<User>(context);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurpleAccent,
              Colors.deepPurple,
              Colors.deepPurple[800],
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // Colors.deepPurple,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepPurpleAccent,
          title: Text('New Medical Document', style: GoogleFonts.montserrat()),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: RepaintBoundary(
                      key: globalKey,
                      child: Container(
                          color: Colors.transparent,
                          height: 300,
                          width: 300,
                          child: _image == null
                              ? Center(child: Text('No image selected'))
                              : Image.file(
                                  _image,
                                  height: 300,
                                )),
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Icon(
                    Icons.crop,
                    color: Colors.white,
                  ),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  onPressed: _clear,
                ),
              ],
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.030),
              width: width * 0.8,
              height: height * 0.077,
              decoration: BoxDecoration(),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Colors.white,
                onPressed: getCameraImage,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.add_a_photo,
                      color: Colors.deepPurple,
                    ),

                    // Text('[ON]')
                    Spacer(),
                    Text(
                      'Take image from camera',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color:
                                // toggleBlink?
                                Colors.deepPurple
                            //  :Colors.deepPurple
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.030),
              width: width * 0.8,
              height: height * 0.077,
              decoration: BoxDecoration(),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Colors.white,
                onPressed: getImageGallery,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.image,
                      color: Colors.deepPurple,
                    ),
                    Spacer(),

                    // Text('[ON]')
                    Text(
                      'Add new documents from gallery',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color:
                                // toggleBlink?
                                Colors.deepPurple
                            //  :Colors.deepPurple
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.030),
              width: width * 0.8,
              height: height * 0.077,
              decoration: BoxDecoration(),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Colors.white,
                onPressed: () async {
                  // await uploadFile();
                  await uploadImageAkash(user.uid);
                  Navigator.pop(context);
                },
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      Icons.cloud_upload,
                      color: Colors.deepPurple,
                    ),

                    // Text('[ON]')
                    Spacer(),
                    Text(
                      'Upload image to firebase',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color:
                                // toggleBlink?
                                Colors.deepPurple
                            //  :Colors.deepPurple
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Uploader(file: _image),

            SizedBox(
              height: height * 0.013,
            )
          ],
        ),
        // floatingActionButton: Row(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: <Widget>[
        //     FloatingActionButton(
        //       heroTag: 'button1',
        //       onPressed: getCameraImage,
        //       tooltip: 'Pick camera image',
        //       child: Icon(Icons.add_a_photo),
        //     ),
        //     FloatingActionButton(
        //         heroTag: 'button2',
        //         onPressed: getImageGallery,
        //         tooltip: 'Pick gallery image',
        //         child: Icon(Icons.image))
        //   ],
        // ),
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
  // String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
  //     length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future uploadFile() async {
    // String random = randomString(8);
    // String out = 'images/' + random;
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child("images/${Path.basename(_image.path)}");
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() {
      print('file uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _uploadFileURL = fileURL;
        });
      }).whenComplete(() async {
        await imgColRef.add({'url': _uploadFileURL});
        print('link added to database');
      });
    });
  }
}

Future<String> uploadImage(imageFile) async {
  String random = randomString(8);
  String out = 'images/' + random;
  UploadTask uploadTask = storageRef.child(out).putFile(imageFile);
  TaskSnapshot storageSnap = await uploadTask.whenComplete(() {});
  String downloadUrl = await storageSnap.ref.getDownloadURL();
  return downloadUrl;
}
