import 'package:get/get.dart';
import 'package:getx_pattern2/controls/detail_page.dart';
import 'package:getx_pattern2/controls/entry_page/sign_in_page.dart';
import 'package:getx_pattern2/controls/entry_page/sign_up_page.dart';
import 'package:getx_pattern2/controls/home_page.dart';

class ControllersBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<SignUpController>(SignUpController());
    Get.put<SignInControllers>(SignInControllers());
    Get.put<HomeController>(HomeController());
    Get.put<DetailController>(DetailController());
  }

}