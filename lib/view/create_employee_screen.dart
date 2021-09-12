import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilesoft_example/controllers/form_controller.dart';
import 'package:mobilesoft_example/view/widgets/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CreateEmployeeScreen extends StatelessWidget {
  const CreateEmployeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New employee'),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GetX<FormController>(
            init: FormController(),
            builder: (controller) => ModalProgressHUD(
              inAsyncCall: controller.asyncState.value,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const ImagePickerView(),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: controller.nameInput,
                                      decoration: const InputDecoration(
                                          labelText: 'Name'),
                                    ),
                                    TextField(
                                      controller: controller.addressInput,
                                      decoration: const InputDecoration(
                                          labelText: 'Address'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller.departmentInput,
                                  decoration: const InputDecoration(
                                      labelText: 'Department'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller.salaryInput,
                                  decoration: const InputDecoration(
                                    labelText: 'Salary',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                child: const Text('Submit'),
                                elevation: 2,
                                color: Colors.grey[600],
                                onPressed: () {
                                  controller.submit();
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
