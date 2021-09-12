import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilesoft_example/common/constants.dart';
import 'package:mobilesoft_example/view/create_employee_screen.dart';
import 'package:mobilesoft_example/view/detail_screen.dart';
import 'package:mobilesoft_example/view/employees_screen.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: RouteNames.EMPLOYEES,
      getPages: [
        GetPage(
          name: RouteNames.EMPLOYEES,
          page: () => const EmployeesScreen(),
        ),
        GetPage(
          name: RouteNames.CREATE_EMPLOYEE,
          page: () => const CreateEmployeeScreen(),
        ),
        GetPage(
          name: RouteNames.DETAIL,
          page: () => const DetailScreen(),
        ),
      ],
      theme: ThemeData.dark().copyWith(
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.grey[600],
          focusColor: Colors.greenAccent,
        ),
      ),
    ),
  );
}
