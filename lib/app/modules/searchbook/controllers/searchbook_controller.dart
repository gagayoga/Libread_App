import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:libread_ryan/app/data/model/response_book.dart';


import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_book_new.dart';
import '../../../data/model/response_popular_book.dart';
import '../../../data/provider/api_provider.dart';

class SearchBookController extends GetxController with StateMixin{

  var dataAllBook = Rxn<List<DataBook>>();

  @override
  void onInit() {
    super.onInit();
    getDataBook();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Get Data Buku
  Future<void> getDataBook() async{
    change(null, status: RxStatus.loading());

    try {

      final response = await ApiProvider.instance().get(Endpoint.buku,);
      if (response.statusCode == 200) {
        final ResponseBook responseBuku = ResponseBook.fromJson(response.data);
        if(responseBuku.data!.isEmpty){
          change(null, status: RxStatus.empty());
        }else{
          dataAllBook(responseBuku.data!);
          change(responseBuku.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }

    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          change(null, status: RxStatus.error("${e.response?.data['message']}"));
        }
      } else {
        change(null, status: RxStatus.error(e.message ?? ""));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
