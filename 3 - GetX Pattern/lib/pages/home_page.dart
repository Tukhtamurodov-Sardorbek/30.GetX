import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern3/controls/home_page.dart';
import 'package:getx_pattern3/widgets/home_page.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_controller){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: CupertinoColors.systemRed,
            title: const Text('Home'),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: (){
                    _controller.signOut();
                  }
              )
            ],
            elevation: 10.0,
          ),
          body: Stack(
            children: [
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _controller.list.length,
                itemBuilder: (BuildContext context, int index){
                  return post(_controller.list[index]);
                },
              ),
              _controller.isLoading
                  ? const Center(child:  CircularProgressIndicator(color: CupertinoColors.systemRed),)
                  : const SizedBox(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 30.0,
            child: const Icon(Icons.add),
            onPressed: (){
              _controller.openDetailPage();
            },
          ),
        );
      },
    );
  }
}