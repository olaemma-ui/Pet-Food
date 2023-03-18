import 'package:flutter/material.dart';

class ColorManager {
  static Color secondary = '#E5E5E5'.hex();
  static Color primary = '#3E8B3A'.hex();
  static Color light = '#F4F4F4'.hex();
  static Color dark = '#404040'.hex();
}

extension HexColor on String {
  Color hex() {
    return Color(int.parse(replaceAll('#', '0xFF')));
  }
}
