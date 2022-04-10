import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern1/controls/home_page.dart';
import 'package:getx_pattern1/widgets/home_page.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.loadData();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    controller.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      (){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: CupertinoColors.systemRed,
            title: const Text('Home'),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: (){
                    controller.signOut();
                  }
              )
            ],
            elevation: 10.0,
          ),
          body: Stack(
            children: [
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.list.length,
                itemBuilder: (BuildContext context, int index){
                  return post(controller.list[index]);
                },
              ),
              controller.isLoading.value
                  ? const Center(child:  CircularProgressIndicator(color: CupertinoColors.systemRed),)
                  : const SizedBox(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 30.0,
            child: const Icon(Icons.add),
            onPressed: (){
              controller.openDetailPage();
            },
          ),
        );
      }
    );
  }
}