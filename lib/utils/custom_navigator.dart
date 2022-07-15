import 'package:flutter/material.dart';

class CustomNavigator {
  CustomNavigator._();

  static CustomNavigator? _customNavigator;

  static CustomNavigator get instance {
    return _customNavigator ?? CustomNavigator._();
  }

  to(BuildContext context, Widget nextScreen) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => nextScreen));
  }

  replace(BuildContext context, Widget nextScreen) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => nextScreen));
  }
}
