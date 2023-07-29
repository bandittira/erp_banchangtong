import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:erp_banchangtong/pages/inventory/components/diamond_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

late List<CameraDescription> cameras;

class InsertProduct extends StatefulWidget {
  const InsertProduct({super.key});

  @override
  State<InsertProduct> createState() => _InsertProductState();
}

final List<String> items = [
  'แหวน',
  'สร้อยคอ',
  'สร้อยข้อมือ',
  'กำไลข้อมือ',
  'จี้',
  'ต่างหู',
  'กรอบพระ',
  'หัวจรวจ',
];

final List<String> category = [
  'RD',
  'NK',
  'BL',
  'BG',
  'PD',
  'ER',
  'BDRK',
  'HJ',
];

final List<String> goldType = [
  'ทอง',
  'ทองคำขาว',
  'พิงค์โกล',
  'เงิน',
  'แสตนเลส'
];

final List<String> certificated = [
  "None",
  "GIA",
  "IGI",
  "GCI",
  "AGS",
  "EGL",
  "GCAL",
];

String? selectedValue;
String? selectedValueGold;
String? selectedcolor;
String? selectedclarity;
String? selectedcut;

List<int> diamondColorArr = [];

class _InsertProductState extends State<InsertProduct> {
  final _formKey = GlobalKey<FormState>();
  String _price = "";
  String basePrice = "";
  String goldWeight = "";
  String goldPercent = "";
  String diamond = "";
  String amountD = "";
  String gemstone = "";
  String amountG = "";
  final List<TextEditingController> _controllerDiamond = [];
  final List<TextEditingController> _controllerGemstone = [];
  final List<TextEditingController> _amountDiamond = [];
  final List<TextEditingController> _amountGemstone = [];

  final List<Widget> _dynamicWidgetsDiamond = [];
  final List<Widget> _dynamicWidgetsGemstone = [];
  final ImagePicker picker = ImagePicker();
  String id = "";
  File? image;
  var imageName = "ชื่อรูปภาพ";
  var diamondArr = [];
  var gemstoneArr = [];

