import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern2/controls/home_page.dart';
import 'package:getx_pattern2/widgets/home_page.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<HomeController>().loadData();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Get.find<HomeController>().loadData();
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
                    Get.find<HomeController>().signOut();
                  }
              )
            ],
            elevation: 10.0,
          ),
          body: Stack(
            children: [
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: Get.find<HomeController>().list.length,
                itemBuilder: (BuildContext context, int index){
                  return post(Get.find<HomeController>().list[index]);
                },
              ),
              Get.find<HomeController>().isLoading.value
                  ? const Center(child:  CircularProgressIndicator(color: CupertinoColors.systemRed),)
                  : const SizedBox(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 30.0,
            child: const Icon(Icons.add),
            onPressed: (){
              Get.find<HomeController>().openDetailPage();
            },
          ),
        );
      }
    );
  }
}