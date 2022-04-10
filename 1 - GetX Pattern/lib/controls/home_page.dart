import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_pattern1/models/post_model.dart';
import 'package:getx_pattern1/pages/detail_page.dart';
import 'package:getx_pattern1/services/authentication_service.dart';
import 'package:getx_pattern1/services/hive_service.dart';
import 'package:getx_pattern1/services/realtime_service.dart';

class HomeController extends GetxController{
  var isLoading = false.obs;
  RxList<Post> list = <Post>[].obs;

  Future<void> openDetailPage() async {
    final saveButtonIsPressed = await Get.to(() => const DetailPage());
    // bool? saveButtonIsPressed = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const DetailPage()));
    if(saveButtonIsPressed != null && saveButtonIsPressed){
      loadData();
    }
  }

  void loadData() async {
    isLoading.value = true;

    String id = await HiveDB.getUser();  // To get the user's ID
    RealtimeDB.GET(id).then((value) {
      list.value = value;
      list.refresh();
      list.sort(Post.sortByDate);
      isLoading.value = false;
    });
  }

  void signOut(){
    AuthenticationService.signOut();
  }
}