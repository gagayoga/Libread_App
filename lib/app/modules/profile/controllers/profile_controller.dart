import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libread_ryan/app/routes/app_pages.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class ProfileController extends GetxController {

  final loadinglogin = false.obs;

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
}