  String? _validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'โปรดใส่ข้อมูล';
    }
    return null; // Return null if the input is valid
  }

  String? _validateInputNum(String? value) {
    if (value == null || value.isEmpty) {
      return 'โปรดใส่ข้อมูล';
    }

    // Use a regular expression to check if the input contains only numeric values (double)
    final RegExp doubleRegex = RegExp(r'^[0-9]*(?:[.][0-9]*)?$');
    if (!doubleRegex.hasMatch(value)) {
      return 'โปรดใส่ตัวเลขที่ถูกต้อง';
    }

    return null; // Return null if the input is valid
  }

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var ids = prefs.getString('Id');
    id = ids!;
  }

  Future pickImage() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
        imageName = (image.name);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void _addDynamicWidget() {
    setState(() {
      _controllerDiamond.add(TextEditingController());
      _amountDiamond.add(TextEditingController());
      _dynamicWidgetsDiamond.add(addElements(
          context,
          "จำนวนเพชร",
          "กะรัต / เม็ด",
          _controllerDiamond[_controllerDiamond.length - 1],
          _amountDiamond[_amountDiamond.length - 1],
          _dynamicWidgetsDiamond.length));
    });
  }

  void _addDynamicWidgetGemstone() {
    setState(() {
      _controllerGemstone.add(TextEditingController());
      _amountGemstone.add(TextEditingController());
      _dynamicWidgetsGemstone.add(addElements(
          context,
          "จำนวนพลอย",
          "กะรัต / เม็ด",
          _controllerGemstone[_controllerGemstone.length - 1],
          _amountGemstone[_amountGemstone.length - 1],
          _dynamicWidgetsGemstone.length));
    });
  }

  void _removeDynamicWidget(arr, controller, amount, detailArr) {
    setState(() {
      print(arr.isEmpty);
      if (arr.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ไม่สามารถลบได้มากกว่านี้'),
          ),
        );
      } else {
        if (detailArr == null) {
        } else {
          if (detailArr.isEmpty) {
          } else {
            detailArr.removeAt(arr.length - 1);
          }
        }
        arr.removeAt(arr.length - 1);
        controller.removeAt(controller.length - 1);
        amount.removeAt(amount.length - 1);
      }
    });
  }

  Future<void> uploadFormData({
    required String productCategory,
    required int createBy,
    required String imagePath,
    required int price,
    required String basePrice,
    required List<String> material,
    required List<String> diamond,
    required List<String> gemstone,
    required http.MultipartFile file,
  }) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('127.0.0.1:8000/insertProduct'));

    // Add form fields
    request.fields['productCategory'] = productCategory;
    request.fields['createBy'] = createBy.toString();
    request.fields['price'] = price.toString();
    request.fields['basePrice'] = basePrice;

    // Add list fields
    request.fields['material'] = material.join(',');
    request.fields['diamond'] = diamond.join(',');
    request.fields['gemstone'] = gemstone.join(',');

    // Add the file
    request.files.add(file);

    // Send the request and get the response
    var response = await request.send();

    // Check if the request was successful
    if (response.statusCode == 200) {
      print('Upload successful');
    } else {
      print('Upload failed with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context);

    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(20),
              width: screen.size.width,
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      SizedBox(
                        width: screen.size.width / 0.175,
                        child: const Text(
                          "สร้างข้อมูลสินค้า",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: screen.size.width,
                        height: 1,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Text(
                            "รหัสสินค้า ",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "#RD 0100001",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "รายละเอียด",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                          width: screen.size.width / 0.175,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade200,
                          ),
                          child: SingleChildScrollView(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: const Text("หมวดหมู่"),
                                items: items
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                            value: item, child: Text(item)))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value;
                                  });
                                },
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 15),
                            alignment: Alignment.centerLeft,
                            width: screen.size.width / 1.55,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade200),
                            child: Text(imageName),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: screen.size.width / 4.5,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey.shade200),
                              child: TextButton(
                                onPressed: () async {
                                  pickImage();
                                },
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 13),
                            alignment: Alignment.center,
                            width: screen.size.width / 2.3,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade200),
                            child: TextFormField(
                                validator: _validateInput,
                                onSaved: (value) {
                                  _price = value!;
                                },
                                textInputAction: TextInputAction.go,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    hintText: "ราคา",
                                    border: InputBorder.none)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 13),
                            alignment: Alignment.center,
                            width: screen.size.width / 2.3,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade200),
                            child: TextFormField(
                                validator: _validateInput,
                                onSaved: (value) {
                                  basePrice = value!;
                                },
                                textInputAction: TextInputAction.go,
                                textCapitalization:
                                    TextCapitalization.characters,
                                decoration: const InputDecoration(
                                    hintText: "รหัสทุน",
                                    border: InputBorder.none)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
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
                                    amountD = value!;
                                  },
                                  textInputAction: TextInputAction.go,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: "จำนวนเพชร",
                                      border: InputBorder.none)),
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
                                    diamond = value!;
                                  },
                                  textInputAction: TextInputAction.go,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: "กะรัต / เม็ด",
                                      border: InputBorder.none)),
                            ),
                          ]),
                          SizedBox(
                              width: 40,
                              height: 40,
                              child: TextButton(
                                  onPressed: () => {_addDynamicWidget()},
                                  child: const Icon(Icons.add))),
                          SizedBox(
                              width: 40,
                              height: 40,
                              child: TextButton(
                                  onPressed: () => {
                                        _removeDynamicWidget(
                                            _dynamicWidgetsDiamond,
                                            _controllerDiamond,
                                            _amountDiamond,
                                            diamondColorArr)
                                      },
                                  child: const Icon(Icons.delete)))
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
                                          .map((int item) =>
                                              DropdownMenuItem<String>(
                                                  value: item.toString(),
                                                  child: Text(item.toString())))
                                          .toList(),
                                      value: selectedcolor,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedcolor = value;
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
                                          .map((String item) =>
                                              DropdownMenuItem<String>(
                                                  value: item.toString(),
                                                  child: Text(item.toString())))
                                          .toList(),
                                      value: selectedclarity,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedclarity = value;
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
                                      hint: const Text("คัท"),
                                      items: cut
                                          .map((String item) =>
                                              DropdownMenuItem<String>(
                                                  value: item.toString(),
                                                  child: Text(item.toString())))
                                          .toList(),
                                      value: selectedcut,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedcut = value;
                                        });
                                      },
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      // DiamondCard
                      Column(
                        children: [
                          for (var i = 0;
                              i < _dynamicWidgetsDiamond.length;
                              i++)
                            DiamondCard(i)
                        ],
                      ),
                      Container(
                        width: screen.size.width,
                        height: 1,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Row(
                          children: [
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
                                    amountG = value!;
                                  },
                                  textInputAction: TextInputAction.go,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: "จำนวนพลอย",
                                      border: InputBorder.none)),
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
                                    gemstone = value!;
                                  },
                                  textInputAction: TextInputAction.go,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: "กะรัต / เม็ด",
                                      border: InputBorder.none)),
                            ),
                            SizedBox(
                                width: 40,
                                height: 40,
                                child: TextButton(
                                    onPressed: () =>
                                        {_addDynamicWidgetGemstone()},
                                    child: const Icon(Icons.add))),
                            SizedBox(
                                width: 40,
                                height: 40,
                                child: TextButton(
                                    onPressed: () => {
                                          _removeDynamicWidget(
                                              _dynamicWidgetsGemstone,
                                              _controllerGemstone,
                                              _amountGemstone,
                                              null)
                                        },
                                    child: const Icon(Icons.delete))),
                          ],
                        ),
                      ),
                      Column(
                        children: _dynamicWidgetsGemstone,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: screen.size.width,
                        height: 1,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                          width: screen.size.width / 0.175,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey.shade200,
                          ),
                          child: SingleChildScrollView(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: const Text("ชนิดโลหะ"),
                                items: goldType
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                            value: item, child: Text(item)))
                                    .toList(),
                                value: selectedValueGold,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValueGold = value;
                                  });
                                },
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 13),
                            alignment: Alignment.center,
                            width: screen.size.width / 2.3,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade200,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    validator: _validateInputNum,
                                    onSaved: (value) {
                                      goldWeight = value!;
                                    },
                                    textInputAction: TextInputAction.go,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: "น้ำหนัก",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    width:
                                        10), // Add some spacing between the TextFormField and the Text widget
                                Text(
                                  "กรัม",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 20), //
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 15),
                            alignment: Alignment.center,
                            width: screen.size.width / 2.3,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey.shade200,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    validator: _validateInputNum,
                                    onSaved: (value) {
                                      goldPercent = value!;
                                    },
                                    textInputAction: TextInputAction.go,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: "เปอร์เซ็นโลหะ",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    width:
                                        10), // Add some spacing between the TextFormField and the Text widget
                                Text(
                                  "%",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: screen.size.width,
                        height: 1,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () => {},
                              child: Container(
                                alignment: Alignment.center,
                                width: 120,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.red.shade400),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )),
                          TextButton(
                              onPressed: () => {
                                    //productCategory : str, createBy : int, imagePath : str, price : int, basePrice : str, material : list, diamond : list, gemstone : list, file: UploadFile
                                    getUserId(),
                                    if (_formKey.currentState!.validate())
                                      {
                                        _formKey.currentState!.save(),
                                        if (selectedValue == null)
                                          {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text('โปรดเลือกหมวดหมู่'),
                                              ),
                                            )
                                          }
                                        else if (selectedValueGold == null)
                                          {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text('โปรดเลือกชนิดโลหะ'),
                                              ),
                                            )
                                          }
                                        else if (image == null)
                                          {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text('โปรดถ่ายรูป'),
                                              ),
                                            )
                                          }
                                        else
                                          {
                                            print('price: $_price'),
                                            print(selectedValue),
                                            print(image),
                                            print(diamondColorArr),
                                            print(amountDiamond),
                                          },
                                      }
                                    // if (_Diamond.text.isEmpty)
                                    //   {print("yeh")}
                                    // else
                                    //   {
                                    //     diamondArr.add({
                                    //       "Carat": _Diamond.text,
                                    //       "Shape": "",
                                    //       "Color": "",
                                    //       "Cut": "",
                                    //       "Clarity": "",
                                    //       "Certificated": "",
                                    //       "Amount": double.parse(_amountD.text)
                                    //     }),
                                    //     if (_controllerDiamond.isEmpty)
                                    //       {print("yeh")}
                                    //     else
                                    //       {
                                    //         for (var i = 0;
                                    //             i < _controllerDiamond.length;
                                    //             i++)
                                    //           {
                                    //             gemstoneArr.add({
                                    //               "Carat": _controllerDiamond[i]
                                    //                   .text,
                                    //               "Shape": "",
                                    //               "Color": "",
                                    //               "Cut": "",
                                    //               "Clarity": "",
                                    //               "Certificated": "",
                                    //               "Amount": double.parse(
                                    //                   _amountDiamond[i].text)
                                    //             }),
                                    //           },
                                    //       }
                                    //   },
                                    // if (_Gemstone.text.isEmpty)
                                    //   {print("Yeh")}
                                    // else
                                    //   {
                                    //     gemstoneArr.add({
                                    //       "Carat": _Gemstone.text,
                                    //       "Shape": "",
                                    //       "Color": "",
                                    //       "Price": "",
                                    //       "Amount": double.parse(_amountG.text)
                                    //     }),
                                    //     if (_controllerGemstone.isEmpty)
                                    //       {print("Yeh")}
                                    //     else
                                    //       {
                                    //         for (var i = 0;
                                    //             i < _controllerGemstone.length;
                                    //             i++)
                                    //           {
                                    //             gemstoneArr.add({
                                    //               "Carat":
                                    //                   _controllerGemstone[i]
                                    //                       .text,
                                    //               "Shape": "",
                                    //               "Color": "",
                                    //               "Price": "",
                                    //               "Amount": double.parse(
                                    //                   _amountGemstone[i].text)
                                    //             }),
                                    //           },
                                    //       }
                                    //   },
                                    // print(diamondArr),
                                    // print(gemstoneArr),

                                    //uploadFormData(productCategory: category[items.indexOf(selectedValue.toString())], createBy: int.parse(id), imagePath: imageName, price: int.parse(_price.text), basePrice: _basePrice.text, material: material, diamond: diamond, gemstone: gemstone, file: file)
                                    // print(category[
                                    //     items.indexOf(selectedValue.toString())]),
                                    // getUserId(),
                                    // print(imageName),
                                    // print(_price.text),
                                    // print(_basePrice.text),
                                    // print(_Diamond.text),
                                    // print(_amountD.text),
                                    // print(_Gemstone.text),
                                    // print(_amountG.text),
                                    // for (var i = 0;
                                    //     i < _controllerDiamond.length;
                                    //     i++)
                                    //   {
                                    //     print(_controllerDiamond[i].text),
                                    //     print(_amountDiamond[i].text)
                                    //   },

                                    // for (var x = 0;
                                    //     x < _controllerGemstone.length;
                                    //     x++)
                                    //   {
                                    //     print(_controllerGemstone[x].text),
                                    //     print(_amountGemstone[x].text)
                                    //   },
                                    // print(selectedValueGold),
                                    // print(_goldWeight.text),
                                    // print(_goldPercent.text),
                                    // print(image),
                                  },
                              child: Container(
                                alignment: Alignment.center,
                                width: 120,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.green.shade400),
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ]),
              ))),
    ));
  }
}

addElements(
    context, String amount, carat, controller, controlleramount, int index) {
  var screen = MediaQuery.of(context);
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Container(
      padding: const EdgeInsets.all(5),
      // decoration: BoxDecoration(
      //     color: Colors.grey.shade300,
      //     borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 13),
                alignment: Alignment.center,
                width: screen.size.width / 3.0,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.shade200),
                child: TextField(
                    controller: controller,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: amount, border: InputBorder.none)),
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
                child: TextField(
                    controller: controlleramount,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: carat, border: InputBorder.none)),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
