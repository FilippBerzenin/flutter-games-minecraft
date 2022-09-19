import 'package:get/get.dart';

import '../main_class.dart';

class GlobalGameReference {
  late MainGame gameRefernce;

  static GlobalGameReference get instance {
    return Get.put(GlobalGameReference());
  }
}
