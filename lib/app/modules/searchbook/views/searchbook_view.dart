import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:libread_ryan/app/modules/home/controllers/home_controller.dart';

import '../../../data/model/response_book.dart';
import '../controllers/searchbook_controller.dart';

class SearchBookView extends GetView<SearchBookController> {
  const SearchBookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
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
                    style: GoogleFonts.inter(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
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
                    height: height * 0.020
                  ),

                  sectionTrendingBuku(),

                  SizedBox(
                      height: height * 0.030
                  ),

                  kontenSemuaBuku(),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget sectionTrendingBuku() {
    final width = MediaQuery.of(Get.context!).size.width;
    final widthContainer = width - 20.0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Trending",
          style: GoogleFonts.amiko(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 15,
        ),

        GetBuilder<HomeController>(
          builder: (controller) {
            if (controller.popularBooks.isNull) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEA1818)),
                ),
              );
            } else if (controller.popularBooks.value == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEA1818)),
                ),
              );
            }else {
              return SizedBox(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.popularBooks.value!.map((buku) {
                        return InkWell(
                          onTap: () {
                            // Implementasi logika ketika buku ditekan
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              width: widthContainer,
                              height: 175,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFF5F5F5).withOpacity(
                                    0.50),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery
                                        .of(Get.context!)
                                        .size
                                        .width,
                                    height: 120,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        buku.coverBuku.toString(),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        FittedBox(
                                          child: Text(
                                            buku.judul!,
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              fontSize: 16.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        FittedBox(
                                          child: Text(
                                            buku.penulis!,
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 14.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
              );
            }
          },
        ),
      ],
    );
  }

  Widget kontenSemuaBuku(){
    return  Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Obx(() {
            if (controller.dataAllBook.isNull) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEA1818)),
                ),
              );
            } else if (controller.dataAllBook.value!.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFEA1818)),
                ),
              );
            }else{
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.dataAllBook.value!.length,
                itemBuilder: (context, index){
                  var kategori = controller.dataAllBook.value![index].kategoriBuku;
                  var bukuList = controller.dataAllBook.value![index].dataBuku;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            kategori!,
                            style: GoogleFonts.inriaSans(
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
                          height: 280, // Sesuaikan tinggi container sesuai kebutuhan Anda
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: bukuList!.length,
                            itemBuilder: (context, index) {
                              DataBuku buku = bukuList[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: InkWell(
                                  onTap: (){
                                  },
                                  child: SizedBox(
                                    width: 135,
                                    height: 145,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: AspectRatio(
                                            aspectRatio: 3 / 4,
                                            child: Image.network(
                                              buku.coverBuku.toString(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            border: Border.all(
                                              color: Colors.grey.withOpacity(0.30), // Warna garis pinggir
                                              width: 0.5, // Lebar garis pinggir
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [

                                                const SizedBox(
                                                  height: 5,
                                                ),

                                                FittedBox(
                                                  child: Text(
                                                    buku.judul!,
                                                    style: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w800,
                                                        color: Colors.white,
                                                        fontSize: 14.0
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height: 2,
                                                ),

                                                FittedBox(
                                                  child: Text(
                                                    '${buku.jumlahHalaman!} Halaman',
                                                    style: GoogleFonts.inter(
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.white,
                                                        fontSize: 10.0
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),

                                                const SizedBox(
                                                  height: 5,
                                                ),

                                                // Menampilkan rating di bawah teks penulis
                                                buku.rating != null && buku.rating! > 0
                                                    ? RatingBar.builder(
                                                  initialRating: buku.rating!,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 15,
                                                  itemBuilder: (context, _) => const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                  },
                                                )
                                                    : RatingBar.builder(
                                                  initialRating: 5,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemSize: 15,
                                                  itemBuilder: (context, _) => const Icon(
                                                    Icons.star,
                                                    color: Colors.grey,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                  },
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),

                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    InkWell(
                                                      onTap: (){},
                                                      child: const Icon(
                                                        Icons.info_outline,
                                                        color: Colors.white,
                                                        size: 24,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: (){},
                                                      child: const Icon(
                                                        Icons.bookmark_outline,
                                                        color: Colors.white,
                                                        size: 24,
                                                      ),
                                                    ),
                                                  ],
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
                      ),
                    ],
                  );
                },
              );
            }
          }
          )
        ],
      ),
    );
  }
}
