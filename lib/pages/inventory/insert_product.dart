import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:erp_banchangtong/pages/inventory/components/diamond_card.dart';
import 'package:erp_banchangtong/pages/inventory/components/gemstone_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'controller/var.dart';

late List<CameraDescription> cameras;

class InsertProduct extends StatefulWidget {
  const InsertProduct({super.key});

  @override
  State<InsertProduct> createState() => _InsertProductState();
}

class _InsertProductState extends State<InsertProduct> {
  final _formKey = GlobalKey<FormState>();
  String price = "";
  String basePrice = "";
  String goldWeight = "";
  String goldPercent = "";
  String diamond = "";
  String amountD = "";
  String gemstone = "";
  String amountG = "";
  final diamondcontroller = TextEditingController();
  final amountDcontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  final basePricecontroller = TextEditingController();
  List<TextEditingController> _controllerDiamond = [];
  final List<TextEditingController> _controllerGemstone = [];
  final List<TextEditingController> _amountDiamond = [];
  final List<TextEditingController> _amountGemstone = [];

  List<Widget> _dynamicWidgetsDiamond = [];
  List<Widget> _dynamicWidgetsGemstone = [];
  final ImagePicker picker = ImagePicker();
  String id = "";
  File? image;
  var imageName = "ชื่อรูปภาพ";

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
    setState(() {
      id = ids!;
    });
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
          if (diamondColorArr.isEmpty) {
          } else if (_dynamicWidgetsDiamond.length > diamondColorArr.length) {
          } else {
            diamondColorArr.removeAt(arr.length - 1);
          }
          if (diamondClarity.isEmpty) {
          } else if (_dynamicWidgetsDiamond.length > diamondClarity.length) {
          } else {
            diamondClarity.removeAt(arr.length - 1);
          }
          if (diamondCut.isEmpty) {
          } else if (_dynamicWidgetsDiamond.length > diamondCut.length) {
          } else {
            diamondCut.removeAt(arr.length - 1);
          }
        }
        arr.removeAt(arr.length - 1);
        controller.removeAt(controller.length - 1);
        amount.removeAt(amount.length - 1);
        print(diamondColorArr);
        print(diamondClarity);
        print(diamondCut);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context);

    void clearValue() {
      setState(() {
        selectedclarity = null;
        selectedcolor = null;
        selectedcut = null;
        _dynamicWidgetsDiamond = [];
        _dynamicWidgetsGemstone = [];
        diamond = "";
        amountD = "";
        diamondcontroller.text = "";
        amountDcontroller.text = "";
        pricecontroller.text = "";
        basePricecontroller.text = "";
        price = "";
        basePrice = "";
        imageName = "ชื่อรูปภาพ";
        image = null;
        _controllerDiamond = [];
        diamondColorArr = [];
        diamondClarity = [];
        diamondCut = [];
        amountGemstone = [];
        caratGemstone = [];
        material = [];
        diamondJson = [];
        gemstoneJson = [];
        amountG = "";
        gemstone = "";
        amountDiamond = [];
        caratDiamond = [];
      });
    }

    Future<void> uploadFormData({
      required String productCategory,
      required String productCode,
      required int createBy,
      required String imagePath,
      required int price,
      required String basePrice,
      required List<Map<String, dynamic>> material,
      required List<Map<String, dynamic>> diamond,
      required List<Map<String, dynamic>> gemstone,
      required File file,
    }) async {
      //String url = 'http://10.0.2.2:8000/insertProduct';
      String url =
          'http://10.0.2.2:8000/insertProduct?productCategory=${productCategory}&productCode=${productCode}&createBy=${createBy}&imagePath=${imageName}&price=${price}&basePrice=${basePrice}';
      Map<String, String> requestData = {
        // 'productCategory': productCategory,
        // 'createBy': createBy.toString(),
        // 'imagePath': imagePath,
        // 'price': price.toString(),
        // 'basePrice': basePrice,
        'material': jsonEncode(material),
        'diamond': jsonEncode(diamond),
        'gemstone': jsonEncode(gemstone),
      };

      try {
        var request = http.MultipartRequest('POST', Uri.parse(url));

        // Add form fields
        requestData.forEach((key, value) {
          request.fields[key] = value;
        });

        // Convert the image file to MultipartFile
        List<int> imageBytes = await file.readAsBytes();
        String fileName = file.path.split('/').last;
        request.files.add(http.MultipartFile.fromBytes('file', imageBytes,
            filename: fileName));

        // Send the request and get the response
        var response = await request.send();

        if (response.statusCode == 200) {
          // Request successful, handle the response
          var responseData = await response.stream.bytesToString();
          print('Response: ${json.decode(responseData)}');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('ลงข้อมูลสำเร็จ'),
            ),
          );
        } else {
          // Request failed with an error status code
          print(request.fields.values);
          print('Request failed with status: ${response.statusCode}');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('ลงข้อมูลไม่สำเร็จ โปรดลองใหม่'),
            ),
          );
        }
      } catch (e) {
        // Error occurred during the request
        print('Error: $e');
      }
    }

    getUserId();
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
                                controller: pricecontroller,
                                validator: _validateInput,
                                onSaved: (value) {
                                  price = value!;
                                },
                                textInputAction: TextInputAction.next,
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
                                controller: basePricecontroller,
                                validator: _validateInput,
                                onSaved: (value) {
                                  basePrice = value!;
                                },
                                textInputAction: TextInputAction.next,
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
                                  controller: amountDcontroller,
                                  onSaved: (value) {
                                    amountD = value!;
                                  },
                                  textInputAction: TextInputAction.next,
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
                                  controller: diamondcontroller,
                                  onSaved: (value) {
                                    diamond = value!;
                                  },
                                  textInputAction: TextInputAction.next,
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
                                      hint: const Text("น้ำ"),
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
                                      dropdownStyleData: DropdownStyleData(
                                          maxHeight: 250,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14)),
                                          scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(40),
                                              thickness:
                                                  MaterialStateProperty.all(6),
                                              thumbVisibility:
                                                  MaterialStateProperty.all(
                                                      true))),
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
                                      dropdownStyleData: DropdownStyleData(
                                          maxHeight: 250,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14)),
                                          scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(40),
                                              thickness:
                                                  MaterialStateProperty.all(6),
                                              thumbVisibility:
                                                  MaterialStateProperty.all(
                                                      true))),
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
                                      dropdownStyleData: DropdownStyleData(
                                          maxHeight: 250,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14)),
                                          scrollbarTheme: ScrollbarThemeData(
                                              radius: const Radius.circular(40),
                                              thickness:
                                                  MaterialStateProperty.all(6),
                                              thumbVisibility:
                                                  MaterialStateProperty.all(
                                                      true))),
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
                                  textInputAction: TextInputAction.next,
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
                                  textInputAction: TextInputAction.next,
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
                        children: [
                          for (var i = 0;
                              i < _dynamicWidgetsGemstone.length;
                              i++)
                            GemstoneCard(i)
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
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: "น้ำหนัก",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
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
                                    textInputAction: TextInputAction.next,
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
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: const SingleChildScrollView(
                                          child: Text(
                                              "ต้องการลบข้อมูลใช่หรือไม่ ?"),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  {Navigator.of(context).pop()},
                                              child: const Text("ยกเลิก")),
                                          TextButton(
                                              onPressed: () => {
                                                    clearValue(),
                                                    Navigator.of(context).pop()
                                                  },
                                              child: const Text("ลบ"))
                                        ],
                                        title: const Text("ลบข้อมูล"),
                                      );
                                    });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 120,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.red.shade400),
                                child: const Text(
                                  "เคลีย",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          TextButton(
                              onPressed: () => {
                                    //productCategory : str, createBy : int, imagePath : str, price : int, basePrice : str, material : list, diamond : list, gemstone : list, file: UploadFile
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
                                            setState(() {
                                              caratDiamond.add(diamond);
                                              amountDiamond.add(amountD);
                                              amountGemstone.add(amountG);
                                              caratGemstone.add(gemstone);
                                              if (selectedcolor == null) {
                                              } else {
                                                diamondColorArr.add(
                                                    int.parse(selectedcolor!));
                                              }
                                              if (selectedclarity == null) {
                                              } else {
                                                diamondClarity
                                                    .add(selectedclarity);
                                              }
                                              if (selectedcut == null) {
                                              } else {
                                                diamondCut.add(selectedcut);
                                              }
                                              print(diamondColorArr);

                                              Map<String, dynamic> materialMap =
                                                  {
                                                'MaterialType':
                                                    selectedValueGold,
                                                'MaterialWeight': goldWeight,
                                                'MaterialPercent': goldPercent,
                                              };
                                              material.add(materialMap);

                                              for (var i = 0;
                                                  i < amountDiamond.length;
                                                  i++) {
                                                print(caratDiamond);
                                                if (diamond.isEmpty) {
                                                } else {
                                                  Map<String, dynamic>
                                                      diamondMap = {
                                                    'Carat': caratDiamond[i],
                                                    "Color": diamondColorArr[i],
                                                    "Cut": diamondCut[i],
                                                    "Clarity":
                                                        diamondClarity[i],
                                                    "Certificated": "None",
                                                    "Amount": int.parse(
                                                        amountDiamond[i]),
                                                  };
                                                  diamondJson.add(diamondMap);
                                                }
                                              }

                                              for (var x = 0;
                                                  x < amountGemstone.length;
                                                  x++) {
                                                if (caratGemstone[x].length ==
                                                    0) {
                                                } else {
                                                  Map<String, dynamic>
                                                      gemstoneMap = {
                                                    "Carat": double.parse(
                                                        caratGemstone[x]),
                                                    "Amount": int.parse(
                                                        amountGemstone[x]),
                                                  };
                                                  gemstoneJson.add(gemstoneMap);
                                                }
                                              }
                                              uploadFormData(
                                                  productCategory:
                                                      selectedValue.toString(),
                                                  productCode: category[items
                                                          .indexOf(selectedValue
                                                              .toString())]
                                                      .toString(),
                                                  createBy: int.parse(id),
                                                  imagePath: imageName,
                                                  price: int.parse(price),
                                                  basePrice: basePrice,
                                                  material: material,
                                                  diamond: diamondJson,
                                                  gemstone: gemstoneJson,
                                                  file: image!);
                                              clearValue();
                                            })
                                          },
                                      }
                                  },
                              child: Container(
                                alignment: Alignment.center,
                                width: 120,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.green.shade400),
                                child: const Text(
                                  "ยืนยัน",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                    textInputAction: TextInputAction.next,
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
                    textInputAction: TextInputAction.next,
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
