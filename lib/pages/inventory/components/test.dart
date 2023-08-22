// class DiamondCardController extends GetxController {
//   final int index;
//   DiamondCardController(this.index);
//   Widget diamondCard() {
//     if (productDetailArray['productDiamonds'].isEmpty ||
//         productDetailArray['productDiamonds'].isEmpty) {}
//     // else {
//     //   amountDiamondText.addAll(RxList.generate(
//     //       productDetailArray['productDiamonds'].length,
//     //       (_) => TextEditingController()));
//     //   caratDiamondText.addAll(RxList.generate(
//     //       productDetailArray['productDiamonds'].length,
//     //       (_) => TextEditingController()));
//     amountDiamondText[index].text =
//         productDetailArray['productDiamonds'][index]['Amount'].toString();
//     caratDiamondText[index].text =
//         productDetailArray['productDiamonds'][index]['Carat'].toString();
//     // }
//     return Column(
//       children: [
//         Container(
//           width: Get.width,
//           height: 1,
//           color: Colors.grey.withOpacity(0.3),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 15, bottom: 15),
//           child: Row(children: [
//             Row(children: [
//               Container(
//                 padding: const EdgeInsets.only(left: 13),
//                 alignment: Alignment.center,
//                 width: Get.width / 3.0,
//                 height: 60,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.grey.shade200),
//                 child: TextFormField(
//                     controller: amountDiamondText[index],
//                     onSaved: (value) {
//                       if (amountDiamond.isEmpty) {
//                         amountDiamond.add(value);
//                       } else if (amountDiamond.length - 1 < index) {
//                         amountDiamond.add(value);
//                       } else {
//                         amountDiamond[index] = value;
//                       }
//                     },
//                     textInputAction: TextInputAction.go,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                         hintText: "จำนวนเพชร", border: InputBorder.none)),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Container(
//                 padding: const EdgeInsets.only(left: 13),
//                 alignment: Alignment.center,
//                 width: Get.width / 3.0,
//                 height: 60,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.grey.shade200),
//                 child: TextFormField(
//                     controller: caratDiamondText[index],
//                     onSaved: (value) {
//                       if (caratDiamond.isEmpty) {
//                         caratDiamond.add(value);
//                       } else if (caratDiamond.length - 1 < index) {
//                         caratDiamond.add(value);
//                       } else {
//                         caratDiamond[index] = value;
//                       }
//                     },
//                     textInputAction: TextInputAction.go,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                         hintText: "กะรัต / เม็ด", border: InputBorder.none)),
//               ),
//             ]),
//           ]),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(bottom: 15),
//           child: Row(
//             children: [
//               Container(
//                   padding: const EdgeInsets.only(left: 0),
//                   alignment: Alignment.center,
//                   width: Get.width / 4.5,
//                   height: 50,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.grey.shade200),
//                   child: SingleChildScrollView(
//                     child: DropdownButtonHideUnderline(
//                       child: Obx(() => DropdownButton2<String>(
//                             isExpanded: true,
//                             hint: productDetailArray['productDiamonds'].isEmpty
//                                 ? const Text("น้ำ")
//                                 : Text(productDetailArray['productDiamonds']
//                                         [index]['Color']
//                                     .toString()),
//                             items: items.diamondColor
//                                 .map((int item) => DropdownMenuItem<String>(
//                                     value: item.toString(),
//                                     child: Text(item.toString())))
//                                 .toList(),
//                             value: diamondColorArr.isEmpty
//                                 ? null
//                                 : diamondColorArr.length - 1 < index
//                                     ? null
//                                     : diamondColorArr[index].toString(),
//                             onChanged: (value) {
//                               if (diamondColorArr.isEmpty && index == 0) {
//                                 diamondColorArr.add(int.parse(value!));
//                               } else if (diamondColorArr.isEmpty &&
//                                   index >= 1) {
//                                 Get.snackbar(
//                                     "ข้อมูลไม่ครบ", "โปรดกรอกข้อมูลด้านบน");
//                               } else if (diamondColorArr.length - 1 < index) {
//                                 diamondColorArr.add(int.parse(value!));
//                               } else {
//                                 diamondColorArr[index] = (int.parse(value!));
//                               }
//                             },
//                             dropdownStyleData: DropdownStyleData(
//                                 maxHeight: 250,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(14)),
//                                 scrollbarTheme: ScrollbarThemeData(
//                                     radius: const Radius.circular(40),
//                                     thickness: MaterialStateProperty.all(6),
//                                     thumbVisibility:
//                                         MaterialStateProperty.all(true))),
//                           )),
//                     ),
//                   )),
//               const SizedBox(
//                 width: 10,
//               ),
//               Container(
//                   padding: const EdgeInsets.only(left: 0),
//                   alignment: Alignment.center,
//                   width: Get.width / 3.2,
//                   height: 50,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.grey.shade200),
//                   child: SingleChildScrollView(
//                     child: DropdownButtonHideUnderline(
//                       child: Obx(() => DropdownButton2<String>(
//                             isExpanded: true,
//                             hint: productDetailArray['productDiamonds'].isEmpty
//                                 ? const Text("ตำหนิ")
//                                 : Text(productDetailArray['productDiamonds']
//                                         [index]['Clarity']
//                                     .toString()),
//                             items: items.clarity
//                                 .map((String item) => DropdownMenuItem<String>(
//                                     value: item, child: Text(item)))
//                                 .toList(),
//                             value: diamondClarity.isEmpty
//                                 ? null
//                                 : diamondClarity.length - 1 < index
//                                     ? null
//                                     : diamondClarity[index],
//                             onChanged: (value) {
//                               if (diamondClarity.isEmpty && index == 0) {
//                                 diamondClarity.add(value);
//                               } else if (diamondClarity.isEmpty && index > 0) {
//                                 Get.snackbar(
//                                     "ข้อมูลไม่ครบ", "โปรดกรอกข้อมูลด้านบนก่อน");
//                               } else if (diamondClarity.length - 1 < index) {
//                                 diamondClarity.add(value!);
//                               } else {
//                                 diamondClarity[index] = value!;
//                               }
//                             },
//                             dropdownStyleData: DropdownStyleData(
//                                 maxHeight: 250,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(14)),
//                                 scrollbarTheme: ScrollbarThemeData(
//                                     radius: const Radius.circular(40),
//                                     thickness: MaterialStateProperty.all(6),
//                                     thumbVisibility:
//                                         MaterialStateProperty.all(true))),
//                           )),
//                     ),
//                   )),
//               const SizedBox(
//                 width: 10,
//               ),
//               Container(
//                   padding: const EdgeInsets.only(left: 0),
//                   alignment: Alignment.center,
//                   width: Get.width / 3.2,
//                   height: 50,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: Colors.grey.shade200),
//                   child: SingleChildScrollView(
//                     child: DropdownButtonHideUnderline(
//                       child: Obx(() => DropdownButton2<String>(
//                             isExpanded: true,
//                             hint: productDetailArray['productDiamonds'].isEmpty
//                                 ? const Text("รูปทรง")
//                                 : Text(productDetailArray['productDiamonds']
//                                         [index]['Cut']
//                                     .toString()),
//                             items: items.cut
//                                 .map((String item) => DropdownMenuItem<String>(
//                                     value: item, child: Text(item)))
//                                 .toList(),
//                             value: diamondCut.isEmpty
//                                 ? null
//                                 : diamondCut.length - 1 < index
//                                     ? null
//                                     : diamondCut[index],
//                             onChanged: (value) {
//                               if (diamondCut.isEmpty && index == 0) {
//                                 diamondCut.add(value!);
//                               } else if (diamondCut.isEmpty && index > 0) {
//                                 Get.snackbar(
//                                     "ข้อมูลไม่ครบ", "โปรดกรอกข้อมูลด้านบนก่อน");
//                               } else if (diamondCut.length - 1 < index) {
//                                 diamondCut.add(value!);
//                               } else {
//                                 diamondCut[index] = value!;
//                               }
//                             },
//                             dropdownStyleData: DropdownStyleData(
//                                 maxHeight: 250,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(14)),
//                                 scrollbarTheme: ScrollbarThemeData(
//                                     radius: const Radius.circular(40),
//                                     thickness: MaterialStateProperty.all(6),
//                                     thumbVisibility:
//                                         MaterialStateProperty.all(true))),
//                           )),
//                     ),
//                   )),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class GemstoneCardController extends GetxController {
//   final int index;
//   GemstoneCardController(this.index);
//   Widget gemstoneCard() {
//     if (productDetailArray['productGems'].isEmpty ||
//         productDetailArray['productGems'].isEmpty) {
//     } else {
//       for (int i = 0; i < productDetailArray['productGems'].length; i++) {
//         amountGemstoneText.add(TextEditingController());
//         caratGemstoneText.add(TextEditingController());
//       }
//       amountGemstoneText[index].text =
//           productDetailArray['productGems'][index]['Amount'].toString();
//       caratGemstoneText[index].text =
//           productDetailArray['productGems'][index]['Carat'].toString();
//     }

