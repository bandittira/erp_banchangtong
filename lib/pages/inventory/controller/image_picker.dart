import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../components/adjust_body.dart';

final Rx<XFile?> selectedFile = Rx<XFile?>(null);

Future pickImage() async {
  final ImagePicker picker = ImagePicker();
  try {
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    selectedFile.value = image;
    imageName.value = (image.name).toString();
  } on PlatformException catch (e) {
    print('Failed to pick image: $e');
  }
}
