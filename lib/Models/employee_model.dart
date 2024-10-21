import 'dart:convert';

EmployeeModel employeeModelJson(String str) =>
    EmployeeModel.fromJson(json.decode(str));

String employeeModelToJson(EmployeeModel data) =>
    json.decode(data as String).toJson();

class EmployeeModel {
  int id;
  String firstName;
  String lastName;

  EmployeeModel(
      {required this.id, required this.firstName, required this.lastName});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
        id: json['id'] as int,
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
      };
  String get fullName => '$firstName $lastName';
  bool get isManager => lastName.toLowerCase().contains('manager');
}
