// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:erp_banchangtong/pages/inventory/controller/image_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:searchfield/searchfield.dart';
// import '../../home/controller/var.dart';
// import '../controller/get_id.dart';
// import '../controller/get_product_detail.dart';
// import '../controller/var.dart' as vars;
// import '../controller/var.dart' as items;

// RxString imageName = "ชื่อรูปภาพ".obs;
// RxString selectedValue = vars.items[0].obs;
// RxString productCode = "RD".obs;
// RxInt productId = 1000001.obs;

// // Diamond card widget
// RxList amountDiamond = [].obs;
// RxList caratDiamond = [].obs;
// RxList<int?> diamondColorArr = <int?>[].obs;
// RxList<String?> diamondClarity = <String?>[].obs;
// RxList<String?> diamondCut = <String?>[].obs;

// // Price Controller
// RxString priceTemp = "".obs;
// RxString basePriceTemp = "".obs;
// final priceText = TextEditingController().obs;
// final basePriceText = TextEditingController().obs;

// List<TextEditingController> amountDiamondText = List.generate(
//     productDetailArray['productDiamonds'].length,
//     (i) => TextEditingController());

// List<TextEditingController> caratDiamondText = List.generate(
//     productDetailArray['productDiamonds'].length,
//     (i) => TextEditingController());

// class WidgetBody extends StatelessWidget {
//   const WidgetBody({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     GetProductId getProductIdClass = GetProductId();
//     return (Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         header(),
//         const SizedBox(
//           height: 10,
//         ),
//         Container(
//           width: Get.width,
//           height: 1,
//           color: Colors.grey.withOpacity(0.3),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         productCodeWidget(),
//         const SizedBox(
//           height: 20,
//         ),
//         const Text(
//           "รายละเอียด",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         Container(
//             width: Get.width / 0.175,
//             height: 60,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: Colors.grey.shade200,
//             ),
//             child: SingleChildScrollView(
//               child: DropdownButtonHideUnderline(
//                 child: Obx(() => DropdownButton2<String>(
//                       isExpanded: true,
//                       hint: const Text("หมวดหมู่"),
//                       items: vars.items
//                           .map((String item) => DropdownMenuItem<String>(
//                               value: item, child: Text(item)))
//                           .toList(),
//                       value: selectedValue.value,
//                       onChanged: (value) {
//                         selectedValue.value = value!;
//                         getProductIdClass.getProductId(
//                             vars.category[
//                                 vars.items.indexOf(selectedValue.value)],
//                             "adjust");
//                       },
//                     )),
//               ),
//             )),
//         const SizedBox(
//           height: 15,
//         ),
//         imagePicker(),
//         const SizedBox(
//           height: 15,
//         ),
//         PriceController().priceDetail(),
//         const SizedBox(
//           height: 15,
//         ),
//         Obx(() => Column(
//               children: productDetailArray.isEmpty
//                   ? []
//                   : List.generate(
//                       productDetailArray['productDiamonds'].length,
//                       (index) => DiamondCardController(index).diamondCard(),
//                     ),
//             )),
//         Container(
//           width: Get.width,
//           height: 1,
//           color: Colors.grey.withOpacity(0.3),
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         button()
//       ],
//     ));
//   }
// }

// Widget header() {
//   return Row(
//     children: [
//       const Text(
//         "แก้ไขข้อมูล",
//         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//       SizedBox(
//         width: Get.width / 6,
//       ),
//       Container(
//         width: Get.width / 2,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(25),
//             color: Colors.grey.shade200),
//         child: SearchField(
//           onSuggestionTap: (x) => {
//             productCode.value = x.item.toString().substring(0, 2),
//             productId.value = int.parse(x.item.toString().substring(2, 9)),
//             selectedValue.value =
//                 vars.items[vars.category.indexOf(productCode.value)],
//             GetProductDetailsById()
//                 .getAllProduct(productId.toString(), productCode.toString()),
//           },
//           searchInputDecoration: const InputDecoration(
//               prefixIcon: Icon(Iconsax.search_normal),
//               contentPadding: EdgeInsets.only(top: 15),
//               hintText: "Search",
//               border: InputBorder.none),
//           suggestions: allProduct
//               .map(
//                 (e) => SearchFieldListItem(
//                   e.toString(),
//                   item: e,
//                   // Use child to show Custom Widgets in the suggestions
//                   // defaults to Text widget
//                   child: Container(
//                     decoration:
//                         BoxDecoration(borderRadius: BorderRadius.circular(20)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           Text(e.toString()),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//               .toList(),
//         ),
//       ),
//     ],
//   );
// }

