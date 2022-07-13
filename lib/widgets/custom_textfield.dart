import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notelify/constants/constant_styles.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    this.floatingLabelText = "",
    this.maskText = false,
    this.textEditingController,
    this.isTextFormField = false,
    this.validation,
  }) : super(key: key);

  bool isTextFormField;
  String floatingLabelText;
  bool maskText;
  TextEditingController? textEditingController;
  Function(String?)? validation;

  @override
  Widget build(BuildContext context) {
    return isTextFormField
        ? createCustomTextFormField()
        : createCustomTextField();
  }

  TextField createCustomTextField() {
    return TextField(
      cursorColor: ConstantStyle.pinkColor,
      obscureText: maskText,
      controller: textEditingController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ConstantStyle.greyColor, width: 1.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ConstantStyle.pinkColor, width: 1.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        labelText: floatingLabelText,
        labelStyle: TextStyle(color: ConstantStyle.greyColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.only(left: 20.w),
      ),
    );
  }

  TextFormField createCustomTextFormField() {
    return TextFormField(
      cursorColor: ConstantStyle.pinkColor,
      obscureText: maskText,
      controller: textEditingController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ConstantStyle.greyColor, width: 1.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ConstantStyle.pinkColor, width: 1.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        labelText: floatingLabelText,
        labelStyle: TextStyle(color: ConstantStyle.greyColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.only(left: 20.w),
      ),
      validator: (val) => validation!(val),
    );
  }
}
