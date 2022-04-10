import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxpattern5/controls/entry_page/sign_up_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static const String id = '/sign_up';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  @override
  Widget build(BuildContext context) {
    return GetX<SignUpController>(
      init: SignUpController(),
        builder: (_controller){
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
                            controller: _controller.firstNameController.value,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              errorText: _controller.errorOccurred.value ? _controller.errorText(_controller.firstNameController.value.text) : null,
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 10),
                          // #last name
                          TextField(
                            controller: _controller.lastNameController.value,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              errorText: _controller.errorOccurred.value ? _controller.errorText(_controller.lastNameController.value.text) : null,
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 10),
                          // #email address
                          TextField(
                            controller: _controller.emailController.value,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              errorText: _controller.errorOccurred.value ? _controller.errorText(_controller.emailController.value.text) : null,
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 10),
                          // #password
                          TextField(
                            controller: _controller.passwordController.value,
                            obscureText: _controller.isHidden.value,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              errorText: _controller.errorOccurred.value ? _controller.errorText(_controller.passwordController.value.text) : null,
                              suffixIcon: IconButton(
                                  splashRadius: 1,
                                  onPressed: (){
                                    _controller.visibility();
                                  },
                                  icon: Icon(_controller.isHidden.value
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
                                _controller.doSignUp();
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
                                  _controller.openSignIn();
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
                      visible: _controller.isLoading.value,
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