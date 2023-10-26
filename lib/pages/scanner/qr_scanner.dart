import 'dart:developer';
import 'dart:io';
import 'package:erp_banchangtong/pages/inventory/adjust_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../inventory/controller/var.dart' as vars;
import '../inventory/components/adjust_body.dart';
import '../inventory/controller/get_product_detail.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void getProductDetail() {
    productCode.value = result!.code.toString().substring(0, 2);
    productId.value = int.parse(result!.code.toString().substring(2, 9));
    selectedValue.value = vars.items[vars.category.indexOf(productCode.value)];
    GetProductDetailsById()
        .getAllProduct(productId.toString(), productCode.toString());
    Get.off(() => const AdjustDetail());
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          children: <Widget>[
            Expanded(flex: 4, child: _buildQrView(context)),
          ],
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 400),
            child: Container(
              width: 180,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child: TextButton(
                onPressed: () => {
                  if (result != null)
                    {getProductDetail()}
                  else
                    {Get.snackbar('ไม่สามารถแสกนได้', 'โปรดแสกนใหม่อีกครั้ง')}
                },
                child: Center(
                  child: (result != null)
                      ? Text('รหัส ${result!.code}')
                      : const Text('โปรดแสกน QR Code'),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
