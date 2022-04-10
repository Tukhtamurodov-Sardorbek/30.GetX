import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern3/pages/entry_pages/sign_up.dart';
import 'package:getx_pattern3/pages/home_page.dart';
import 'package:getx_pattern3/services/authentication_service.dart';
import 'package:getx_pattern3/services/hive_service.dart';

class SignInControllers extends GetxController{
  final focusNodeEmail = FocusNode();
  final focusNodePassword = FocusNode();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool errorOccurred = false;
  bool isLoading = false;
  bool isHidden = true;

  void doSignIn(){
    removeFocus();

    String email = emailController.value.text.toString().trim();
    String password = passwordController.value.text.toString().trim();


    if(email.isEmpty || password.isEmpty){
      errorOccurred = true;
      update();
      return;
    }
    isLoading = true;
    update();

    AuthenticationService.signIn(email: email, password: password).then((value) async {
      // Logger().d(value);
      if (kDebugMode) {
        print(value);
      }
      isLoading = false;
      update();

      if(value != null){
        HiveDB.putUser(value);
        // await SharedPreferenceDB.setUserID(value.uid);
        // Navigator.pushReplacementNamed(context, HomePage.id);

        clearControllers();
        Get.off(() => const HomePage());
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
      }
      else{
        Get.snackbar('Error', 'Something went wrong, check your email and password, please!',
            snackPosition: SnackPosition.BOTTOM,
            animationDuration: const Duration(seconds: 3),
            backgroundColor: Colors.redAccent,
            colorText: Colors.white
        );
      }
    });

  }

  errorText(String text) {
    if (text.trim().toString().isEmpty) {
      return 'Shouldn\'t be empty';
    }
    return null;
  }

  visibility(){
    isHidden = !isHidden;
    update();
  }

  openSignUp(){
    Get.off(() => const SignUp());
  }

  removeFocus(){
    focusNodeEmail.unfocus();
    focusNodePassword.unfocus();
    update();
  }

  clearControllers(){
    emailController.clear();
    passwordController.clear();
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
  }
}