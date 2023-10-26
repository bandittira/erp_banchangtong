// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:erp_banchangtong/pages/inventory/controller/get_product_detail.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Printer extends StatelessWidget {
  const Printer(
      this.title,
      this.productCode,
      this.price,
      this.basePrice,
      this.goldType,
      this.goldWeight,
      this.goldPercent,
      this.diamond,
      this.gemstone,
      {Key? key})
      : super(key: key);

  final String productCode;
  final String price;
  final String basePrice;

  final String goldType;
  final String goldWeight;
  final String goldPercent;

  final List diamond;

  final List gemstone;

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PdfPreview(
          build: (format) => _generatePdf(format, title),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.kanitMedium();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Padding(
              padding: const pw.EdgeInsets.only(top: 50),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  pw.SizedBox(width: 50),
                  pw.Column(children: [
                    pw.SizedBox(
                      child: pw.FittedBox(
                        child: pw.BarcodeWidget(
                            color: PdfColor.fromHex("#000000"),
                            barcode: pw.Barcode.qrCode(),
                            data: productCode.toString(),
                            width: 100,
                            height: 100),
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(productCode.toString(),
                        style: const pw.TextStyle(fontSize: 16)),
                    pw.SizedBox(height: 20),
                    pw.Text('$price BAHT',
                        style: const pw.TextStyle(fontSize: 16)),
                    pw.SizedBox(height: 5),
                    pw.Text(basePrice.toString(),
                        style: const pw.TextStyle(fontSize: 16)),
                  ]),
                  pw.SizedBox(
                    width: 15,
                  ),
                  pw.Column(children: [
                    pw.SizedBox(
                      child: pw.FittedBox(
                        child: pw.Text('$goldType $goldPercent %',
                            style: pw.TextStyle(font: font, fontSize: 15)),
                      ),
                    ),
                    pw.SizedBox(
                      child: pw.FittedBox(
                        child: pw.Text('หนัก $goldWeight กรัม',
                            style: pw.TextStyle(font: font, fontSize: 15)),
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Column(children: [
                      for (int x = 0;
                          x < productDetailArray['productDiamonds'].length;
                          x++)
                        pw.Column(children: [
                          pw.SizedBox(
                            child: pw.FittedBox(
                              child: pw.Text(
                                  'เพชร ${productDetailArray['productDiamonds'][x]['Amount']} เม็ด ${productDetailArray['productDiamonds'][x]['Carat']}',
                                  style:
                                      pw.TextStyle(font: font, fontSize: 15)),
                            ),
                          ),
                          pw.SizedBox(
                            child: pw.FittedBox(
                              child: pw.Text(
                                  '${productDetailArray['productDiamonds'][x]['Color']} ${productDetailArray['productDiamonds'][x]['Clarity']}',
                                  style:
                                      pw.TextStyle(font: font, fontSize: 15)),
                            ),
                          ),
                        ]),
                    ]),
                    pw.SizedBox(height: 10),
                    pw.Column(children: [
                      for (int x = 0;
                          x < productDetailArray['productGems'].length;
                          x++)
                        pw.Column(children: [
                          pw.SizedBox(
                            child: pw.FittedBox(
                              child: pw.Text(
                                  'พลอย ${productDetailArray['productGems'][x]['Amount']} เม็ด ${productDetailArray['productGems'][x]['Carat']}',
                                  style:
                                      pw.TextStyle(font: font, fontSize: 15)),
                            ),
                          ),
                        ]),
                    ]),
                  ]),
                  pw.SizedBox(width: 50),
                ],
              ));
        },
      ),
    );

    return pdf.save();
  }
}

// import 'dart:async';
// import 'dart:convert';

// import 'package:bluetooth_print/bluetooth_print.dart';
// import 'package:bluetooth_print/bluetooth_print_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class Printer extends StatefulWidget {
//   @override
//   _PrinterState createState() => _PrinterState();
// }

// class _PrinterState extends State<Printer> {
//   BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

