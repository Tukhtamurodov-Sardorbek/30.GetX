import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern2/pages/entry_pages/sign_up.dart';
import 'package:getx_pattern2/pages/home_page.dart';
import 'package:getx_pattern2/services/authentication_service.dart';
import 'package:getx_pattern2/services/hive_service.dart';

class SignInControllers extends GetxController {
  var focusNodeEmail = FocusNode().obs;
  var focusNodePassword = FocusNode().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  var errorOccurred = false.obs;
  var isLoading = false.obs;
  var isHidden = true.obs;

  void doSignIn() {
    String email = emailController.value.text.toString().trim();
    String password = passwordController.value.text.toString().trim();

    removeFocus();

    if (email.isEmpty || password.isEmpty) {
      errorOccurred.value = true;
      return;
    }
    isLoading.value = true;

    AuthenticationService.signIn(email: email, password: password)
        .then((value) async {
      // Logger().d(value);
      if (kDebugMode) {
        print(value);
      }
      isLoading.value = false;

      if (value != null) {
        HiveDB.putUser(value);
        // await SharedPreferenceDB.setUserID(value.uid);
        // Navigator.pushReplacementNamed(context, HomePage.id);

        Get.off(() => const HomePage());
        clearControllers();
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const HomePage()));
      } else {
        Get.snackbar('Error',
            'Something went wrong, check your email and password, please!',
            snackPosition: SnackPosition.BOTTOM,
            animationDuration: const Duration(seconds: 3),
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      }
    });
  }

  errorText(String text) {
    if (text.trim().toString().isEmpty) {
      return 'Shouldn\'t be empty';
    }
    return null;
  }

  visibility() {
    isHidden.value = !isHidden.value;
  }

  openSignUp() {
    Get.off(() => const SignUp());
  }

  removeFocus() {
    focusNodeEmail.value.unfocus();
    focusNodePassword.value.unfocus();
  }

  clearControllers() {
    emailController.value.clear();
    passwordController.value.clear();
  }

  @override
  void onClose() {
    // TODO: implement onClose

    emailController.value.dispose();
    passwordController.value.dispose();
    focusNodeEmail.value.dispose();
    focusNodePassword.value.dispose();

    super.onClose();
  }
}
