import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern2/pages/entry_pages/sign_in_page.dart';
import 'package:getx_pattern2/pages/home_page.dart';
import 'package:getx_pattern2/services/authentication_service.dart';
import 'package:getx_pattern2/services/hive_service.dart';

class SignUpController extends GetxController{
  var firstNameController = TextEditingController().obs;
  var lastNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var firstNameFocus = FocusNode().obs;
  var lastNameFocus = FocusNode().obs;
  var emailFocus = FocusNode().obs;
  var passwordFocus = FocusNode().obs;
  var errorOccurred = false.obs;
  var isLoading = false.obs;
  var isHidden = true.obs;

  void doSignUp(){

    removeFocus();

    String firstName = firstNameController.value.text.toString().trim();
    String lastName = lastNameController.value.text.toString().trim();
    String email = emailController.value.text.toString().trim();
    String password = passwordController.value.text.toString().trim();


    if(firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty){
      errorOccurred.value = true;
      return;
    }
    isLoading.value = true;

    AuthenticationService.signUp(email: email, password: password).then((value) async {
      isLoading.value = false;

      if (value != null) {
        HiveDB.putUser(value);
        Get.off(() => const HomePage());
        clearControllers();
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
      }
      else{
        Get.snackbar('Error', 'Something went wrong, check your data, please!',
            snackPosition: SnackPosition.BOTTOM,
            animationDuration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
            colorText: Colors.white
        );
      }
    });
  }

  errorText(String text) {
    if (text.trim().toString().isEmpty) {
      return "Shouldn't be empty";
    }
    return null;
  }

  void visibility(){
    isHidden.value = !isHidden.value;
  }

  openSignIn(){
    Get.off(() => const SignIn());
  }

  @override
  void onClose() {
    // TODO: implement onClose

    firstNameController.value.dispose();
    lastNameController.value.dispose();
    emailController.value.dispose();
    passwordController.value.dispose();

    firstNameFocus.value.dispose();
    lastNameFocus.value.dispose();
    emailFocus.value.dispose();
    passwordFocus.value.dispose();

    super.onClose();
  }

  removeFocus(){
    firstNameFocus.value.unfocus();
    lastNameFocus.value.unfocus();
    emailFocus.value.unfocus();
    passwordFocus.value.unfocus();
  }

  clearControllers(){
    firstNameController.value.clear();
    lastNameController.value.clear();
    emailController.value.clear();
    passwordController.value.clear();
  }
}