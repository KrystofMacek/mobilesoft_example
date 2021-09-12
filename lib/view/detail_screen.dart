import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilesoft_example/controllers/employees_controller.dart';
import 'package:mobilesoft_example/data/models/employee.dart';
import 'package:mobilesoft_example/view/widgets/photo_view.dart';

class DetailScreen extends GetWidget<EmployeesController> {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Employee _employee =
        controller.employees[controller.selectedEmployee.value];
    return Scaffold(
      appBar: AppBar(
        title: Text(_employee.name),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 200),
          child: Column(
            children: [
              PhotoView(photoUrl: _employee.photoUrl, dimension: 200),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Department'),
                  Text(_employee.department),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Salary'),
                  Text(_employee.salary >= 0
                      ? _employee.salary.toString()
                      : '---')
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Address'),
                  Text(_employee.address),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
