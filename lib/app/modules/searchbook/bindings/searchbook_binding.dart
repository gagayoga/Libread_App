import 'package:get/get.dart';

import '../controllers/searchbook_controller.dart';

class SearchBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchBookController>(
      () => SearchBookController(),
    );
  }
}
