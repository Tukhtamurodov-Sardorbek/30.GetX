import 'package:get/get.dart';
import 'package:getxpattern4/controls/detail_page.dart';
import 'package:getxpattern4/controls/entry_page/sign_in_page.dart';
import 'package:getxpattern4/controls/entry_page/sign_up_page.dart';
import 'package:getxpattern4/controls/home_page.dart';

class DependencyInjectionService {
  static Future<void> init() async {
    //Get.put<PaymentController>(PaymentController());
    Get.lazyPut<SignUpController>(() => SignUpController(), fenix: true);
    Get.lazyPut<SignInController>(() => SignInController(), fenix: true);
    Get.lazyPut<DetailController>(() => DetailController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}