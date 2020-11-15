import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:pdsafe_defhacks/ml_models/spiral_model.dart';
import 'package:permission_handler/permission_handler.dart';

class DrawingArea {
  Offset point;
  Paint areaPaint;

  DrawingArea({this.point, this.areaPaint});
}

class SpiralStatic extends StatefulWidget {
  static String id = 'SpiralStatic';
  @override
  _SpiralStaticState createState() => _SpiralStaticState();
}

class _SpiralStaticState extends State<SpiralStatic> {
  final GlobalKey globalKey = new GlobalKey();

  List<DrawingArea> points = [];
  Color selectedColor;
  double strokeWidth;
  bool toggleBlink = true;
  File _imageFile;

  Random rng = new Random();

  @override
  void initState() {
    super.initState();
    selectedColor = Colors.deepPurpleAccent;
    strokeWidth = 8.0;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Static Spiral Test', style: GoogleFonts.montserrat()),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                //color: Colors.white,
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
                ])),
          ),
          Positioned(
            // top: height * 0.0335,
            left: width * 0.015,
            child: RepaintBoundary(
                key: globalKey,
                child: Container(
                  height: height * 0.6,
                  width: width * 0.97,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                        )
                      ]),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: toggleBlink
                            ? SvgPicture.asset(
                                'assets/spiral10.svg',
                                height: height * 0.53,
                              )
                            : Container(),
                      ),
                      Container(
                        height: height * 0.75,
                        width: width * 0.95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //Padding(
                            //padding: const EdgeInsets.all(8.0),
                            //child:
                            Container(
                              width: width,
                              height: height * 0.6,
                              child: GestureDetector(
                                onPanDown: (details) {
                                  this.setState(() {
                                    points.add(DrawingArea(
                                        point: details.localPosition,
                                        areaPaint: Paint()
                                          ..strokeCap = StrokeCap.round
                                          ..isAntiAlias = true
                                          ..color = selectedColor
                                          ..strokeWidth = strokeWidth));
                                  });
                                },
                                onPanUpdate: (details) {
                                  this.setState(() {
                                    points.add(DrawingArea(
                                        point: details.localPosition,
                                        areaPaint: Paint()
                                          ..strokeCap = StrokeCap.round
                                          ..isAntiAlias = true
                                          ..color = selectedColor
                                          ..strokeWidth = strokeWidth));
                                  });
                                },
                                onPanEnd: (details) {
                                  this.setState(() {
                                    points.add(null);
                                  });
                                },
                                child: SizedBox.expand(
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    child: CustomPaint(
                                      painter: MyCustomPainter(points: points),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),

          Positioned(
            bottom: height * 0.03,
            // left: width * 0.001,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: width * 0.030),
                      width: width * 0.49,
                      height: height * 0.077,
                      decoration: BoxDecoration(),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            toggleBlink = !toggleBlink;
                            print(toggleBlink);
                          });
                        },
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              toggleBlink ? Icons.flash_off : Icons.flash_on,
                              color: toggleBlink ? Colors.red : Colors.green,
                            ),

                            // Text('[ON]')
                            Text(
                              toggleBlink ? 'Turn guide OFF' : 'Turn guide ON',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: height * 0.018,
                                    fontWeight: FontWeight.w500,
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
                      margin: EdgeInsets.all(5),
                      width: width * 0.45,
                      height: height * 0.077,
                      decoration: BoxDecoration(),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          this.setState(() {
                            points.clear();
                          });
                        },
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.layers_clear, color: Colors.deepPurple),
                            Spacer(),
                            Text(
                              'Clear drawing',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: height * 0.018,
                                      color: Colors.deepPurple)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.013,
                ),
                SizedBox(
                  height: height * 0.013,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: width * 0.95,
                  height: height * 0.09,
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.1, vertical: width * 0.025),
                          child: Column(
                            children: [
                              Text('Save as Image and diagnose',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: height * 0.02,
                                          color: Colors.deepPurple))),
                              Text('(guide must be OFF)',
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
                  height: height * 0.015,
                )
              ],
            ),
          ),
          // Positioned(
          //   bottom: 1,
          //   right: 0,
          //   child: _imageFile != null ? Image.file(_imageFile, height: 150,) : Container(),),
        ],
      ),
    );
  }

  Future<void> takeScreenShot() async {
    // setState(() {
    //   toggleBlink = false;
    // });
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

class MyCustomPainter extends CustomPainter {
  List<DrawingArea> points;

  MyCustomPainter({@required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()..color = Colors.transparent;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);
    canvas.clipRect(rect);

    for (int x = 0; x < points.length - 1; x++) {
      if (points[x] != null && points[x + 1] != null) {
        canvas.drawLine(
            points[x].point, points[x + 1].point, points[x].areaPaint);
      } else if (points[x] != null && points[x + 1] == null) {
        canvas.drawPoints(
            ui.PointMode.points, [points[x].point], points[x].areaPaint);
      }
    }
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) => true;
}
