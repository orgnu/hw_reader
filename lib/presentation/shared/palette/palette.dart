import 'package:flutter/material.dart';

class Palette {
  Palette._();
  static const Color main = Color(0xFF68c3c9);
  static const Color secondary = Color(0xFFE7ECEF);
  static const Color accent = Color(0xFF4BBE83);
  static const Color red = Color(0xFFE74C3C);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const MaterialColor material = MaterialColor(
    0xFF68c3c9,
    <int, Color>{
      50: Color.fromRGBO(104, 195, 201, .1), //10%
      100: Color.fromRGBO(104, 195, 201, .2),
      200: Color.fromRGBO(104, 195, 201, .3),
      300: Color.fromRGBO(104, 195, 201, .4),
      400: Color.fromRGBO(104, 195, 201, .5),
      500: Color.fromRGBO(104, 195, 201, .6),
      600: Color.fromRGBO(104, 195, 201, .7),
      700: Color.fromRGBO(104, 195, 201, .8),
      800: Color.fromRGBO(104, 195, 201, .9),
      900: Color.fromRGBO(104, 195, 201, 1), //100%
    },
  );
}