//     return Column(
//       children: [
//         Container(
//           width: Get.width,
//           height: 1,
//           color: Colors.grey.withOpacity(0.3),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 15, bottom: 15),
//           child: Row(children: [
//             Row(children: [
//               Container(
//                 padding: const EdgeInsets.only(left: 13),
//                 alignment: Alignment.center,
//                 width: Get.width / 3.0,
//                 height: 60,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.grey.shade200),
//                 child: TextFormField(
//                     controller: amountGemstoneText[index],
//                     onSaved: (value) {
//                       if (amountGemstone.isEmpty) {
//                         amountGemstone.add(value);
//                       } else if (amountGemstone.length - 1 < index) {
//                         amountGemstone.add(value);
//                       } else {
//                         amountGemstone[index] = value;
//                       }
//                     },
//                     textInputAction: TextInputAction.go,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                         hintText: "จำนวนพลอย", border: InputBorder.none)),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Container(
//                 padding: const EdgeInsets.only(left: 13),
//                 alignment: Alignment.center,
//                 width: Get.width / 3.0,
//                 height: 60,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15),
//                     color: Colors.grey.shade200),
//                 child: TextFormField(
//                     controller: caratGemstoneText[index],
//                     onSaved: (value) {
//                       if (caratGemstone.isEmpty) {
//                         caratGemstone.add(value);
//                       } else if (caratGemstone.length - 1 < index) {
//                         caratGemstone.add(value);
//                       } else {
//                         caratGemstone[index] = value;
//                       }
//                     },
//                     textInputAction: TextInputAction.go,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                         hintText: "กะรัต / เม็ด", border: InputBorder.none)),
//               ),
//             ]),
//           ]),
//         ),
//       ],
//     );
//   }
// }

