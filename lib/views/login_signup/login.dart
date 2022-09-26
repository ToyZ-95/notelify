import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notelify/constants/kimages.dart';
import 'package:notelify/constants/kstyles.dart';
import 'package:notelify/controllers/user_controller.dart';
import 'package:notelify/utils/custom_navigator.dart';
import 'package:notelify/utils/textfield_validations.dart';
import 'package:notelify/views/dashboard/dashboard.dart';
import 'package:notelify/views/login_signup/signup.dart';
import 'package:notelify/widgets/custom_textfield.dart';
import 'package:notelify/widgets/vertical_space.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  final bool _showPassword = false;

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
                  "Welcome,",
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 26.sp),
                ),
                VerticalSpace(
                  10.h,
                ),
                Text(
                  "Sign in to continue!",
                  style: TextStyle(fontSize: 20.sp, color: KStyle.greyColor),
                ),
                VerticalSpace(20.h),
                Image.asset(
                  KImages.loginImage,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        isTextFormField: true,
                        floatingLabelText: "Email ID",
                        textEditingController: emailTextEditingController,
                        textInputAction: TextInputAction.next,
                        validation: (val) => TextFieldValidations.instance
                            .emailValidations(val!),
                      ),
                      VerticalSpace(20.h),
                      GetBuilder<UserController>(
                        builder: (userController) {
                          return CustomTextField(
                            isTextFormField: true,
                            floatingLabelText: "Password",
                            maskText:
                                userController.showPassword ? false : true,
                            textEditingController:
                                passwordTextEditingController,
                            validation: (val) => TextFieldValidations.instance
                                .passwordValidations(val!),
                            suffixIcon: IconButton(
                              onPressed: () {
                                userController.showHidePassword();
                              },
                              icon: Icon(
                                userController.showPassword
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
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
                      GetBuilder<UserController>(builder: (userController) {
                        return GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              if (await userController.loginUser(
                                  emailTextEditingController.text,
                                  passwordTextEditingController.text)) {
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
                                    "Login",
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
                        "Don't have an account?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          CustomNavigator.instance.replace(context, SignUp());
                        },
                        child: const Text(
                          "Sign Up",
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
