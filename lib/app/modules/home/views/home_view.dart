import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Color
    const Color background = Color(0xFF000000);
    const Color textYellow = Color(0xFFFAFF00);

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light, // Change this color as needed
    ));

    return Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.getData();
          },
          child: Container(
                width: width,
                height: height,
                color: background,
                child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'lib/assets/background/bg_home.png',
                    width: double.infinity,
                    height: 450.h,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: sectionUcapan(),
                  ),

                  Positioned(
                      bottom: 50,
                      right: 0,
                      left: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: RichText(
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              text: TextSpan(
                                text: 'Welcome to our application ',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Libread',
                                    style: GoogleFonts.inter(
                                      color: textYellow,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            height: height * 0.025,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Step into a world of knowledge and wonder as you explore our "
                                  "digital library. We're thrilled to have you join us on this "
                                  "literary adventure, where every book holds the promise of "
                                  "discovery and excitement",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.3,
                                height: 1.4
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          SizedBox(
                            height: height * 0.015,
                          ),

                          Text(
                            'Start Exploring Now!',
                            style: GoogleFonts.inter(
                                color: textYellow,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                     )
                  )
                ],
              ),

              Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                child: SizedBox(
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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

                      const SizedBox(
                        height: 20,
                      ),

                      Obx(() => controller.popularBooks.isEmpty ?
                          shimmerTrendingBuku() : sectionTrendingBuku(),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                child: SizedBox(
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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

                      Obx(() => controller.newBooks.isEmpty ?
                      shimmerSectionListBuku() : sectionListBuku(),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),),),
        )
    );
  }

  Widget sectionUcapan() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 40.w),
      child: SizedBox(
        width: 50,
        height: 50,
        child: SvgPicture.asset(
          'lib/assets/image/logo_white.svg',
          height: 50,
          width: 50,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget sectionTrendingBuku() {
    return SizedBox(
      height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...controller.popularBooks.map((buku) {
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    Routes.DETAILBOOK,
                    parameters: {
                      'id': (buku.bukuID ?? 0).toString(),
                      'judul': (buku.judul!).toString(),
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: AspectRatio(
                            aspectRatio: 4 / 4,
                            child: Image.network(
                              buku.coverBuku.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: AspectRatio(
                  aspectRatio: 4 / 4,
                  child: GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      color: Colors.grey.withOpacity(0.20), // Adjust color as needed
                      child: Center(
                        child: Text(
                          'View More',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget shimmerTrendingBuku(){
    int itemCount = 4;
    
    return Shimmer.fromColors(
      baseColor: Colors.black.withOpacity(0.30),
      highlightColor: Colors.grey.shade50,
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 100,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: AspectRatio(
                    aspectRatio: 4/4,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget sectionListBuku() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 4,
      ),
      itemCount: controller.newBooks.length,
      itemBuilder: (context, index) {
        var buku = controller.newBooks[index];
        return InkWell(
          onTap: () {
            Get.toNamed(
              Routes.DETAILBOOK,
              parameters: {
                'id': (buku.bukuID ?? 0).toString(),
                'judul': (buku.judulBuku!).toString(),
              },
            );
          },
          child: SizedBox(
            child: AspectRatio(
              aspectRatio: 4 / 4,
              child: Image.network(
                buku.coverBuku.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget shimmerSectionListBuku() {
    int itemCount = 6;

    return Shimmer.fromColors(
      baseColor: Colors.black.withOpacity(0.30),
      highlightColor: Colors.grey.shade50,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 3 / 4,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return SizedBox(
            child: AspectRatio(
              aspectRatio: 4 / 4,
              child: Container(
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }

}
