import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libread_ryan/components/customListBuku.dart';
import 'package:libread_ryan/components/customListBukuRekomendasi.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color background = Color(0xFF000000);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, _) => Scaffold(
        body: Container(
          color: background,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack( // Use Stack to position sectionUcapan on top
                  children: [
                    Image.asset(
                      'lib/assets/background/bg_home.png',
                      width: double.infinity,
                      height: 400.h,
                      fit: BoxFit.cover,
                    ),
                    sectionUcapan(),
                  ],
                ),
              ),

              SliverToBoxAdapter(
                child: sectionTrendingBuku(),
              ),


              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: sectionListBuku(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionUcapan() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 40.w),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'lib/assets/image/logo_white.svg',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),

            SizedBox(
              width: 10.w,
            ),

            Expanded(
              child: FittedBox(
                child: AutoSizeText(
                  'Libread Aplikasi Perpustakaan Digital Berbasis Mobile',
                  maxLines: 2,
                  minFontSize: 10,
                  maxFontSize: 16,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTrendingBuku(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Text(
            "Trending",
            style: GoogleFonts.amiko(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),

        SizedBox(
          height: 10.h,
        ),

        CustomListRekomendasiBuku(context: Get.context!),
      ],
    );
  }

  Widget sectionListBuku(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: Text(
            "View More",
            style: GoogleFonts.amiko(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),

        SizedBox(
          height: 10.h,
        ),

        Column(
          children: [
            CustomListBuku(context: Get.context!),
            CustomListBuku(context: Get.context!),
            CustomListBuku(context: Get.context!),
            CustomListBuku(context: Get.context!),
            CustomListBuku(context: Get.context!),
          ],
        )
      ],
    );
  }
}
