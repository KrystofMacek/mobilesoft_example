import 'dart:typed_data';

import 'package:floor/floor.dart';

@entity
class Employee {
  Employee({
    required this.id,
    required this.name,
    required this.department,
    required this.salary,
    required this.photoUrl,
    required this.address,
    required this.encodedPhoto,
  });

  @primaryKey
  final int id;
  final String name;
  final String department;
  final int salary;
  final String photoUrl;
  final String address;
  final Uint8List encodedPhoto;

  Employee copyWith(
    int id,
    String name,
    String department,
    int salary,
    String photoUrl,
    String address,
    Uint8List encodedPhoto,
  ) =>
      Employee(
        id: id,
        name: name,
        department: department,
        salary: salary,
        photoUrl: photoUrl,
        address: address,
        encodedPhoto: encodedPhoto,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "department": department,
        "address": address,
        "salary": salary,
      };

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"] ?? -1,
        name: json["name"] ?? '',
        department: json["department"] ?? '',
        salary: json["salary"] ?? -1,
        photoUrl: json["photoUrl"] ?? '',
        address: json["address"] ?? '',
        encodedPhoto: json["encodedPhoto"] ?? Uint8List(0),
      );

  static List<Employee> listFromJson(list) =>
      List<Employee>.from(list.map((x) => Employee.fromJson(x)));
}
