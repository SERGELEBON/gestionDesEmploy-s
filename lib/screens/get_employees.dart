import 'package:employeemanagement/screens/employee_drawer.dart';
import 'package:flutter/material.dart';

class GetEmployees extends StatefulWidget {
  const GetEmployees({super.key});

  @override
  State<GetEmployees> createState() => _GetEmployeesState();
}

class _GetEmployeesState extends State<GetEmployees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Employees détails'),
          backgroundColor: Colors.amber,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmployeeDrawer(),
                  ),
                );
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Container());
  }
}
