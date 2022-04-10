import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:getx_pattern2/pages/entry_pages/sign_in_page.dart';
import 'package:getx_pattern2/pages/home_page.dart';
import 'package:getx_pattern2/services/authentication_service.dart';
import 'package:getx_pattern2/services/binding_service.dart';
import 'package:getx_pattern2/services/hive_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox(HiveDB.nameDB);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget _startPage(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthenticationService.auth.authStateChanges(),
      builder: (context, value) {
        if(value.hasData) {
          // SharedPreferenceDB.storeString(StorageKeys.UID, value.data!.uid);
          HiveDB.putUser(value.data!);
          return const HomePage();
        } else {
          // SharedPreferenceDB.clear(StorageKeys.UID);
          HiveDB.removeUser();
          return const SignIn();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Pattern #2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: _startPage(context),
      initialBinding: ControllersBinding(),
    );
  }
}