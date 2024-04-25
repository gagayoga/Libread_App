import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../components/customTabBar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/buku_controller.dart';

class BukuView extends GetView<BukuController> {
  const BukuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // const Color colorText = Color(0xFFEA1818);
    const Color background = Color(0xFF000000);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: background,
      statusBarIconBrightness: Brightness.light, // Change this color as needed
    ));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: background,
            title: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                height: 50,
                decoration: const BoxDecoration(
                  color: background,
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.white,
                  indicator: const BoxDecoration(
                    color: Color(0xFFFF0000),
                  ),
                  labelColor: const Color(0xFFFF0000),
                  unselectedLabelColor: const Color(0xFFFF0000),
                  tabs: [
                    CustomTabBar(
                        tittle: 'Borrow History',
                        onTap: () async{
                          await controller.getDataHistory();
                        },
                        count: controller.jumlahHistoryPeminjaman),
                    CustomTabBar(
                        tittle: 'Bookmarks',
                        onTap: () async{
                          await controller.getDataBookmark();
                        },
                        count: controller.jumlahKoleksiBook),
                  ],
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: TabBarView(
              children: [
                Container(
                  width: width,
                  height: height,
                  color: background,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.025,
                          ),

                          Obx(() => controller.historyPeminjaman.isEmpty ?
                              kontenDataKosong('History Peminjaman') : kontenHistoryPeminjaman(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width,
                  height: height,
                  color: background,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.025,
                          ),

                          Obx(() => controller.koleksiBook.isEmpty ?
                          kontenDataKosong('Bookmarks') : kontenKoleksiBuku(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget kontenHistoryPeminjaman() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: List.generate(
          controller.historyPeminjaman.length,
              (index) {
            var dataHistory = controller.historyPeminjaman[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Container(
                width: MediaQuery.of(Get.context!).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFF424242).withOpacity(0.30),
                ),
                height: 190,
                child: InkWell(
                  onTap: (){
                    dataHistory.status == 'Selesai' ? controller.kontenBeriUlasan(dataHistory.bukuId.toString(), dataHistory.judulBuku.toString()) :
                    controller.showBuktiPeminjaman(dataHistory.kodePeminjaman.toString(),
                        dataHistory.judulBuku.toString(), dataHistory.tanggalPinjam.toString(),
                        dataHistory.tanggalKembali.toString());
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Gambar di sebelah kiri
                      Flexible(
                        flex: 3,
                        child: SizedBox(
                          height: 190,
                          child: Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: 5 / 7,
                                child: Image.network(
                                  dataHistory.coverBuku.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Positioned(
                                left: 0,
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: dataHistory.status == 'Ditolak'
                                          ? const Color(0xFFEA1818)
                                          : dataHistory.status == 'Dipinjam'
                                          ? Colors.yellow
                                          : dataHistory.status ==
                                          'Selesai'
                                          ? Colors.green
                                          : const Color(0xFF1B1B1D),
                                      ),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          dataHistory.status == 'Selesai' ? const SizedBox() : const Icon(
                                            Icons.info,
                                            color: Colors.black,
                                            size: 20,
                                          ),


                                          dataHistory.status == 'Selesai' ? const SizedBox() : const SizedBox(
                                            width: 10,
                                          ),

                                          Text(
                                            dataHistory.status == 'Selesai' ? 'Beri Ulasan' : dataHistory.status.toString(),
                                            style: GoogleFonts.averiaGruesaLibre(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Flexible(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  'No: ${dataHistory.kodePeminjaman!}',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.5,
                                    color: Colors.white,
                                    fontSize: 24.0,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                dataHistory.judulBuku!,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              Text(
                                'Tanggal pinjam: ${dataHistory.tanggalPinjam!}',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Deadline: ${dataHistory.deadline}',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Tanggal kembali: ${dataHistory.tanggalKembali}',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 2,
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

  Widget kontenDataKosong(String text){
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

  Widget kontenKoleksiBuku() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.koleksiBook.length,
      itemBuilder: (context, index) {
        var dataKoleksi = controller.koleksiBook[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: InkWell(
            onTap: () {
              Get.toNamed(
                Routes.DETAILBOOK,
                parameters: {
                  'id': (dataKoleksi.bukuID ?? 0).toString(),
                  'judul': (dataKoleksi.judul!).toString(),
                },
              );
            },
            child: SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              height: 175,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 135,
                    height: 175,
                    child: AspectRatio(
                      aspectRatio: 4 / 5,
                      child: Image.network(
                        dataKoleksi.coverBuku.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 15,
                  ),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dataKoleksi.judul!,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)
                                      )
                                  ),
                                  onPressed: (){

                                  },
                                  child: Text(
                                    'Borrow Book',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 16.0,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child:Icon(
                                Icons.bookmark_added,
                                color: Colors.white,
                                size: 26,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
