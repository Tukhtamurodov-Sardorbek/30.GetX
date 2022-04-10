import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern2/controls/entry_page/sign_in_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const String id = '/sign_in';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
        (){
          return Scaffold(
              body: Stack(
                children: [
                  SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // #email address
                              TextField(
                                controller: Get.find<SignInControllers>().emailController.value,
                                focusNode: Get.find<SignInControllers>().focusNodeEmail.value,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  errorText: Get.find<SignInControllers>().errorOccurred.value ? Get.find<SignInControllers>().errorText(Get.find<SignInControllers>().emailController.value.text) : null,
                                ),
                                onChanged: (_) => setState(() {}),
                              ),
                              const SizedBox(height: 10),
                              // #password
                              TextField(
                                controller: Get.find<SignInControllers>().passwordController.value,
                                obscureText: Get.find<SignInControllers>().isHidden.value,
                                focusNode: Get.find<SignInControllers>().focusNodePassword.value,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  errorText: Get.find<SignInControllers>().errorOccurred.value ? Get.find<SignInControllers>().errorText(Get.find<SignInControllers>().passwordController.value.text) : null,
                                  suffixIcon: IconButton(
                                    icon: Icon(Get.find<SignInControllers>().isHidden.value?Icons.visibility_off_outlined:Icons.visibility_outlined),
                                    onPressed: (){
                                      Get.find<SignInControllers>().visibility();
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              MaterialButton(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  height: 50,
                                  minWidth: MediaQuery.of(context).size.width - 50,
                                  color: CupertinoColors.systemRed,
                                  textColor: Colors.white,
                                  child: const Text('Sign in'),
                                  onPressed: (){
                                    Get.find<SignInControllers>().doSignIn();
                                  }
                              ),
                              const SizedBox(height: 20),
                              RichText(
                                text: TextSpan(
                                  text: 'Don\'t have an account? ',
                                  style: const TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: 'Sign Up',
                                      style: const TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.systemRed),
                                      recognizer: TapGestureRecognizer()..onTap = () {
                                        Get.find<SignInControllers>().openSignUp();
                                        // Navigator.pushReplacementNamed(context, SignUp.id);
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ]
                        ),
                      )
                  ),
                  Visibility(
                      visible: Get.find<SignInControllers>().isLoading.value,
                      child: const Center(
                          child: CircularProgressIndicator(color: CupertinoColors.systemRed, backgroundColor: Colors.white)
                      )
                  )
                ],
              )
          );
        }
    );
  }
}