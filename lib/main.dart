import 'dart:io';
import 'package:erp_banchangtong/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class CounterController extends GetxController {
  var count = 0.obs;

  void increment() {
    count.value++;
  }
}

class MyApp extends StatelessWidget {
  // final CounterController _counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Banchangtong',
      home: Scaffold(
       
        body: SafeArea(child: SimpleLoginScreen(),)
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}