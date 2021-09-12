import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:mobilesoft_example/data/models/employee.dart';

class ApiService extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = 'http://testapp.mobilesoft.cz/api/';
  }

  // Future<Response> getEmployeesList() => get('employees');

  Future<Response<List<Employee>>> getEmployeesList() => get<List<Employee>>(
        'employees',
        decoder: Employee.listFromJson,
      );

  Future<Response<Employee>> getEmployeeDetail(int id) => get<Employee>(
        'employees/$id',
        decoder: (emp) => Employee.fromJson(emp),
      );

  Future<Response<Employee>> postEmployee(FormData data) => post<Employee>(
        'employees',
        data,
        headers: {
          'Content-Type': 'multipart/form-data; boundary=BOUNDARY',
        },
        decoder: (emp) => Employee.fromJson(emp),
        contentType: 'multipart/form-data',
      );
}
