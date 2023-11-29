import 'package:flutter/material.dart';

class AppColors {

  AppColors._();

  static const Color appThemeColor =  Color(0xff28B67E);
  static const Color yelow = Color(0xffDDCF15);
 static const Color grennlight =  Color(0xFF8CC63F);
  static const MaterialColor appMaterialColor = MaterialColor(
    _appThemeColorPrimaryValue,
    <int, Color>{
      50: Color(0xff28B67E),
      100: Color(0xff28B67E),
      200: Color(0xff28B67E),
      300: Color(0xff28B67E),
      400: Color(0xff28B67E),
      500: Color(_appThemeColorPrimaryValue),
      600: Color(0xff28B67E),
      700: Color(0xff28B67E),
      800: Color(0xff28B67E),
      900: Color(0xff28B67E),
    },
  );
  static const int _appThemeColorPrimaryValue = 0xff28B67E;


}


