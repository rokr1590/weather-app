import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomColor{
  
  CustomColor._();

  static const Color lightGrey = Color(0xffcac5cb);
  static const Color mediumDarkGrey = Color(0xff757575);
  static const Color darkGrey = Color(0xff54656f);
  static const Color bgGrey = Color(0xffdfe5e7);
  static const Color buttonLightGreen = Color(0xffd9f5df);
  static const Color lineColorGrey = Color(0xff979797);

  //Status Bar UI Style
  static const SystemUiOverlayStyle lightStatusBar = SystemUiOverlayStyle(
        statusBarColor: CustomColor.bgGrey,
        statusBarIconBrightness: Brightness.dark
      );
}