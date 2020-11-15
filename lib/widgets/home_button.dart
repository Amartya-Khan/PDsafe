import 'package:flutter/material.dart';
import 'package:pd_safe/screens/spiral_tests/spiral_dynamic.dart';
import 'package:pd_safe/screens/spiral_tests/spiral_photo.dart';
import 'package:pd_safe/screens/spiral_tests/spiral_static.dart';
import 'package:pd_safe/screens/wave_tests/wave_dynamic.dart';
import 'package:pd_safe/screens/wave_tests/wave_photo.dart';
import 'package:pd_safe/screens/wave_tests/wave_static.dart';
import 'package:pd_safe/shared/constants.dart';


class HomeButton extends StatelessWidget {
  final String text;
  final Color color;
  HomeButton({this.text, this.color});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: color,
        ),
        margin: EdgeInsets.all(10),
        height: height * 0.08,
        child: FlatButton(
          onPressed: () {
             if (text == "Take static spiral test") {
              Navigator.pushNamed(context, SpiralStatic.id);
            } else if (text == "Take dynamic spiral test") {
              Navigator.pushNamed(context, SpiralDynamic.id);
            } else if (text == "Take static wave test") {
              Navigator.pushNamed(context, WaveStatic.id);
            } else if (text == 'Take dynamic wave test') {
              Navigator.pushNamed(context, WaveDynamic.id);
            } else if (text == "Take spiral test") {
              Navigator.pushNamed(context, SpiralPhoto.id);
            } else if (text == "Take wave test") {
              Navigator.pushNamed(context, WavePhoto.id);
            }
          },
          child: Align(
              child: Text(
            '$text',
            style: textStyle.copyWith(color: Colors.white, fontSize: 15),
          )),
        ),
      ),
    );
  }
}
