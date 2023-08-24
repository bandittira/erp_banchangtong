import 'dart:convert';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:erp_banchangtong/pages/home/controller/var.dart';
import 'package:erp_banchangtong/pages/inventory/components/diamond_card.dart';
import 'package:erp_banchangtong/pages/inventory/components/gemstone_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../home/controller/get_product.dart';
import 'controller/get_id.dart';
import 'controller/var.dart' as vars;
import 'controller/var.dart';

class InsertProduct extends StatefulWidget {
  const InsertProduct({super.key});

  @override
  State<InsertProduct> createState() => _InsertProductState();
}

class _InsertProductState extends State<InsertProduct> {
  GetProductId getProductIdClass = GetProductId();
  final _formKey = GlobalKey<FormState>();
  String price = "";
  String basePrice = "";
  String goldWeight = "";
  String goldPercent = "";
  String diamond = "";
  String amountD = "";
  String gemstone = "";
  String amountG = "";
  RxString id = "".obs;
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

  Future<void> ids() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("Id") != null) {
      id.value = prefs.getString("Id").toString();
      print(id.value);
    }
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
          "กะรัต",
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
          "กะรัต",
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
          if (vars.diamondColorArr.isEmpty) {
          } else if (_dynamicWidgetsDiamond.length >
              vars.diamondColorArr.length) {
          } else {
            vars.diamondColorArr.removeAt(arr.length - 1);
          }
          if (vars.diamondClarity.isEmpty) {
          } else if (_dynamicWidgetsDiamond.length >
              vars.diamondClarity.length) {
          } else {
            vars.diamondClarity.removeAt(arr.length - 1);
          }
          if (vars.diamondCut.isEmpty) {
          } else if (_dynamicWidgetsDiamond.length > vars.diamondCut.length) {
          } else {
            vars.diamondCut.removeAt(arr.length - 1);
          }
        }
        arr.removeAt(arr.length - 1);
        controller.removeAt(controller.length - 1);
        amount.removeAt(amount.length - 1);
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
        vars.selectedclarity = null;
        vars.selectedcolor = null;
        vars.selectedcut = null;
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
        vars.diamondColorArr = [];
        vars.diamondClarity = [];
        vars.diamondCut = [];
        amountGemstone = [];
        caratGemstone = [];
        vars.material = [];
        vars.diamondJson = [];
        vars.gemstoneJson = [];
        amountG = "";
        gemstone = "";
        vars.amountDiamond = [];
        vars.caratDiamond = [];
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
      //String url = 'http://49.0.192.147:8000/insertProduct';
      String url =
          'http://49.0.192.147:8000/insertProduct?productCategory=${productCategory}&productCode=${productCode}&createBy=${createBy}&imagePath=${imageName}&price=${price}&basePrice=${basePrice}';
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
          GetProductDetails().getProductDetails();
          GetProductDetails().getAllProduct();
          pushProduct();
          Get.snackbar("สำเร็จ", "ลงข้อมูลสำเร็จ");
        } else {
          // Request failed with an error status code
          print(request.fields.values);
          print('Request failed with status: ${response.statusCode}');
          Get.snackbar("ไม่สำเร็จ", "ไม่สำเร็จ โปรดลองใหม่อีกครั้ง");
        }
      } catch (e) {
        // Error occurred during the request
        print('Error: $e');
      }
    }

    ids();
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
                      Row(
                        children: [
                          const Text(
                            "รหัสสินค้า ",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Obx(() => Text(
                                '#$productCode $productId',
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent),
                              )),
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
                              child: Obx(() => DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: const Text("หมวดหมู่"),
                                    items: vars.items
                                        .map((String item) =>
                                            DropdownMenuItem<String>(
                                                value: item, child: Text(item)))
                                        .toList(),
                                    value: vars.selectedValue!.value,
                                    onChanged: (value) {
                                      vars.selectedValue!.value = value!;
                                      getProductIdClass.getProductId(
                                          vars.category[vars.items.indexOf(
                                              vars.selectedValue!.value)],
                                          "insert");
                                    },
                                  )),
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
                                  basePrice = value!.toUpperCase();
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
                                      hintText: "กะรัต",
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
                                            vars.diamondColorArr)
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
                                width: screen.size.width / 4.0,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey.shade200),
                                child: SingleChildScrollView(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: const Text("น้ำ"),
                                      items: vars.diamondColor
                                          .map((int item) =>
                                              DropdownMenuItem<String>(
                                                  value: item.toString(),
                                                  child: Text(item.toString())))
                                          .toList(),
                                      value: vars.selectedcolor,
                                      onChanged: (value) {
                                        setState(() {
                                          vars.selectedcolor = value;
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
                                width: screen.size.width / 3.8,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey.shade200),
                                child: SingleChildScrollView(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton2<String>(
                                      isExpanded: true,
                                      hint: const Text("ตำหนิ"),
                                      items: vars.clarity
                                          .map((String item) =>
                                              DropdownMenuItem<String>(
                                                  value: item.toString(),
                                                  child: Text(item.toString())))
                                          .toList(),
                                      value: vars.selectedclarity,
                                      onChanged: (value) {
                                        setState(() {
                                          vars.selectedclarity = value;
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
                                      items: vars.cut
                                          .map((String item) =>
                                              DropdownMenuItem<String>(
                                                  value: item.toString(),
                                                  child: Text(item.toString())))
                                          .toList(),
                                      value: vars.selectedcut,
                                      onChanged: (value) {
                                        setState(() {
                                          vars.selectedcut = value;
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
                                      hintText: "กะรัต",
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
                                items: vars.goldType
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                            value: item, child: Text(item)))
                                    .toList(),
                                value: vars.selectedValueGold,
                                onChanged: (value) {
                                  setState(() {
                                    vars.selectedValueGold = value;
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
                                        if (vars.selectedValue!.value == "")
                                          {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content:
                                                    Text('โปรดเลือกหมวดหมู่'),
                                              ),
                                            )
                                          }
                                        else if (vars.selectedValueGold == null)
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
                                              vars.caratDiamond.add(diamond);
                                              vars.amountDiamond.add(amountD);
                                              amountGemstone.add(amountG);
                                              caratGemstone.add(gemstone);
                                              if (vars.selectedcolor == null) {
                                              } else {
                                                vars.diamondColorArr.add(
                                                    int.parse(
                                                        vars.selectedcolor!));
                                              }
                                              if (vars.selectedclarity ==
                                                  null) {
                                              } else {
                                                vars.diamondClarity
                                                    .add(vars.selectedclarity);
                                              }
                                              if (vars.selectedcut == null) {
                                              } else {
                                                vars.diamondCut
                                                    .add(vars.selectedcut);
                                              }
                                              print(vars.diamondColorArr);

                                              Map<String, dynamic> materialMap =
                                                  {
                                                'MaterialType':
                                                    vars.selectedValueGold,
                                                'MaterialWeight': goldWeight,
                                                'MaterialPercent': goldPercent,
                                              };
                                              vars.material.add(materialMap);

                                              for (var i = 0;
                                                  i < vars.amountDiamond.length;
                                                  i++) {
                                                print(vars.caratDiamond);
                                                if (diamond.isEmpty) {
                                                } else {
                                                  Map<String, dynamic>
                                                      diamondMap = {
                                                    'Carat':
                                                        vars.caratDiamond[i],
                                                    "Color":
                                                        vars.diamondColorArr[i],
                                                    "Cut": vars.diamondCut[i],
                                                    "Clarity":
                                                        vars.diamondClarity[i],
                                                    "Certificated": "None",
                                                    "Amount": int.parse(
                                                        vars.amountDiamond[i]),
                                                  };
                                                  vars.diamondJson
                                                      .add(diamondMap);
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
                                                  vars.gemstoneJson
                                                      .add(gemstoneMap);
                                                }
                                              }
                                              uploadFormData(
                                                  productCategory: vars
                                                      .selectedValue!.value
                                                      .toString(),
                                                  productCode: vars
                                                      .category[vars.items
                                                          .indexOf(vars
                                                              .selectedValue!
                                                              .value
                                                              .toString())]
                                                      .toString(),
                                                  createBy: int.parse(id.value),
                                                  imagePath: imageName,
                                                  price: int.parse(price),
                                                  basePrice: basePrice,
                                                  material: vars.material,
                                                  diamond: vars.diamondJson,
                                                  gemstone: vars.gemstoneJson,
                                                  file: image!);
                                              // uploadFormData(
                                              //     productCategory: "Ring",
                                              //     productCode: "RD",
                                              //     createBy: 1,
                                              //     imagePath: imageName,
                                              //     price: 3333,
                                              //     basePrice: "PRXX",
                                              //     material: vars.material,
                                              //     diamond: vars.diamondJson,
                                              //     gemstone: vars.gemstoneJson,
                                              //     file: image!);
                                              clearValue();
                                            }),
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
