import 'package:erp_banchangtong/pages/login/login.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context);
    return Container(
      height: screen.size.height,
      width: screen.size.width,
      child: TextButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SimpleLoginScreen())),
        child: Text("Click me"),
      ),
    );     
  }
}
