import 'package:erp_banchangtong/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../printer/printer.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> removeSharedPreferences() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('isLogged', 'false');
      prefs.remove('Id');
      prefs.remove('Fname');
      prefs.remove('Lname');
      prefs.remove('PermissionId');
    }

    return Scaffold(
        body: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: 120,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(2, 3),
                      spreadRadius: 2,
                      blurRadius: 2)
                ]),
            child: TextButton(
                onPressed: () => {
                      removeSharedPreferences(),
                      Get.off(const SimpleLoginScreen())
                    },
                child: const Text("Logout"))),
        const SizedBox(
          height: 50,
        ),
        Container(
            width: 120,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(2, 3),
                      spreadRadius: 2,
                      blurRadius: 2)
                ]),
            child: TextButton(
                onPressed: () => {Get.to(Printer())},
                child: const Text("Printer"))),
      ],
    )));
  }
}
