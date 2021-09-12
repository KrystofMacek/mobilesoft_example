import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobilesoft_example/controllers/employees_controller.dart';
import 'package:mobilesoft_example/controllers/image_picker_controller.dart';

class FormController extends GetxController {
  final RxBool asyncState = false.obs;
  final TextEditingController nameInput = TextEditingController();
  final TextEditingController addressInput = TextEditingController();
  final TextEditingController departmentInput = TextEditingController();
  final TextEditingController salaryInput = TextEditingController();

  // submit new employee
  void submit() {
    // get the path of image file
    String filePath = Get.find<ImagePickerController>().imageFilePath.value;

    // get employee data
    Map<String, dynamic> data = {
      'name': nameInput.text,
      'address': addressInput.text,
      'department': departmentInput.text,
      'salary': int.tryParse(salaryInput.text)
    };
    asyncState.toggle();
    // get Employee controller and call upload
    Get.find<EmployeesController>()
        .uploadEmployee(data, filePath)
        .then((value) => asyncState.toggle());
  }

  @override
  void onClose() {
    nameInput.dispose();
    addressInput.dispose();
    departmentInput.dispose();
    salaryInput.dispose();
    super.onClose();
  }
}
