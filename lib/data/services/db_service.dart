import 'dart:typed_data';

import 'package:floor/floor.dart';
import 'package:mobilesoft_example/data/models/employee.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'db_service.g.dart'; // the generated code will be there

@Database(version: 2, entities: [Employee])
abstract class AppDatabase extends FloorDatabase {
  EmployeeDao get employeeDao;
}

@dao
abstract class EmployeeDao {
  // watch the list of all employees
  @Query('SELECT * FROM Employee')
  Stream<List<Employee>> watchEmployees();

  // add new employee record
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addEmployees(List<Employee> emp);

  // add new employee record
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> addEmployee(Employee emp);
}
