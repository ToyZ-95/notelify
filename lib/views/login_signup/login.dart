import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notelify/constants/constant_styles.dart';
import 'package:notelify/utils/textfield_validations.dart';
import 'package:notelify/widgets/custom_textfield.dart';
import 'package:notelify/widgets/vertical_space.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpace(40.h),
                Text(
                  "Welcome,",
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 26.sp),
                ),
                VerticalSpace(
                  10.h,
                ),
                Text(
                  "Sign in to continue!",
                  style: TextStyle(
                      fontSize: 20.sp, color: ConstantStyle.greyColor),
                ),
                VerticalSpace(80.h),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        isTextFormField: true,
                        floatingLabelText: "Email ID",
                        textEditingController: emailTextEditingController,
                        validation: (val) => TextFieldValidations.instance
                            .emailValidations(val!),
                      ),
                      VerticalSpace(20.h),
                      CustomTextField(
                        isTextFormField: true,
                        floatingLabelText: "Password",
                        maskText: true,
                        textEditingController: passwordTextEditingController,
                      ),
                      VerticalSpace(10.h),
                      Row(
                        children: const [
                          Spacer(),
                          Text(
                            "Forgot Password?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      VerticalSpace(40.h),
                      GestureDetector(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFFFA578E),
                                    Color(0XFFFCAB8E)
                                  ]),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
