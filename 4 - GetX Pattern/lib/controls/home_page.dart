import 'package:get/get.dart';
import 'package:getxpattern4/models/post_model.dart';
import 'package:getxpattern4/pages/detail_page.dart';
import 'package:getxpattern4/services/authentication_service.dart';
import 'package:getxpattern4/services/hive_service.dart';
import 'package:getxpattern4/services/realtime_service.dart';

class HomeController extends GetxController{
  var isLoading = false;
  List<Post> list = <Post>[];

  Future<void> openDetailPage() async {
    final saveButtonIsPressed = await Get.to(() => const DetailPage());
    // bool? saveButtonIsPressed = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const DetailPage()));
    if(saveButtonIsPressed != null && saveButtonIsPressed){
      loadData();
    }
  }

  void loadData() async {
    isLoading = true;
    update();

    String id = await HiveDB.getUser();  // To get the user's ID
    RealtimeDB.GET(id).then((value) {
      list = value;
      list.sort(Post.sortByDate);
      isLoading = false;
      update();
    });
  }

  void signOut(){
    AuthenticationService.signOut();
    HiveDB.removeUser();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadData();
  }
}