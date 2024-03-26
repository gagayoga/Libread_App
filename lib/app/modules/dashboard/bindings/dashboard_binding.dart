import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libread_ryan/app/modules/buku/controllers/buku_controller.dart';
import 'package:libread_ryan/app/modules/home/controllers/home_controller.dart';
import 'package:libread_ryan/app/modules/profile/controllers/profile_controller.dart';
import 'package:libread_ryan/app/modules/searchbook/controllers/searchbook_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<SearchBookController>(
          () => SearchBookController(),
    );
    Get.lazyPut<BukuController>(
          () => BukuController(),
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );
  }
}
