import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
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
    const Color primary = Color(0xFFFF0000);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, _)=> Scaffold(
        body: SafeArea(
          child: Container(
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
                        'lib/assets/image/logo_black.svg',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),

                      SizedBox(
                        height: 5.h,
                      ),

                      AutoSizeText(
                        'Register',
                        style: GoogleFonts.inter(
                            color: Colors.black,
                            fontSize: 35.0,
                            fontWeight: FontWeight.w700
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
                                fontSize: 23,
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
                  color: Colors.black),
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
