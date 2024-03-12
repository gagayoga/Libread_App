import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:libread_ryan/app/routes/app_pages.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  const SplashscreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    const Color backgroundColor = Color(0xFF000000);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future.delayed(
      const Duration(milliseconds: 4000),
            () => Get.offAllNamed(Routes.LOGIN)
    );

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: backgroundColor,
        child: Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: SvgPicture.asset(
              'lib/assets/image/logo_white.svg',
            ),
          )
        ),
      )
    );
  }
}
