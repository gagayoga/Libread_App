import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../components/customTextField.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    const Color primary = Color(0xFFFF0000);
    const Color labelColor = Color(0xFF8A8586);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Image.asset(
                        'lib/assets/image/logo_black.png',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),

                    AutoSizeText(
                        'Login',
                      style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w700
                      ),
                    ),

                    textToRegister(),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CustomTextField(
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
                ),

                const SizedBox(
                  height: 20,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

                    Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 20),
                      child: SizedBox(
                        width: width,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: ()=> controller.login(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Obx(() => controller.loadinglogin.value?
                          const CircularProgressIndicator(
                            color: Colors.white,
                          ): Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                            ),
                          ),
                          ),
                        ),
                      ),
                    ),
                ]
                            ),


                  ],
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              'New to Libread?',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.offAllNamed(Routes.REGISTER);
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              visualDensity: VisualDensity.compact,
            ),
            child: FittedBox(
              child: Text('Register now',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF4CB3E0),
                    ),
                  )
    ),
            ),
        ],
      ),
    );
  }
}
