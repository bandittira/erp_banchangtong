import 'package:flutter/material.dart';

class MenuCards extends StatefulWidget {
  final String menuName;
  final Color color;
  final Icon icon;
  const MenuCards(this.menuName,this.color,this.icon);

  @override
  State<MenuCards> createState() => _MenuCardsState();
}

class _MenuCardsState extends State<MenuCards> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [Text(widget.menuName),Text("data")],);
  }
}