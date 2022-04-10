import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_pattern2/controls/entry_page/sign_up_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const String id = '/sign_up';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  @override
  Widget build(BuildContext context) {
    return Obx(
        (){
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // #first name
                          TextField(
                            controller: Get.find<SignUpController>().firstNameController.value,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              errorText: Get.find<SignUpController>().errorOccurred.value ? Get.find<SignUpController>().errorText(Get.find<SignUpController>().firstNameController.value.text) : null,
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 10),
                          // #last name
                          TextField(
                            controller: Get.find<SignUpController>().lastNameController.value,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              errorText: Get.find<SignUpController>().errorOccurred.value ? Get.find<SignUpController>().errorText(Get.find<SignUpController>().lastNameController.value.text) : null,
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 10),
                          // #email address
                          TextField(
                            controller: Get.find<SignUpController>().emailController.value,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              errorText: Get.find<SignUpController>().errorOccurred.value ? Get.find<SignUpController>().errorText(Get.find<SignUpController>().emailController.value.text) : null,
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 10),
                          // #password
                          TextField(
                            controller: Get.find<SignUpController>().passwordController.value,
                            obscureText: Get.find<SignUpController>().isHidden.value,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              errorText: Get.find<SignUpController>().errorOccurred.value ? Get.find<SignUpController>().errorText(Get.find<SignUpController>().passwordController.value.text) : null,
                              suffixIcon: IconButton(
                                  splashRadius: 1,
                                  onPressed: (){
                                    Get.find<SignUpController>().visibility();
                                  },
                                  icon: Icon(Get.find<SignUpController>().isHidden.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined
                                  )
                              ),
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 10),
                          // #sign up button
                          MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              height: 50,
                              minWidth: MediaQuery.of(context).size.width - 50,
                              color: CupertinoColors.systemRed,
                              textColor: Colors.white,
                              child: const Text('Sign up'),
                              onPressed: (){
                                Get.find<SignUpController>().doSignUp();
                              }
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text('Already have an account? '),
                              GestureDetector(
                                child: const Text('Sign In', style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.systemRed),),
                                onTap: (){
                                  Get.find<SignUpController>().openSignIn();
                                  // Navigator.pushReplacement(context, MaterialPageRoute (builder: (BuildContext context) => const SignIn()));
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                      visible: Get.find<SignUpController>().isLoading.value,
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