import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../insert_product.dart';

final List<int> diamondColor = [
  100,
  99,
  98,
  97,
  96,
  95,
  94,
  93,
  92,
  91,
  90,
];

final List<String> clarity = [
  "FL",
  "VVS1",
  "VVS2",
  "VS1",
  "VS2",
  "SI1",
  "SI2",
  "I1",
  "I2",
  "I3"
];

final List<String> cut = [
  "Round",
  "Heart",
  "Emerald",
  "Baguette",
  "Cushion",
  "Radiant",
  "Princess",
  "Asscher",
  "Trilliant",
  "Oval",
  "Pear",
  "Marquise"
];

List amountDiamond = [];
List caratDiamond = [];
List selectedcolor = [];
List selectedclarity = [];
List selectedcut = [];

class DiamondCard extends StatefulWidget {
  final int index;

  const DiamondCard(this.index);

  @override
  State<DiamondCard> createState() => _DiamondCardState();
}

class _DiamondCardState extends State<DiamondCard> {
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0, bottom: 15),
          child: Row(children: [
            Row(children: [
              Container(
                padding: const EdgeInsets.only(left: 13),
                alignment: Alignment.center,
                width: screen.size.width / 3.0,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade200),
                child: TextFormField(
                    onSaved: (value) {
                      if (amountDiamond.isEmpty) {
                        amountDiamond.add(value);
                      } else if (amountDiamond.length - 1 < widget.index) {
                        amountDiamond.add(value);
                      } else {
                        amountDiamond[widget.index] = value;
                      }
                    },
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "จำนวนเพชร", border: InputBorder.none)),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 13),
                alignment: Alignment.center,
                width: screen.size.width / 3.0,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade200),
                child: TextFormField(
                    onSaved: (value) {
                      if (caratDiamond.isEmpty) {
                        caratDiamond.add(value);
                      } else if (caratDiamond.length - 1 < widget.index) {
                        caratDiamond.add(value);
                      } else {
                        caratDiamond[widget.index] = value;
                      }
                    },
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "กะรัต / เม็ด", border: InputBorder.none)),
              ),
            ]),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Row(
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 0),
                  alignment: Alignment.center,
                  width: screen.size.width / 5,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade200),
                  child: SingleChildScrollView(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Text("สี"),
                        items: diamondColor
                            .map((int item) => DropdownMenuItem<String>(
                                value: item.toString(),
                                child: Text(item.toString())))
                            .toList(),
                        value: diamondColorArr.isEmpty
                            ? null
                            : diamondColorArr.length - 1 < widget.index
                                ? null
                                : diamondColorArr[widget.index].toString(),
                        onChanged: (value) {
                          setState(() {
                            if (diamondColorArr.isEmpty) {
                              diamondColorArr.add(int.parse(value!));
                            } else if (diamondColorArr.length - 1 <
                                widget.index) {
                              diamondColorArr.add(int.parse(value!));
                            } else {
                              diamondColorArr[widget.index] = int.parse(value!);
                              print(widget.index);
                              print(diamondColorArr.length - 1);
                            }
                          });
                        },
                      ),
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 0),
                  alignment: Alignment.center,
                  width: screen.size.width / 3.2,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade200),
                  child: SingleChildScrollView(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Text("ตำหนิ"),
                        items: clarity
                            .map((String item) => DropdownMenuItem<String>(
                                value: item.toString(),
                                child: Text(item.toString())))
                            .toList(),
                        value: null,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  )),
              const SizedBox(
                width: 10,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 0),
                  alignment: Alignment.center,
                  width: screen.size.width / 3.2,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade200),
                  child: SingleChildScrollView(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Text("คัท"),
                        items: cut
                            .map((String item) => DropdownMenuItem<String>(
                                value: item.toString(),
                                child: Text(item.toString())))
                            .toList(),
                        value: null,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
