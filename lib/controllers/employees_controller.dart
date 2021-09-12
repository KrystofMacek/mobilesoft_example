import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobilesoft_example/data/models/employee.dart';
import 'package:mobilesoft_example/data/services/api_service.dart';
import 'package:mobilesoft_example/data/services/db_service.dart';

class EmployeesController extends GetxController {
  final RxList<Employee> employees = <Employee>[].obs;
  final RxInt selectedEmployee = 0.obs;

  final ApiService _apiService = Get.put(ApiService());
  EmployeeDao? _employeeDao;

  @override
  void onInit() async {
    super.onInit();
    // inject db
    await Get.putAsync(
            () => $FloorAppDatabase.databaseBuilder('app_database.db').build())
        .then((db) {
      // initialize dao object
      _employeeDao = db.employeeDao;
      // initialize list of users as a stream from db.
      Stream<List<Employee>>? stream = _employeeDao?.watchEmployees();
      if (stream != null) {
        employees.bindStream(stream);
      }
    });
  }

  @override
  void onReady() async {
    super.onReady();

    // after initialization of controller, get the data from api
    _apiService.getEmployeesList().then((res) {
      List<Employee> _employees = res.body ?? [];
      _employeeDao?.addEmployees(_employees);

      // load and save image individually using compute

      // if (_employees.isNotEmpty) {
      //   List<Employee> emp =
      //       _employees.where((element) => element.photoUrl.isNotEmpty).toList();

      //   compute(_loadPhotos, emp).then((list) {
      //     for (var e in list) {
      //       print('id ${e.id}');
      //     }
      //     _employeeDao?.addEmployees(list);
      //   });
      // }
    }).onError((error, stackTrace) {
      Get.snackbar('EmpController getList', error.toString());
    });
  }

  // select employee displayed in detail page
  void selectEmployee(int id) => selectedEmployee.value = id;

  // get detail information for selected employee
  void getDetails() {
    _apiService.getEmployeeDetail(selectedEmployee.value).then((res) {
      Employee? e = res.body;
      if (e != null) {
        _employeeDao?.addEmployee(e);
      }
    }).onError((error, stackTrace) {
      Get.snackbar('EmpController getDetails', error.toString());
    });
  }

  // create new employee
  Future<void> uploadEmployee(
    Map<String, dynamic> data,
    String filePath,
  ) async {
    try {
      // get name of file
      String name = filePath.split('/').last;

      // initialize form data
      FormData? formData = FormData({'json': data, 'photo': null});

      if (filePath.isNotEmpty) {
        Uint8List bytes = File(filePath).readAsBytesSync();

        // if there is file specified - add Multipart file with image data
        formData = FormData({
          'json': data,
          'photo': MultipartFile(
            bytes,
            filename: name,
            contentType: 'image/${name.split(".").last}',
          )
        });
      }

      // call post request uploading the formData
      _apiService.postEmployee(formData).then((res) {
        Employee? e = res.body;
        // print(res.statusText);
        Get.snackbar('after post Employee: ', 'status text: ${res.statusText}');
      }).onError((error, stackTrace) {
        Get.snackbar('postEmployee', error.toString());
      });
    } catch (e) {
      Get.snackbar('postEmployee', e.toString());
    }
  }
}

//get individual photos and return list with updated employee records
FutureOr<List<Employee>> _loadPhotos(List<Employee> _employees) async {
  List<Employee> _newList = [];
  for (Employee e in _employees) {
    try {
      ByteData _data = await NetworkAssetBundle(
              Uri.parse('http://testapp.mobilesoft.cz${e.photoUrl}'))
          .load('');

      Uint8List _imgData = _data.buffer.asUint8List();
      Employee _e = e.copyWith(
        e.id,
        e.name,
        e.department,
        e.salary,
        e.photoUrl,
        e.address,
        _imgData,
      );
      _newList.add(_e);
    } catch (e) {
      Get.snackbar('EmpController', e.toString());
    }
  }

  return _newList;
}
