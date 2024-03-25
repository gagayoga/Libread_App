import 'package:get/get.dart';
import 'package:libread_ryan/app/data/model/response_book.dart';
import 'package:libread_ryan/app/data/model/response_popular_book.dart';
import 'package:dio/dio.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';

class BukuController extends GetxController with StateMixin{
  var allBooks = Rxn<List<DataBook>>();
  var popularBooks = Rxn<List<DataPopularBook>>();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getData() async {
    change(null, status: RxStatus.loading());

    try {
      final responseAll = await ApiProvider.instance().get(Endpoint.buku);
      final responsePopular = await ApiProvider.instance().get(Endpoint.bukuPopular);

      if (responseAll.statusCode == 200 && responsePopular.statusCode == 200) {
        final ResponseBook responseBuku = ResponseBook.fromJson(responseAll.data);
        final ResponsePopularBook responseBukuPopular = ResponsePopularBook.fromJson(responsePopular.data);

        if (responseBuku.data!.isEmpty && responseBukuPopular.data!.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          allBooks(responseBuku.data!);
          popularBooks(responseBukuPopular.data!);
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
}
