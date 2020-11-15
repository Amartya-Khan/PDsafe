import 'dart:typed_data';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdsafe_defhacks/ml_models/spiral_model.dart';
import 'package:pdsafe_defhacks/shared/constants.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_cropper/image_cropper.dart';

class SpiralPhoto extends StatefulWidget {
  const SpiralPhoto({Key key}) : super(key: key);
  static String id = 'Spiral Photo';

  @override
  _SpiralPhotoState createState() => _SpiralPhotoState();
}

class _SpiralPhotoState extends State<SpiralPhoto> {
  final GlobalKey globalKey = new GlobalKey();
  File _image;
  final picker = ImagePicker();

  Future getCameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
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

  @override
  Widget build(BuildContext context) {
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

              // Color.fromRGBO(138, 35, 135, 1.0),
              // Color.fromRGBO(233, 64, 87, 1.0),
              // Color.fromRGBO(242, 113, 33, 1.0),
            ]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // Colors.deepPurple,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepPurpleAccent,
          title: Text('Spiral Photo Test', style: GoogleFonts.montserrat()),
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
                              ? Center(child: Text('No image selected', style: textStyle,))
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
                            fontSize: height * 0.0215,
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
             SizedBox(
              height: height * 0.013,
            ),
            Container(
              width: width * 0.8,
              height: height * 0.077,
              decoration: BoxDecoration(),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Colors.white,
                onPressed: () {
                  takeScreenShot();
                  Navigator.pushNamed(context, SpiralModel.id);
                },
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.save_alt, color: Colors.deepPurple),
                    Spacer(),
                    Text(
                      'Save to gallery and diagnose',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: height * 0.0215,
                              color: Colors.deepPurple)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.013,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: width * 0.8,
              height: height * 0.09,
              decoration: BoxDecoration(),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Colors.white,
                onPressed: () {
                  // takeScreenShot();
                  Navigator.pushNamed(context, SpiralModel.id);
                },
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(Icons.image, color: Colors.deepPurple),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.0, vertical: width * 0.025),
                      child: Column(
                        children: [
                          Text('Directly pick gallery',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: height * 0.0215,
                                      color: Colors.deepPurple))),
                          Text('image and diagnose',
                              textAlign: TextAlign.right,
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: height * 0.0215,
                                      color: Colors.deepPurple))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
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
}
