import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:libread_ryan/app/data/model/buku/response_search_buku.dart';


import '../../../data/constant/endpoint.dart';
import '../../../data/model/buku/response_popular_book.dart';
import '../../../data/provider/api_provider.dart';

class SearchBookController extends GetxController with StateMixin{

  var popularBooks = RxList<DataPopularBook>();
  var searchBook = RxList<DataSearch>();

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDataSearchBook();
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

  void refreshData() async{
    await getData();
    await getDataSearchBook();
  }

  Future<void> getData() async {
    popularBooks.clear();
    change(null, status: RxStatus.loading());

    try {
      final responsePopular = await ApiProvider.instance().get(Endpoint.bukuPopular);

      if (responsePopular.statusCode == 200) {
        final ResponsePopularBook responseBukuPopular = ResponsePopularBook.fromJson(responsePopular.data);

        if (responseBukuPopular.data!.isEmpty) {
          popularBooks.clear();
          change(null, status: RxStatus.empty());
        } else {
          popularBooks.assignAll(responseBukuPopular.data!);
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

  Future<void> getDataSearchBook() async {
    try {
      change(null, status: RxStatus.loading());

      final keyword = searchController.text.toString();
      final response;

      if (keyword == ''){
        response = await ApiProvider.instance().get('${Endpoint.searchBook}/null');
      }else{
        response = await ApiProvider.instance().get('${Endpoint.searchBook}/$keyword');
      }

      if (response.statusCode == 200) {
        final ResponseSearchBuku responseData = ResponseSearchBuku.fromJson(response.data);

        if (responseData.data!.isEmpty) {
          searchBook.clear();
          change(null, status: RxStatus.empty());
        } else {
          searchBook.assignAll(responseData.data!);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['Message'] ?? "Unknown error";
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