// Widget productCodeWidget() {
//   return Row(
//     children: [
//       const Text(
//         "รหัสสินค้า ",
//         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//       ),
//       Obx(() => Text(
//             '#${productCode.toString()} ${productId.toString()}',
//             style: const TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blueAccent),
//           )),
//     ],
//   );
// }

// Widget imagePicker() {
//   return Row(
//     children: [
//       Container(
//         padding: const EdgeInsets.only(left: 15),
//         alignment: Alignment.centerLeft,
//         width: Get.width / 1.55,
//         height: 60,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: Colors.grey.shade200),
//         child: Obx(() => Text(imageName.value)),
//       ),
//       const SizedBox(
//         width: 10,
//       ),
//       Container(
//           width: Get.width / 4.5,
//           height: 60,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: Colors.grey.shade200),
//           child: TextButton(
//             onPressed: () async {
//               pickImage();
//             },
//             child: const Icon(
//               Icons.camera_alt,
//               color: Colors.black,
//             ),
//           ))
//     ],
//   );
// }

// class PriceController extends GetxController {
//   Widget priceDetail() {
//     String? validateInput(String? value) {
//       if (value == null || value.isEmpty) {
//         return 'โปรดใส่ข้อมูล';
//       }
//       return null; // Return null if the input is valid
//     }

//     String? validateInputNum(String? value) {
//       if (value == null || value.isEmpty) {
//         return 'โปรดใส่ข้อมูล';
//       }

//       // Use a regular expression to check if the input contains only numeric values (double)
//       final RegExp doubleRegex = RegExp(r'^[0-9]*(?:[.][0-9]*)?$');
//       if (!doubleRegex.hasMatch(value)) {
//         return 'โปรดใส่ตัวเลขที่ถูกต้อง';
//       }

//       return null; // Return null if the input is valid
//     }

//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.only(left: 13),
//           alignment: Alignment.center,
//           width: Get.width / 2.3,
//           height: 60,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: Colors.grey.shade200),
//           child: TextFormField(
//               controller: priceText.value,
//               validator: validateInputNum,
//               onSaved: (value) {
//                 priceTemp.value = value!;
//               },
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                   hintText: "ราคา", border: InputBorder.none)),
//         ),
//         const SizedBox(
//           width: 10,
//         ),
//         Container(
//             padding: const EdgeInsets.only(left: 13),
//             alignment: Alignment.center,
//             width: Get.width / 2.3,
//             height: 60,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Colors.grey.shade200),
//             child: TextFormField(
//                 controller: basePriceText.value,
//                 validator: validateInput,
//                 onSaved: (value) {
//                   basePriceTemp.value = value!;
//                 },
//                 textInputAction: TextInputAction.next,
//                 textCapitalization: TextCapitalization.characters,
//                 decoration: const InputDecoration(
//                     hintText: "รหัสทุน", border: InputBorder.none)))
//       ],
//     );
//   }

//   static PriceController get to => Get.find();
// }

// class DiamondCardController extends GetxController {
//   final int index;
//   DiamondCardController(this.index);
//   Widget diamondCard() {
//     if (productDetailArray['productDiamonds'].isEmpty) {
//     } else {
//       amountDiamondText[index].text =
//           productDetailArray['productDiamonds'][index]['Amount'].toString();
//       caratDiamondText[index].text =
//           productDetailArray['productDiamonds'][index]['Carat'].toString();
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
//                   width: Get.width / 5,
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
//               "เคลีย",
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
//               "ยืนยัน",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//             ),
//           )),
//     ],
//   );
// }
