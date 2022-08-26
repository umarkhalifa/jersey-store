import 'package:flutter/material.dart';
// !APP ACCENT COLOR
const Color kRed = Color(0xffFF0000);

TextStyle kHead = const TextStyle(
  fontFamily: "Medium",
  color: Colors.white
);

// !APP DARK COLOR
const Color kBlue = Color(0xff2058b7);

// !APP GREY ACCENT COLOR
 Color kGrey = Colors.grey.shade50;

// APP GRADIENT
LinearGradient kGradient = const LinearGradient(colors: [
  Color(0xff184694),
  Color(0xff010938),
], begin: Alignment.topLeft, end: Alignment.bottomRight);

// !APP BACKGROUND COLOR
const Color kBackground =  Color(0xffF5FAFA);

// !LEAGUE PAGE CONTROLLER
final PageController controller =
PageController(viewportFraction: 0.7, initialPage: 0);

// !SIZES LIST
List<String> sizes = ['S','M','L','XL'];

// !SCREEN HEIGHT
double getHeight (BuildContext context){
  return MediaQuery.of(context).size.height;
}

// !SCREEN WIDTH
double getWidth (BuildContext context){
  return MediaQuery.of(context).size.width;
}

//!LIST OF LEAGUES


// !ANIMATION DURATION
const Duration duration =  Duration(milliseconds: 400);