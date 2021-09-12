import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController {
  final Rx<String> imageFilePath = ''.obs;

  Future<void> pickImage(ImageSource source) async {
    XFile? selectedFile = await ImagePicker().pickImage(source: source);
    imageFilePath.value = selectedFile != null ? selectedFile.path : '';
  }
}
