import 'package:flutter/material.dart';
import 'package:pet_food/View/UiManager/Color.manager.dart';

class AppTheme {
  static ThemeData themeData({Color? color}) {
    return ThemeData(
        primaryColor: ColorManager.primary,
        textTheme: _textTheme(color: color),
        elevatedButtonTheme: _elevatedButtonTheme());
  }

  static TextTheme _textTheme({Color? color}) {
    return TextTheme(
      bodyLarge: TextStyle(
          color: color ?? ColorManager.light,
          fontSize: 20,
          fontFamily: 'Andika',
          fontWeight: FontWeight.w400),
      headlineLarge: TextStyle(
          color: color ?? ColorManager.light,
          fontSize: 40,
          fontFamily: 'Andika',
          fontWeight: FontWeight.w700),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(
      {Color? bg, Color? color}) {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: bg ?? ColorManager.primary,
      minimumSize: const Size(200, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    ));
  }
}
