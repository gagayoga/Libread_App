import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libread_ryan/app/routes/app_pages.dart';

import '../../../data/model/buku/response_search_buku.dart';
import '../controllers/searchbook_controller.dart';

class SearchBookView extends GetView<SearchBookController> {
  const SearchBookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.refreshData();
        },
        child: SafeArea(
          child: Container(
            width: width,
            height: height,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,),
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    SizedBox(
                        height: height * 0.020
                    ),

                    TextFormField(
                      controller: controller.searchController,
                      style: GoogleFonts.inter(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      onChanged: (value) {
                        controller.getDataSearchBook();
                      },

                      decoration: InputDecoration(
                        filled: true,
                        hintText: "Search book here",
                        hintStyle: GoogleFonts.montserrat(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 1.8),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 1.8),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.030
                    ),

                    Obx((){
                      if (controller.searchController.text == '') {
                        return Column(
                          children: [
                            sectionLayoutBuku(height),
                          ],
                        );
                      }else {
                        return const SizedBox();
                      }
                    },
                    ),

                    LayoutBuku(),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget sectionLayoutBuku(double height){
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Trending",
              style: GoogleFonts.amiko(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            sectionTrendingBuku(),
          ],
        ),

        SizedBox(
            height: height * 0.035
        ),
      ],
    );
  }

  Widget LayoutBuku() {
    return Column(
      children: [
        Column(
          children: [
            Text(
              'For You',
              style: GoogleFonts.inter(
                  fontSize: 28.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700
              ),
              textAlign: TextAlign.start,
            ),

            Text(
              'Find out the intriguing secrets',
              style: GoogleFonts.inter(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w400
              ),
              textAlign: TextAlign.start,
            ),

            const SizedBox(
              height: 20,
            ),

            sectionAllBook(),
          ],
        ),
      ],
    );
  }

  Widget sectionTrendingBuku() {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.popularBooks.length > 3 ? 3 : controller.popularBooks.length,
          itemBuilder: (context, index) {
            var buku = controller.popularBooks[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    Routes.DETAILBOOK,
                    parameters: {
                      'id': (buku.bukuID ?? 0).toString(),
                      'judul': (buku.judul!).toString(),
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF424242).withOpacity(0.30),
                  ),
                  height: 100,
                  width: MediaQuery.of(Get.context!).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        buku.coverBuku.toString(),
                        width: 180,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                buku.judul!,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              Text(
                                buku.penulis!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget sectionAllBook(){
    return Obx((){
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.searchBook.length,
        itemBuilder: (context, index){
          var kategori = controller.searchBook[index].kategoriBuku;
          var bukuList = controller.searchBook[index].dataBuku;
          if (bukuList == null || bukuList.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    kategori!,
                    style: GoogleFonts.inter(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.20),
                          width: 0.2,
                        )
                    ),
                    child: Center(
                      child: Text(
                        'Belum ada bukuList dalam kategori ini',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    kategori!,
                    style: GoogleFonts.inter(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: bukuList.length,
                    itemBuilder: (context, index) {
                      DataBuku buku = bukuList[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: InkWell(
                          onTap: (){
                            Get.toNamed(
                              Routes.DETAILBOOK,
                              parameters: {
                                'id': (buku.bukuID ?? 0).toString(),
                                'judul': (buku.judul!).toString(),
                              },
                            );
                          },
                          child: SizedBox(
                            width: 145,
                            height: 240,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 145,
                                  height: 190,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      buku.coverBuku.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 5,
                                ),

                                Expanded(
                                  child: Text(
                                    buku.judul!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 16,
                                      letterSpacing: -0.3,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }

  Widget sectionDataKosong(String text){
    const Color background = Colors.white;
    const Color borderColor = Color(0xFF424242);
    return Center(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor,
              width: 1.3,
            )
        ),
        child: Center(
          child: Text(
            'Sorry Data $text Empty!',
            style: GoogleFonts.inter(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
