import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern1/models/post_model.dart';
import 'package:getx_pattern1/services/hive_service.dart';
import 'package:getx_pattern1/services/realtime_service.dart';
import 'package:getx_pattern1/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class DetailController extends GetxController{
  var titleFocusNode = FocusNode().obs;
  var contentFocusNode = FocusNode().obs;
  final titleController = TextEditingController().obs;
  final contentController = TextEditingController().obs;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  var isLoading = false.obs;


  getImage() async {
    if(selectedImagePath.value.isNotEmpty || selectedImagePath.value != ''){
      return;
    }

    XFile? _image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // #in case the user chose an image
    if (_image != null) {
      selectedImagePath.value = _image.path;
      selectedImageSize.value = ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2) + ' Mb';
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
    titleFocusNode.value.unfocus();
    String title = titleController.value.text.toString().trim();
    String content = contentController.value.text.toString().trim();
    var id = await HiveDB.getUser(); // To get the user's ID


    if (title.isEmpty || content.isEmpty) {
      Get.snackbar('Warning', 'Fill in the fields, please!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white
      );
      return;
    }
    isLoading.value = true;

    if (selectedImagePath.value.isNotEmpty) {
      StoreService.uploadImage(File(selectedImagePath.value)).then((imageURL) => {
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
      isLoading.value = false;
      removeImage();
      Get.back(result: true);
      // Navigator.pop(context, true);
    });
  }

  removeImage(){
    selectedImagePath.value = '';
    selectedImageSize.value = '';
  }

  @override
  void onClose() {
    // TODO: implement onClose

    titleFocusNode.value.dispose();
    contentFocusNode.value.dispose();
    titleController.value.dispose();
    contentController.value.dispose();

    super.onClose();
  }
}