// class Gold extends GetxController {
//   String? validateInputNum(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'โปรดใส่ข้อมูล';
//     }
//     return null;
//   }

//   Widget gold() {
//     if (productDetailArray['productMaterials'] == null ||
//         productDetailArray['productMaterials'].isEmpty) {
//     } else {
//       goldWeight.value.text = productDetailArray['productMaterials'][0]
//               ['MaterialWeight']
//           .toString();
//       goldPercent.value.text = productDetailArray['productMaterials'][0]
//               ['MaterialPercent']
//           .toString();
//     }
//     return Column(children: [
//       Container(
//         width: Get.width,
//         height: 1,
//         color: Colors.grey.withOpacity(0.3),
//       ),
//       const SizedBox(
//         height: 15,
//       ),
//       Container(
//           width: Get.width / 0.175,
//           height: 60,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: Colors.grey.shade200,
//           ),
//           child: SingleChildScrollView(
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton2<String>(
//                 isExpanded: true,
//                 hint: const Text("ชนิดโลหะ"),
//                 items: vars.goldType
//                     .map((String item) => DropdownMenuItem<String>(
//                         value: item, child: Text(item)))
//                     .toList(),
//                 value: selectedValueGold.value,
//                 onChanged: (value) {
//                   selectedValueGold.value = value!;
//                 },
//               ),
//             ),
//           )),
//       const SizedBox(
//         height: 15,
//       ),
//       Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.only(left: 13),
//             alignment: Alignment.center,
//             width: Get.width / 2.3,
//             height: 60,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: Colors.grey.shade200,
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: goldWeight.value,
//                     validator: validateInputNum,
//                     onSaved: (value) {
//                       goldWeight.value.text = value!;
//                     },
//                     textInputAction: TextInputAction.next,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       hintText: "น้ำหนัก",
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Text(
//                   "กรัม",
//                   style: TextStyle(
//                     color: Colors.grey.shade600,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(width: 20), //
//               ],
//             ),
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           Container(
//             padding: const EdgeInsets.only(left: 15),
//             alignment: Alignment.center,
//             width: Get.width / 2.3,
//             height: 60,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: Colors.grey.shade200,
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: goldPercent.value,
//                     validator: validateInputNum,
//                     onSaved: (value) {
//                       goldPercent.value.text = value!;
//                     },
//                     textInputAction: TextInputAction.next,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       hintText: "เปอร์เซ็นโลหะ",
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                     width:
//                         10), // Add some spacing between the TextFormField and the Text widget
//                 Text(
//                   "%",
//                   style: TextStyle(
//                     color: Colors.grey.shade600,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//               ],
//             ),
//           )
//         ],
//       )
//     ]);
//   }
// }

// Widget button() {
//   return Row(
//     crossAxisAlignment: CrossAxisAlignment.center,
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       TextButton(
//           onPressed: () {},
//           child: Container(
//             alignment: Alignment.center,
//             width: 120,
//             height: 60,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.red.shade400),
//             child: const Text(
//               "ลบ",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//             ),
//           )),
//       TextButton(
//           onPressed: () => {
//                 //productCategory : str, createBy : int, imagePath : str, price : int, basePrice : str, material : list, diamond : list, gemstone : list, file: UploadFile
//               },
//           child: Container(
//             alignment: Alignment.center,
//             width: 120,
//             height: 60,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.green.shade400),
//             child: const Text(
//               "อัพเดท",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//             ),
//           )),
//     ],
//   );
// }
