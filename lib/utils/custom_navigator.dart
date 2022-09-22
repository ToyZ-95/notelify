import 'package:flutter/material.dart';

class CustomNavigator {
  CustomNavigator._();

  static CustomNavigator? _customNavigator;

  static CustomNavigator get instance {
    return _customNavigator ?? CustomNavigator._();
  }

  to(BuildContext context, Widget nextScreen, Function? exitScreenCallback) {
    Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => nextScreen))
        .then((value) => exitScreenCallback?.call());
  }

  replace(BuildContext context, Widget nextScreen) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => nextScreen));
  }

  pop(BuildContext context) {
    Navigator.pop(context);
  }
}
