import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/constants/kimages.dart';
import 'package:notelify/constants/kstyles.dart';
import 'package:notelify/controllers/user_controller.dart';
import 'package:notelify/utils/custom_navigator.dart';
import 'package:notelify/utils/textfield_validations.dart';
import 'package:notelify/views/dashboard/dashboard.dart';
import 'package:notelify/views/login_signup/login.dart';
import 'package:notelify/widgets/custom_textfield.dart';
import 'package:notelify/widgets/vertical_space.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpace(40.h),
                Text(
                  "Create Account,",
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 26.sp),
                ),
                VerticalSpace(
                  10.h,
                ),
                Text(
                  "Sign up to get started!",
                  style: TextStyle(fontSize: 20.sp, color: KStyle.greyColor),
                ),
                VerticalSpace(20.h),
                Image.asset(
                  KImages.signUpImage,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        isTextFormField: true,
                        floatingLabelText: "Full Name",
                        textEditingController: fullNameTextEditingController,
                        textInputAction: TextInputAction.next,
                        validation: (val) => TextFieldValidations.instance
                            .fullNameValidations(val!),
                      ),
                      VerticalSpace(20.h),
                      CustomTextField(
                        isTextFormField: true,
                        floatingLabelText: "Email ID",
                        textEditingController: emailTextEditingController,
                        textInputAction: TextInputAction.next,
                        validation: (val) => TextFieldValidations.instance
                            .emailValidations(val!),
                      ),
                      VerticalSpace(20.h),
                      CustomTextField(
                        isTextFormField: true,
                        floatingLabelText: "Password",
                        maskText: true,
                        textEditingController: passwordTextEditingController,
                        textInputAction: TextInputAction.next,
                        validation: (val) => TextFieldValidations.instance
                            .passwordValidations(val!),
                      ),
                      VerticalSpace(20.h),
                      CustomTextField(
                        isTextFormField: true,
                        floatingLabelText: "Confirm Password",
                        maskText: true,
                        textEditingController:
                            confirmPasswordTextEditingController,
                        validation: (val) => TextFieldValidations.instance
                            .confirmPasswordValidations(
                                val!, passwordTextEditingController.text),
                      ),
                      VerticalSpace(20.h),
                      GetBuilder<UserController>(builder: (userController) {
                        return GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              if (await userController.signUpUser(
                                  emailTextEditingController.text,
                                  passwordTextEditingController.text,
                                  fullNameTextEditingController.text)) {
                                CustomNavigator.instance
                                    .replace(context, const Dashboard());
                              }
                            }
                          },
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
                            child: userController.isUserLoading
                                ? SizedBox(
                                    height: 15.h,
                                    width: 15.w,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.sp,
                                    ),
                                  )
                                : Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.sp),
                                  ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                VerticalSpace(40.h),
                Center(
                  child: Wrap(
                    spacing: 2.w,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          CustomNavigator.instance.replace(context, Login());
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFA578E)),
                        ),
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
