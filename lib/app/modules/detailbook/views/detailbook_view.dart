import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/buku/response_detail_buku.dart';
import '../controllers/detailbook_controller.dart';

class DetailbookView extends GetView<DetailbookController> {
  const DetailbookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final bodyHeight = height - 50;

    const Color background = Color(0xFF000000);

    final id = Get.parameters['id'];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          toolbarHeight: 50,
          titleSpacing: 0,
          title: Text(
            Get.parameters['judul'].toString(),
            style: GoogleFonts.inter(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.getDataDetailBuku(id);
          },
          child: Container(
            width: width,
            height: bodyHeight,
            color: background,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: kontenDataDetailBuku(),
            ),
          ),
        ));
  }

  Widget kontenDataDetailBuku() {
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;

    return Obx((){
        if (controller.detailDataBook.isNull) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF0000)),
              ),
            ),
          );
        } else if (controller.detailDataBook.value == null) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFF0000)),
              ),
            ),
          );
        } else {
          var dataBuku = controller.detailDataBook.value?.buku;
          var dataKategori = controller.detailDataBook.value?.kategori;
          var dataUlasan = controller.detailDataBook.value?.ulasan;
          return Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: SizedBox(
                  width: width,
                  height: height * 0.40,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xFF000000).withOpacity(0.40),
                          const Color(0xFF000000)
                        ],
                        stops: const [0, 0.8681],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.srcATop,
                    child: Image.network(
                      dataBuku!.coverBuku.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.050,
                    ),

                    Center(
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 135,
                            height: 190,
                            child: Image.network(
                              dataBuku.coverBuku.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),

                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 30,
                              color: const Color(0xFF5A5A5A).withOpacity(0.80),
                              child:  // Menampilkan rating di bawah teks penulis
                              Center(
                                child: RatingBarIndicator(
                                  rating: dataBuku.rating!,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemSize: 20,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Color(0xFFFF0000),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: height * 0.030,
                    ),

                    FittedBox(
                      child: Text(
                        dataBuku.judul!,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontSize: 26.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.005,
                    ),

                    FittedBox(
                      child: Text(
                        "Penerbit: ${dataBuku.penerbit!}",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(
                      height: height * 0.020,
                    ),

                    SizedBox(
                      width: 180,
                      height: 45,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (dataBuku.status == 'Tersimpan') {
                            controller.deleteKoleksiBook();
                          } else {
                            controller.addKoleksiBook();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: dataBuku.status == 'Tersimpan' ? const Color(0xFFFF0000) : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        icon: Icon(
                            dataBuku.status == 'Tersimpan' ? CupertinoIcons.bookmark_solid : Icons.bookmark_add_rounded,
                          color: dataBuku.status == 'Tersimpan' ? Colors.white : const Color(0xFFFF0000),
                        ),
                        label: FittedBox(
                          child: Text(
                            dataBuku.status == 'Tersimpan' ? 'Saved Book' : 'Add Bookmark',
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: dataBuku.status == 'Tersimpan' ? Colors.white : const Color(0xFFFF0000),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.015,
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(
                          height: height * 0.015,
                        ),

                        Text(
                          dataBuku.deskripsi!,
                          maxLines: 15,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.80),
                            fontSize: 14.0,
                            height: 1.5
                          ),
                          textAlign: TextAlign.justify,
                        ),

                        SizedBox(
                          height: height * 0.015,
                        ),

                        Text(
                          "Category Book",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),

                        SizedBox(
                          height: height * 0.010,
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: dataKategori!.map((kategori) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: TextButton(
                                onPressed: () {
                                  // Tambahkan fungsi yang ingin dijalankan saat tombol ditekan
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFFF5F5F5),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                ),
                                child: Text(
                                  kategori,
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black, // Sesuaikan dengan warna yang diinginkan
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        SizedBox(
                          height: height * 0.035,
                        ),

                        Text(
                          "Review Book",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),

                        SizedBox(
                          height: height * 0.010,
                        ),

                        buildUlasanList(dataUlasan),

                        SizedBox(
                          height: height * 0.035,
                        ),

                        SizedBox(
                          width: width,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (dataBuku.statusPeminjaman == 'Belum dipinjam') {
                                controller.showConfirmPeminjaman(() => Navigator.pop(Get.context!, 'OK'), 'Submit');
                              }else if(dataBuku.statusPeminjaman == 'Dipinjam'){
                                return;
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: dataBuku.statusPeminjaman == 'Belum dipinjam' ? const Color(0xFFFF0000) : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Text(
                              dataBuku.statusPeminjaman == 'Belum dipinjam'
                                  ? 'Borrow Book' : 'Borrowed',
                              style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: dataBuku.statusPeminjaman == 'Belum dipinjam'
                                      ? Colors.white : Colors.red
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: height * 0.025,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget buildUlasanList(List<Ulasan>? ulasanList) {
    final width = MediaQuery.of(Get.context!).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ulasanList != null && ulasanList.isNotEmpty
            ? ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ulasanList.length > 10 ? 10 : ulasanList.length,
          itemBuilder: (context, index) {
            Ulasan ulasan = ulasanList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF424242),
                      width: 0.5,
                    )),
                width: width,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'lib/assets/image/foto_profile.png',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.025,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  ulasan.users?.username ?? '',
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 14),
                                ),

                                const SizedBox(
                                  width: 5,
                                ),

                                // Menampilkan rating di bawah teks penulis
                                RatingBarIndicator(
                                  direction: Axis.horizontal,
                                  rating: ulasan.rating!.toDouble(),
                                  itemCount: 5,
                                  itemSize: 14,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 3,
                            ),

                            Text(
                              ulasan.ulasan ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )
            : Container(
          width: width,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFF424242),
              width: 0.5,
            ),
          ),
          child: Text(
            'There are no book reviews yet',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        InkWell(
          onTap: (){

          },
          child: Text(
            'Learn more here',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 12
            ),
          ),
        )
      ],
    );
  }
}
