import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../controller/var.dart';

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
        Container(
          width: screen.size.width,
          height: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
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
                  width: screen.size.width / 4.5,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade200),
                  child: SingleChildScrollView(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Text("น้ำ"),
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
                            if (diamondColorArr.isEmpty && widget.index == 0) {
                              diamondColorArr.add(int.parse(value!));
                            } else if (diamondColorArr.isEmpty &&
                                widget.index > 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('โปรดกรอกข้อมูลด้านบนก่อน'),
                                ),
                              );
                            } else if (diamondColorArr.length - 1 <
                                widget.index) {
                              diamondColorArr.add(int.parse(value!));
                            } else {
                              diamondColorArr[widget.index] = int.parse(value!);
                            }
                          });
                        },
                        dropdownStyleData: DropdownStyleData(
                            maxHeight: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14)),
                            scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility:
                                    MaterialStateProperty.all(true))),
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
                                value: item, child: Text(item)))
                            .toList(),
                        value: diamondClarity.isEmpty
                            ? null
                            : diamondClarity.length - 1 < widget.index
                                ? null
                                : diamondClarity[widget.index],
                        onChanged: (value) {
                          setState(() {
                            if (diamondClarity.isEmpty && widget.index == 0) {
                              diamondClarity.add(value);
                            } else if (diamondClarity.isEmpty &&
                                widget.index > 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('โปรดกรอกข้อมูลด้านบนก่อน'),
                                ),
                              );
                            } else if (diamondClarity.length - 1 <
                                widget.index) {
                              diamondClarity.add(value!);
                            } else {
                              diamondClarity[widget.index] = value!;
                              print(widget.index);
                              print(diamondClarity.length - 1);
                            }
                          });
                        },
                        dropdownStyleData: DropdownStyleData(
                            maxHeight: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14)),
                            scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility:
                                    MaterialStateProperty.all(true))),
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
                        hint: const Text("รูปทรง"),
                        items: cut
                            .map((String item) => DropdownMenuItem<String>(
                                value: item, child: Text(item)))
                            .toList(),
                        value: diamondCut.isEmpty
                            ? null
                            : diamondCut.length - 1 < widget.index
                                ? null
                                : diamondCut[widget.index],
                        onChanged: (value) {
                          setState(() {
                            if (diamondCut.isEmpty && widget.index == 0) {
                              diamondCut.add(value!);
                            } else if (diamondCut.isEmpty && widget.index > 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('โปรดกรอกข้อมูลด้านบนก่อน'),
                                ),
                              );
                            } else if (diamondCut.length - 1 < widget.index) {
                              diamondCut.add(value!);
                            } else {
                              diamondCut[widget.index] = value!;
                              print(widget.index);
                              print(diamondCut.length - 1);
                            }
                          });
                        },
                        dropdownStyleData: DropdownStyleData(
                            maxHeight: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14)),
                            scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all(6),
                                thumbVisibility:
                                    MaterialStateProperty.all(true))),
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
