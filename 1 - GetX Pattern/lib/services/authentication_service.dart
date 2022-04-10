import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getx_pattern1/pages/entry_pages/sign_in_page.dart';

class AuthenticationService{
  static final auth = FirebaseAuth.instance;

  static Future<User?> signUp({required String email, required String password}) async{
    if (kDebugMode) {
      print('Email: $email \t Password: $password');
    }
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (kDebugMode) { print(user.toString()); }
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) { print('The provided password is too weak.'); }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) { print('The account already exists for that email.'); }
      }
    } catch (e) {
      if (kDebugMode) { print(e); }
    }
    return null;
  }

  static Future<User?> signIn({required String email, required String password}) async{
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (kDebugMode) {
        print(user.toString());
      }
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return null;
  }

  static void signOut() async{
    await auth.signOut().then((value) => Get.offAll(() => const SignIn()));
    // await auth.signOut().then((value) => Navigator.pushReplacementNamed(context, SignIn.id));
  }
}