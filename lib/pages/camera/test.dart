import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ImagePreview extends StatefulWidget {
  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Preview")),
      body: Center(
        child: QrImageView(
          data: 'RD1000002',
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
