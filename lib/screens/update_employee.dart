import 'package:flutter/material.dart';

class UpdateEmployees extends StatefulWidget {
  const UpdateEmployees({super.key});

  @override
  State<UpdateEmployees> createState() => _UpdateEmployeesState();
}

class _UpdateEmployeesState extends State<UpdateEmployees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Update Employees'),
          backgroundColor: Colors.amber,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          )),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {},
          child: null,
        ),
      ),
    );
  }
}
