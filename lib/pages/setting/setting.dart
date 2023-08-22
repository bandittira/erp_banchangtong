import 'package:erp_banchangtong/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            child: Container(
                width: 120,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          offset: Offset(2, 3),
                          spreadRadius: 2,
                          blurRadius: 2)
                    ]),
                child: TextButton(
                    onPressed: () => {
                          removeSharedPreferences(),
                          Get.off(const SimpleLoginScreen())
                        },
                    child: const Text("Logout")))));
  }
}
