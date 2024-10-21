import 'package:employeemanagement/screens/get_employees.dart';
import 'package:flutter/material.dart';

class DeleteEmployees extends StatefulWidget {
  DeleteEmployees({super.key});

  @override
  State<DeleteEmployees> createState() => _DeleteEmployeesState();
}

class _DeleteEmployeesState extends State<DeleteEmployees> {
  @override
  Widget build(BuildContext context) {
    return GetEmployees();
  }
}
