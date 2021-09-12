import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobilesoft_example/controllers/image_picker_controller.dart';
import 'package:get/get.dart';

class ImagePickerView extends StatelessWidget {
  const ImagePickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<ImagePickerController>(
      init: ImagePickerController(),
      builder: (controller) {
        final String filePath = controller.imageFilePath.value;

        if (filePath.isNotEmpty) {
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: 150,
              height: 150,
              child: Image.file(
                File(controller.imageFilePath.value),
                fit: BoxFit.contain,
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () => Get.dialog(
              AlertDialog(
                title: const Text('Select from:'),
                actions: [
                  MaterialButton(
                    onPressed: () => controller
                        .pickImage(ImageSource.camera)
                        .then((value) => Get.back()),
                    child: const Text('Camera'),
                  ),
                  MaterialButton(
                    onPressed: () => controller
                        .pickImage(ImageSource.gallery)
                        .then((value) => Get.back()),
                    child: const Text('Gallery'),
                  ),
                ],
              ),
            ),
            child: Container(
              width: 150,
              height: 150,
              color: Colors.grey[600],
              child: const Center(child: Text('Select Photo')),
            ),
          );
        }
      },
    );
  }
}
