import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilesoft_example/common/constants.dart';
import 'package:mobilesoft_example/controllers/employees_controller.dart';
import 'package:mobilesoft_example/data/models/employee.dart';
import 'package:mobilesoft_example/view/widgets/photo_view.dart';

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(RouteNames.CREATE_EMPLOYEE),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GetX<EmployeesController>(
              init: EmployeesController(),
              builder: (controller) {
                return controller.employees.isNotEmpty
                    ? ListView.separated(
                        itemBuilder: (context, index) {
                          Employee _employee = controller.employees[index];

                          return GestureDetector(
                            onTap: () {
                              controller.selectEmployee(index);
                              controller.getDetails();
                              Get.toNamed(RouteNames.DETAIL);
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    PhotoView(
                                      photoUrl: _employee.photoUrl,
                                      dimension: 50,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(_employee.name),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, position) =>
                            const SizedBox(height: 5),
                        itemCount: controller.employees.length,
                      )
                    : const Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }
}
