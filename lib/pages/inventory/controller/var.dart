// Insert Variables

import 'package:get/get_rx/src/rx_types/rx_types.dart';

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
  'RK',
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

// Diamond Cards
RxString? selectedValue = items[0].obs;
RxString productCode = "RD".obs;
RxInt productId = 1000001.obs;
String? selectedValueGold;
String? selectedcolor;
String? selectedclarity;
String? selectedcut;

List diamondColorArr = [];
List diamondClarity = [];
List diamondCut = [];
List<Map<String, dynamic>> material = [];
List<Map<String, dynamic>> diamondJson = [];
List<Map<String, dynamic>> gemstoneJson = [];

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
