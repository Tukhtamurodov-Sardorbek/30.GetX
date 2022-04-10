import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern1/controls/entry_page/sign_in_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static const String id = '/sign_in';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final controller = SignInControllers();

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
                                controller: controller.emailController.value,
                                focusNode: controller.focusNodeEmail.value,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  errorText: controller.errorOccurred.value ? controller.errorText(controller.emailController.value.text) : null,
                                ),
                                onChanged: (_) => setState(() {}),
                              ),
                              const SizedBox(height: 10),
                              // #password
                              TextField(
                                controller: controller.passwordController.value,
                                obscureText: controller.isHidden.value,
                                focusNode: controller.focusNodePassword.value,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  errorText: controller.errorOccurred.value ? controller.errorText(controller.passwordController.value.text) : null,
                                  suffixIcon: IconButton(
                                    icon: Icon(controller.isHidden.value?Icons.visibility_off_outlined:Icons.visibility_outlined),
                                    onPressed: (){
                                      controller.visibility();
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
                                    controller.doSignIn();
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
                                        controller.openSignUp();
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
                      visible: controller.isLoading.value,
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