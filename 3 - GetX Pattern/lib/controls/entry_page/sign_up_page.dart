import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern3/pages/entry_pages/sign_in_page.dart';
import 'package:getx_pattern3/pages/home_page.dart';
import 'package:getx_pattern3/services/authentication_service.dart';
import 'package:getx_pattern3/services/hive_service.dart';

class SignUpController extends GetxController{
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var firstNameFocus = FocusNode();
  var lastNameFocus = FocusNode();
  var emailFocus = FocusNode();
  var passwordFocus = FocusNode();
  var errorOccurred = false;
  var isLoading = false;
  var isHidden = true;



  void doSignUp(){
    String firstName = firstNameController.text.toString().trim();
    String lastName = lastNameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    removeFocus();

    if(firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty){
      errorOccurred = true;
      update();
      return;
    }
    isLoading = true;
    update();

    AuthenticationService.signUp(email: email, password: password).then((value) async {
      isLoading = false;
      update();

      if (value != null) {
        HiveDB.putUser(value);
        clearControllers();
        Get.off(() => const HomePage());
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
      }
      else{
        removeFocus();

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
    isHidden = !isHidden;
    update();
  }

  openSignIn(){
    Get.off(() => const SignIn());
  }

  @override
  void onClose() {
    // TODO: implement onClose

    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    firstNameFocus.dispose();
    lastNameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();

    super.onClose();
  }

  removeFocus(){
    firstNameFocus.unfocus();
    lastNameFocus.unfocus();
    emailFocus.unfocus();
    passwordFocus.unfocus();
    update();
  }

  clearControllers(){
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    update();
  }
}