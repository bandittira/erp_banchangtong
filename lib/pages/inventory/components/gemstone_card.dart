import 'package:flutter/material.dart';
import 'package:get/get.dart';

List amountGemstone = [];
List caratGemstone = [];

class GemstoneCard extends StatefulWidget {
  final int index;
  const GemstoneCard(this.index);

  @override
  State<GemstoneCard> createState() => _GemstoneCardState();
}

class _GemstoneCardState extends State<GemstoneCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 13),
            alignment: Alignment.center,
            width: Get.width / 3.0,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade200),
            child: TextFormField(
                onSaved: (value) {
                  if (amountGemstone.isEmpty) {
                    amountGemstone.add(value);
                  } else if (amountGemstone.length - 1 < widget.index) {
                    amountGemstone.add(value);
                  } else {
                    amountGemstone[widget.index] = value;
                  }
                },
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "จำนวนพลอย", border: InputBorder.none)),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 13),
            alignment: Alignment.center,
            width: Get.width / 3.0,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade200),
            child: TextFormField(
                onSaved: (value) {
                  if (caratGemstone.isEmpty) {
                    caratGemstone.add(value);
                  } else if (caratGemstone.length - 1 < widget.index) {
                    caratGemstone.add(value);
                  } else {
                    caratGemstone[widget.index] = value;
                  }
                },
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "กะรัต / เม็ด", border: InputBorder.none)),
          ),
        ],
      ),
    );
  }
}
