import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../components/customTextField.dart';
import '../../../routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    const Color primary = Color(0xFFFF0000);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,// Change this color as needed
    ));

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, _)=> Scaffold(
        body: SafeArea(
          child: Container(
            width: width,
            height: height,
            color: Colors.black,
            child: Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        height: 30.h,
                      ),

                      SvgPicture.asset(
                        'lib/assets/image/logo_white.svg',
                        fit: BoxFit.cover,
                        width: 75,
                        height: 75,
                      ),

                      SizedBox(
                        height: 10.h,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Text(
                          'Sign up to make your personal account',
                          maxLines: 2,
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 28.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.7,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 15.h,
                      ),

                      Text(
                        'Create your account.',
                        maxLines: 1,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600
                        ),
                      ),

                      SizedBox(
                        height: 15.h,
                      ),

                      CustomTextField(
                        labelText: "Username",
                        controller: controller.usernameController,
                        hinText: "Ryan Waskita",
                        obsureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleasse input username';
                          }

                          return null;
                        },
                      ),

                      SizedBox(
                        height: 5.h,
                      ),

                      CustomTextField(
                        labelText: "Email",
                        controller: controller.emailController,
                        hinText: "ryan@smk.belajar.id",
                        obsureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleasse input email address';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Email address tidak sesuai';
                          }else if (!value.endsWith('@smk.belajar.id')){
                            return 'Email harus @smk.belajar.id';
                          }

                          return null;
                        },
                      ),

                      SizedBox(
                        height: 5.h,
                      ),

                      Obx(() =>
                          CustomTextField(
                            labelText: "Password",
                            controller: controller.passwordController,
                            hinText: "password",
                            obsureText: controller.isPasswordHidden.value,

                            suffixIcon: InkWell(
                              child: Icon(
                                controller.isPasswordHidden.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                                color: primary,
                              ),
                              onTap: () {
                                controller.isPasswordHidden.value =
                                !controller.isPasswordHidden.value;
                              },
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Pleasse input password';
                              }
                              return null;
                            },
                          ),
                      ),

                      SizedBox(
                        height: 30.h,
                      ),

                      SizedBox(
                        width: width,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: ()=> controller.registerPost(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Obx(() => controller.loadinglogin.value?
                          const CircularProgressIndicator(
                            color: Colors.white,
                          ): const Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),
                          ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 15.h,
                      ),

                      textToRegister(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textToRegister() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              'Already have an account??',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.offAllNamed(Routes.LOGIN);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
            ),
            child: FittedBox(
              child: Text('Login',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4CB3E0),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
