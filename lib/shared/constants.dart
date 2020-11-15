import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

var textStyle = GoogleFonts.montserrat(
    textStyle: TextStyle(color: Colors.white, fontSize: 15));

RoundedRectangleBorder circularButton=  RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10),
);

Color teal = Color(0xff51C9DA);
Color lightTeal = Color(0xff87D7E2);
Color darkTeal = Color(0xff4DB4C3);
Color orange = Color(0xffF24E29);
Color darkBrown = Color(0xff383C45);
Color darkGrey = Color(0xffDDE1E2);
Color lightGrey = Color(0xffF8F8F8);
Color bg = Color(0xffFAFAFA);

