import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getx_pattern2/controls/detail_page.dart';

class DetailPage extends StatefulWidget {
  static const String id = '/detail_page';
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.find<DetailController>().titleFocusNode.value.dispose();
    Get.find<DetailController>().contentFocusNode.value.dispose();
    Get.find<DetailController>().titleController.value.dispose();
    Get.find<DetailController>().contentController.value.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // #add image
                Container(
                  height: 350,
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: GestureDetector(
                    onTap: () {
                      Get.find<DetailController>().getImage();
                    },
                    child: Get.find<DetailController>().selectedImagePath.value.isEmpty
                        ? const Image(
                            image: AssetImage('assets/add.png'),
                            color: Colors.red,
                          )
                        : Stack(
                            children: [
                              Image.file(
                                  File(Get.find<DetailController>().selectedImagePath.value),
                                  height: 350,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 4.0, 4.0, 0),
                                  height: 26,
                                  width: 26,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                    splashRadius: 1,
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(Icons.cancel_outlined,
                                        color: Colors.red, size: 26),
                                    onPressed: () {
                                      Get.find<DetailController>().removeImage();
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                ),

                Get.find<DetailController>().selectedImageSize.isNotEmpty
                    ? Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0),
                        child: Text('Size: ${Get.find<DetailController>().selectedImageSize}',
                            style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16)),
                      )
                    : const SizedBox(),

                // #title
                TextField(
                    controller: Get.find<DetailController>().titleController.value,
                    focusNode: Get.find<DetailController>().titleFocusNode.value,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        hintText: 'Title',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: CupertinoColors.systemRed,
                              width: 3,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: CupertinoColors.systemRed,
                              width: 3,
                            ))),
                    onChanged: (_) => setState(() {})),
                const SizedBox(height: 10),
                // #content
                TextField(
                    controller: Get.find<DetailController>().contentController.value,
                    focusNode: Get.find<DetailController>().contentFocusNode.value,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    decoration: const InputDecoration(
                        // filled: true,
                        // fillColor: Colors.grey[100],
                        hintText: 'Content',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: CupertinoColors.systemRed,
                              width: 3,
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: CupertinoColors.systemRed,
                              width: 3,
                            ))),
                    onChanged: (_) => setState(() {})),
                const SizedBox(height: 20),
                // #save button
                MaterialButton(
                  color: CupertinoColors.systemRed,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  height: 45,
                  child: Get.find<DetailController>().isLoading.value
                      ? const Center(
                          child: SizedBox(
                            height: 26,
                            width: 26,
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
                        )
                      : const Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                  onPressed: Get.find<DetailController>().uploadImage,
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      );
    });
  }
}
