import 'dart:convert';

import 'package:employeemanagement/Models/employee_model.dart';
import 'package:employeemanagement/screens/employee_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterEmployee extends StatefulWidget {
  const RegisterEmployee({super.key});

  @override
  State<RegisterEmployee> createState() => _RegisterEmployeeState();
}

Future<EmployeeModel> registerEmployees(
    String firstName, String lastName, BuildContext context) async {
  var url = Uri.parse("http://localhost:8080/addemployee");

  var response = await http.post(url,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
          <String, String>{"firstName": firstName, "lastName": lastName}));

  if (response.statusCode == 200) {
    String responseString = response.body;

    // Afficher un dialogue avec la réponse du backend
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return MyAlertDialog(
              title: "Backend Response", content: Text(response.body));
        });

    // Retourner un EmployeeModel à partir de la réponse
    return EmployeeModel.fromJson(jsonDecode(responseString));
  } else {
    // Si le statut de la réponse n'est pas 200, lancer une exception
    throw Exception(
        'Erreur lors de l\'inscription de l\'employé : ${response.statusCode}');
  }
}

class _RegisterEmployeeState extends State<RegisterEmployee> {
  final minimumPadding = 5.0;

  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Employee"),
      ),
      body: Form(
          child: Padding(
        padding: EdgeInsets.all(minimumPadding * 2),
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
              child: TextFormField(
                style: textStyle,
                controller: firstController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "First Name is required";
                  }
                  if (value.length < 3) {
                    return "First Name should be at least 3 characters long";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "First Name",
                  hintText: "Enter you first name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
              child: TextFormField(
                style: textStyle,
                controller: lastController,
                validator: (String? Value) {
                  if (Value!.isEmpty) {
                    return "Last Name is required";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Last Name",
                  hintText: "Enter you last name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmployeeDrawer(),
                  ),
                );
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      )),
    );
  }
}

class MyAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final List<Widget> actions;

  MyAlertDialog({
    required this.title,
    required this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      actions: this.actions,
      content: Text(
        this.content as String,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
