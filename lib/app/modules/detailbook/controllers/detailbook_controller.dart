import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_detail_book.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class DetailbookController extends GetxController with StateMixin {

  final loading = false.obs;

  var detailDataBook = Rxn<DataDetailBook>();
  final id = Get.parameters['id'];

  @override
  void onInit() {
    super.onInit();
    getDataDetailBuku(id);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataDetailBuku(String? idBuku) async {
    change(null, status: RxStatus.loading());

    try {
      final responseDataDetailBook = await ApiProvider.instance().get(
          '${Endpoint.detailBuku}/$idBuku');

      if (responseDataDetailBook.statusCode == 200) {
        final ResponseDetailBook dataDetailBook = ResponseDetailBook.fromJson(responseDataDetailBook.data);

        if (dataDetailBook.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          detailDataBook(dataDetailBook.data);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  addKoleksiBook() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var userID = StorageProvider.read(StorageKey.idUser).toString();
      var bukuID = id.toString();

      var response = await ApiProvider.instance().post(
        Endpoint.koleksiBuku,
        data: {
          "UserID": userID,
          "BukuID": bukuID,
        },
      );

      if (response.statusCode == 201) {
        String judulBuku = Get.parameters['judul'].toString();
        Get.snackbar("Success", "Add $judulBuku to bookmark, succesfully", backgroundColor: Colors.green,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );
        getDataDetailBuku(bukuID);
      } else {
        Get.snackbar(
            "Sorry",
            "Add bookmark failed",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );
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
        Get.snackbar("Sorry", e.message.toString(), backgroundColor: Colors.red,
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

  deleteKoleksiBook() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var userID = StorageProvider.read(StorageKey.idUser).toString();
      var bukuID = id.toString();

      var response = await ApiProvider.instance().delete(
        '${Endpoint.deleteKoleksi}$userID/koleksi/$bukuID');

      if (response.statusCode == 200) {
        String judulBuku = Get.parameters['judul'].toString();
        Get.snackbar("Success", "Delete $judulBuku to bookmark, succesfully", backgroundColor: Colors.green,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );
        getDataDetailBuku(bukuID);
      } else {
        Get.snackbar(
            "Sorry",
            "Add bookmark failed",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
        );
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
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
      loading(false);
      Get.snackbar(
          "Error", e.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
      );
    }
  }
}
