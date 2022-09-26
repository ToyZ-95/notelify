import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notelify/constants/kstyles.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {Key? key,
      this.floatingLabelText = "",
      this.maskText = false,
      this.textEditingController,
      this.isTextFormField = false,
      this.validation,
      this.textInputAction = TextInputAction.done,
      this.suffixIcon})
      : super(key: key);

  bool isTextFormField;
  String floatingLabelText;
  bool maskText;
  TextEditingController? textEditingController;
  Function(String?)? validation;
  TextInputAction textInputAction;
  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return isTextFormField
        ? createCustomTextFormField()
        : createCustomTextField();
  }

  TextField createCustomTextField() {
    return TextField(
      cursorColor: KStyle.pinkColor,
      enableInteractiveSelection: true,
      obscureText: maskText,
      textInputAction: textInputAction,
      controller: textEditingController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: KStyle.greyColor, width: 1.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: KStyle.pinkColor, width: 1.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        labelText: floatingLabelText,
        labelStyle: TextStyle(color: KStyle.greyColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.only(left: 20.w),
      ),
    );
  }

  TextFormField createCustomTextFormField() {
    return TextFormField(
      cursorColor: KStyle.pinkColor,
      enableInteractiveSelection: true,
      textInputAction: textInputAction,
      obscureText: maskText,
      controller: textEditingController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: KStyle.greyColor, width: 1.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: KStyle.pinkColor, width: 1.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: KStyle.pinkColor, width: 1.5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        labelText: floatingLabelText,
        labelStyle: TextStyle(color: KStyle.greyColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.only(left: 20.w),
        suffixIcon: suffixIcon,
      ),
      validator: (val) => validation!(val),
    );
  }
}
