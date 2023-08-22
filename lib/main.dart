import 'dart:io';
import 'package:erp_banchangtong/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // final CounterController _counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Banchangtong',
      home: Scaffold(
          body: SafeArea(
        child: SimpleLoginScreen(),
      )),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
