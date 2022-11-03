import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hw_reader/presentation/shared/palette/palette.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    fontFamily: "Chakra",
    primarySwatch: Palette.material,
    primaryColor: Palette.main,
    // appBarTheme
    appBarTheme: const AppBarTheme(
      backgroundColor: Palette.secondary,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Palette.white),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Palette.secondary,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
    scaffoldBackgroundColor: Palette.secondary,
  );
}
