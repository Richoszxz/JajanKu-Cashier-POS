import 'package:flutter/material.dart';

class AppSize {
  static double lebar (BuildContext context) => MediaQuery.of(context).size.width;
  static double tinggi (BuildContext context) => MediaQuery.of(context).size.height;
  static EdgeInsets padding (BuildContext context) => MediaQuery.of(context).padding;
}