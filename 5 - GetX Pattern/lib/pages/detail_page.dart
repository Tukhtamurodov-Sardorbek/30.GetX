import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getxpattern5/controls/detail_page.dart';

class DetailPage extends StatefulWidget {
  static const String id = '/detail_page';
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return GetX<DetailController>(
        init: DetailController(),
        builder: (_controller) {
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: GestureDetector(
                        onTap: () {
                          _controller.getImage();
                        },
                        child: _controller.selectedImagePath.value.isEmpty
                            ? const Image(
                                image: AssetImage('assets/add.png'),
                                color: Colors.red,
                              )
                            : Stack(
                                children: [
                                  Image.file(
                                      File(_controller.selectedImagePath.value),
                                      height: 350,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 4.0, 4.0, 0),
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
                                          _controller.removeImage();
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                      ),
                    ),

                    _controller.selectedImageSize.isNotEmpty
                        ? Container(
                            alignment: Alignment.centerRight,
                            margin:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0),
                            child: Text(
                                'Size: ${_controller.selectedImageSize}',
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          )
                        : const SizedBox(),

                    // #title
                    TextField(
                        controller: _controller.titleController.value,
                        focusNode: _controller.titleFocusNode.value,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            hintText: 'Title',
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: CupertinoColors.systemRed,
                                  width: 3,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: CupertinoColors.systemRed,
                                  width: 3,
                                ))),
                        onChanged: (_) => setState(() {})),
                    const SizedBox(height: 10),
                    // #content
                    TextField(
                        controller: _controller.contentController.value,
                        focusNode: _controller.contentFocusNode.value,
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                        decoration: const InputDecoration(
                            // filled: true,
                            // fillColor: Colors.grey[100],
                            hintText: 'Content',
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: CupertinoColors.systemRed,
                                  width: 3,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
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
                      child: _controller.isLoading.value
                          ? const Center(
                              child: SizedBox(
                                height: 26,
                                width: 26,
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                            )
                          : const Text(
                              'Save',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                      onPressed: _controller.uploadImage,
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
