import 'package:get/get.dart';
import 'package:mongo_flutter/qr/qr_scanner.dart';

import 'display-controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