//   bool _connected = false;
//   BluetoothDevice? _device;
//   String tips = 'no device connect';

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initBluetooth() async {
//     bluetoothPrint.startScan(timeout: Duration(seconds: 4));

//     bool isConnected = await bluetoothPrint.isConnected ?? false;

//     bluetoothPrint.state.listen((state) {
//       print('******************* cur device status: $state');

//       switch (state) {
//         case BluetoothPrint.CONNECTED:
//           setState(() {
//             _connected = true;
//             tips = 'connect success';
//           });
//           break;
//         case BluetoothPrint.DISCONNECTED:
//           setState(() {
//             _connected = false;
//             tips = 'disconnect success';
//           });
//           break;
//         default:
//           break;
//       }
//     });

//     if (!mounted) return;

//     if (isConnected) {
//       setState(() {
//         _connected = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('BluetoothPrint example app'),
//         ),
//         body: RefreshIndicator(
//           onRefresh: () =>
//               bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Padding(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                       child: Text(tips),
//                     ),
//                   ],
//                 ),
//                 Divider(),
//                 StreamBuilder<List<BluetoothDevice>>(
//                   stream: bluetoothPrint.scanResults,
//                   initialData: [],
//                   builder: (c, snapshot) => Column(
//                     children: snapshot.data!
//                         .map((d) => ListTile(
//                               title: Text(d.name ?? ''),
//                               subtitle: Text(d.address ?? ''),
//                               onTap: () async {
//                                 setState(() {
//                                   _device = d;
//                                 });
//                               },
//                               trailing: _device != null &&
//                                       _device!.address == d.address
//                                   ? Icon(
//                                       Icons.check,
//                                       color: Colors.green,
//                                     )
//                                   : null,
//                             ))
//                         .toList(),
//                   ),
//                 ),
//                 Divider(),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
//                   child: Column(
//                     children: <Widget>[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           OutlinedButton(
//                             child: Text('connect'),
//                             onPressed: _connected
//                                 ? null
//                                 : () async {
//                                     if (_device != null &&
//                                         _device!.address != null) {
//                                       setState(() {
//                                         tips = 'connecting...';
//                                       });
//                                       await bluetoothPrint.connect(_device!);
//                                     } else {
//                                       setState(() {
//                                         tips = 'please select device';
//                                       });
//                                       print('please select device');
//                                     }
//                                   },
//                           ),
//                           SizedBox(width: 10.0),
//                           OutlinedButton(
//                             child: Text('disconnect'),
//                             onPressed: _connected
//                                 ? () async {
//                                     setState(() {
//                                       tips = 'disconnecting...';
//                                     });
//                                     await bluetoothPrint.disconnect();
//                                   }
//                                 : null,
//                           ),
//                         ],
//                       ),
//                       Divider(),
//                       OutlinedButton(
//                         child: Text('print receipt(esc)'),
//                         onPressed: _connected
//                             ? () async {
//                                 Map<String, dynamic> config = Map();

//                                 config['width'] = 40;
//                                 config['height'] = 70;
//                                 config['gap'] = 2;

//                                 List<LineText> list = [];

//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     content:
//                                         '**********************************************',
//                                     weight: 1,
//                                     align: LineText.ALIGN_CENTER,
//                                     linefeed: 1));
//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     content: '打印单据头',
//                                     weight: 1,
//                                     align: LineText.ALIGN_CENTER,
//                                     fontZoom: 2,
//                                     linefeed: 1));
//                                 list.add(LineText(linefeed: 1));

//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     content:
//                                         '----------------------明细---------------------',
//                                     weight: 1,
//                                     align: LineText.ALIGN_CENTER,
//                                     linefeed: 1));
//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     content: '物资名称规格型号',
//                                     weight: 1,
//                                     align: LineText.ALIGN_LEFT,
//                                     x: 0,
//                                     relativeX: 0,
//                                     linefeed: 0));
//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     content: '单位',
//                                     weight: 1,
//                                     align: LineText.ALIGN_LEFT,
//                                     x: 350,
//                                     relativeX: 0,
//                                     linefeed: 0));
//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     content: '数量',
//                                     weight: 1,
//                                     align: LineText.ALIGN_LEFT,
//                                     x: 500,
//                                     relativeX: 0,
//                                     linefeed: 1));

//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     content: '混凝土C30',
//                                     align: LineText.ALIGN_LEFT,
//                                     x: 0,
//                                     relativeX: 0,
//                                     linefeed: 0));
//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     content: '吨',
//                                     align: LineText.ALIGN_LEFT,
//                                     x: 350,
//                                     relativeX: 0,
//                                     linefeed: 0));
//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     content: '12.0',
//                                     align: LineText.ALIGN_LEFT,
//                                     x: 500,
//                                     relativeX: 0,
//                                     linefeed: 1));

//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     content:
//                                         '**********************************************',
//                                     weight: 1,
//                                     align: LineText.ALIGN_CENTER,
//                                     linefeed: 1));
//                                 list.add(LineText(linefeed: 1));

//                                 ByteData data = await rootBundle
//                                     .load("assets/images/bluetooth_print.png");
//                                 List<int> imageBytes = data.buffer.asUint8List(
//                                     data.offsetInBytes, data.lengthInBytes);
//                                 String base64Image = base64Encode(imageBytes);
//                                 // list.add(LineText(type: LineText.TYPE_IMAGE, content: base64Image, align: LineText.ALIGN_CENTER, linefeed: 1));

//                                 await bluetoothPrint.printReceipt(config, list);
//                               }
//                             : null,
//                       ),
//                       OutlinedButton(
//                         child: Text('print label(tsc)'),
//                         onPressed: _connected
//                             ? () async {
//                                 Map<String, dynamic> config = Map();
//                                 config['width'] = 40; // 标签宽度，单位mm
//                                 config['height'] = 70; // 标签高度，单位mm
//                                 config['gap'] = 2; // 标签间隔，单位mm

//                                 // x、y坐标位置，单位dpi，1mm=8dpi
//                                 List<LineText> list = [];
//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     x: 10,
//                                     y: 10,
//                                     content: 'A Title'));
//                                 list.add(LineText(
//                                     type: LineText.TYPE_TEXT,
//                                     x: 10,
//                                     y: 40,
//                                     content: 'this is content'));
//                                 list.add(LineText(
//                                     type: LineText.TYPE_QRCODE,
//                                     x: 10,
//                                     y: 70,
//                                     content: 'qrcode i\n'));
//                                 list.add(LineText(
//                                     type: LineText.TYPE_BARCODE,
//                                     x: 10,
//                                     y: 190,
//                                     content: 'qrcode i\n'));

//                                 List<LineText> list1 = [];
//                                 ByteData data = await rootBundle
//                                     .load("assets/images/guide3.png");
//                                 List<int> imageBytes = data.buffer.asUint8List(
//                                     data.offsetInBytes, data.lengthInBytes);
//                                 String base64Image = base64Encode(imageBytes);
//                                 list1.add(LineText(
//                                   type: LineText.TYPE_IMAGE,
//                                   x: 10,
//                                   y: 10,
//                                   content: base64Image,
//                                 ));

//                                 await bluetoothPrint.printLabel(config, list);
//                                 await bluetoothPrint.printLabel(config, list1);
//                               }
//                             : null,
//                       ),
//                       OutlinedButton(
//                         child: Text('print selftest'),
//                         onPressed: _connected
//                             ? () async {
//                                 await bluetoothPrint.printTest();
//                               }
//                             : null,
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         floatingActionButton: StreamBuilder<bool>(
//           stream: bluetoothPrint.isScanning,
//           initialData: false,
//           builder: (c, snapshot) {
//             if (snapshot.data == true) {
//               return FloatingActionButton(
//                 child: Icon(Icons.stop),
//                 onPressed: () => bluetoothPrint.stopScan(),
//                 backgroundColor: Colors.red,
//               );
//             } else {
//               return FloatingActionButton(
//                   child: Icon(Icons.search),
//                   onPressed: () =>
//                       bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
