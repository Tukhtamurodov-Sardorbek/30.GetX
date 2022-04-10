import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpattern4/models/post_model.dart';
import 'package:getxpattern4/services/hive_service.dart';
import 'package:getxpattern4/services/realtime_service.dart';
import 'package:getxpattern4/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class DetailController extends GetxController{
  var titleFocusNode = FocusNode();
  var contentFocusNode = FocusNode();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  var selectedImagePath = '';
  var selectedImageSize = '';
  // Rx<File?> image = File();
  var isLoading = false;


  getImage() async {
    if(selectedImagePath.isNotEmpty || selectedImagePath != ''){
      return;
    }

    XFile? _image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // #in case the user chose an image
    if (_image != null) {
      selectedImagePath = _image.path;
      selectedImageSize = ((File(selectedImagePath)).lengthSync() / 1024 / 1024).toStringAsFixed(2) + ' Mb';
      update();
    }
    // #in case the user has not selected any image
    else {
      Get.snackbar('Warning', 'You haven\'t selected any image!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
    }
  }

  uploadImage() async {
    titleFocusNode.unfocus();
    contentFocusNode.unfocus();
    String title = titleController.text.toString().trim();
    String content = contentController.text.toString().trim();
    var id = await HiveDB.getUser(); // To get the user's ID

    if (title.isEmpty || content.isEmpty) {
      Get.snackbar('Warning', 'Fill in the fields, please!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white
      );
      return;
    }
    isLoading = true;
    update();

    if (selectedImagePath.isNotEmpty) {
      StoreService.uploadImage(File(selectedImagePath)).then((imageURL) => {
                uploadPost(id, title, content, imageURL)
              }
      );
    } else {
      uploadPost(id, title, content, null);
    }
  }

  uploadPost(String id, String title, String content, String? imageURL) async {
    String currentDate = DateTime.now()
        .toString()
        .replaceFirst(' ', ', ')
        .substring(0, 20);
    await RealtimeDB.POST(Post(
            userId: id,
            title: title,
            content: content,
            imageURL: imageURL ?? 'no image',
            date: currentDate))
        .then((value) {
      isLoading = false;
      update();
      removeImage();
      Get.back(result: true);
      // Navigator.pop(context, true);
    });
  }

  removeImage(){
    selectedImagePath = '';
    selectedImageSize = '';
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    titleFocusNode.dispose();
    contentFocusNode.dispose();
    titleController.dispose();
    contentController.dispose();
  }
}
