import 'package:prishathe/Controller/UserController.dart';
import 'package:get/get.dart';
import 'package:prishathe/Widgets/network/NetworkManger.dart';

import '../Controller/NewproductController.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NetworkManager());
    Get.put(UserController());
    Get.put(NewProductController());
  }
}