import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libread_ryan/app/routes/app_pages.dart';

import '../../../../components/customTextFieldProfile.dart';
import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class ProfileController extends GetxController {

  final loadinglogin = false.obs;
  final loading = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordlamaController = TextEditingController();
  final TextEditingController passwordbaruController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isPasswordHidden2 = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  logout() async {
    loadinglogin(true);
    try {
      FocusScope.of(Get.context!).unfocus();

      var response = await ApiProvider.instance().post(
          Endpoint.logout
      );

      if (response.statusCode == 200) {

        StorageProvider.clearAll();
        Get.snackbar("Success", "Logout successfully, please login here",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.snackbar("Sorry", "Logout failed",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );
      }
      loadinglogin(false);
    } on DioException catch (e) {
      loadinglogin(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.red, colorText: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
          );
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );
      }
    } catch (e) {
      loadinglogin(false);
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
      );
    }
  }


  updateProfilePassword() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        var response = await ApiProvider.instance().patch(Endpoint.updatePassword,
            data:
            {
              "PasswordLama" : passwordlamaController.text.toString(),
              "PasswordBaru" : passwordbaruController.text.toString(),
            }
        );
        if (response.statusCode == 200) {
          passwordlamaController.text = '';
          passwordbaruController.text = '';
          Get.snackbar(
              "Sorry",
              "Update password berhasil",
              backgroundColor: Colors.green,
              colorText: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
          );
          Navigator.pop(Get.context!, 'OK');

        } else {
          Get.snackbar(
              "Sorry",
              "Update password gagal, Coba kembali",
              backgroundColor: Colors.red,
              colorText: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
          );
        }
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          Get.snackbar("Sorry", "${e.response?.data['Message']}",
              backgroundColor: Colors.red, colorText: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
          );
        }
      } else {
        Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );
      }
    } catch (e) {
      loading(false);
      Get.snackbar(
          "Error", e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
      );
    }
  }


  // Bukti Peminjaman Buku
  Future<void> showBuktiPeminjaman() async {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SizedBox(
          width: MediaQuery.of(Get.context!).size.width,
          child: AlertDialog(
            backgroundColor: const Color(0xFFD3D3D3),
            title: Text(
              'Update Password',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                fontSize: 24.0,
                color: Colors.black,
              ),
            ),

            content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: SizedBox(
                  width: MediaQuery.of(Get.context!).size.width,
                  child: ListBody(
                    children: <Widget>[

                      const SizedBox(
                        height: 20,
                      ),

                      Text(
                        "Password Lama",
                        style: GoogleFonts.inriaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),

                      Obx(() => CustomTextFieldProfile(
                        controller: passwordlamaController,
                        hinText: 'Password Lama',
                        obsureText: isPasswordHidden.value,
                        surficeIcon: InkWell(
                          child: Icon(
                            isPasswordHidden.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20,
                            color: Colors.red,
                          ),
                          onTap: () {
                            isPasswordHidden.value =
                            !isPasswordHidden.value;
                          },
                        ),
                        preficIcon: const Icon(Icons.lock),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleasse input telepon';
                          }

                          return null;
                        },
                      )),

                      const SizedBox(
                        height: 10,
                      ),

                      Text(
                        "Password Baru",
                        style: GoogleFonts.inriaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),

                      Obx(() => CustomTextFieldProfile(
                        controller: passwordbaruController,
                        hinText: 'Password Baru',
                        obsureText: isPasswordHidden2.value,
                        surficeIcon: InkWell(
                          child: Icon(
                            isPasswordHidden2.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20,
                            color: Colors.red,
                          ),
                          onTap: () {
                            isPasswordHidden2.value =
                            !isPasswordHidden2.value;
                          },
                        ),
                        preficIcon: const Icon(Icons.lock),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Pleasse input telepon';
                          }

                          return null;
                        },
                      )),
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              SizedBox(
                width: MediaQuery.of(Get.context!).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    width: MediaQuery.of(Get.context!).size.width,
                    height: 45,
                    child: TextButton(
                      autofocus: true,
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        backgroundColor: const Color(0xFF1B1B1D),
                        animationDuration: const Duration(milliseconds: 300),
                      ),
                      onPressed: (){
                        updateProfilePassword();
                      },
                      child: Text(
                        'Finally',
                        style: GoogleFonts.inter(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
