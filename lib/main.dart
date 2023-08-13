import 'dart:io';
import 'package:camera/camera.dart';
import 'package:erp_banchangtong/pages/inventory/insert_product.dart';
import 'package:erp_banchangtong/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.cameras, Key? key}) : super(key: key);
  final List<CameraDescription> cameras;
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