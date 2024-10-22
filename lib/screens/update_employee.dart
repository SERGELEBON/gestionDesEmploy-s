import 'dart:convert';

import 'package:employeemanagement/Models/employee_model.dart';
import 'package:employeemanagement/screens/employee_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateEmployees extends StatefulWidget {
  const UpdateEmployees({super.key});

  @override
  State<UpdateEmployees> createState() => _UpdateEmployeesState();
}

class _UpdateEmployeesState extends State<UpdateEmployees> {
  final minimumPadding = 5.0;
  late EmployeeModel employee;

  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();

  Future<EmployeeModel> UpdateEmployees(
      String firstName, String lastName, BuildContext context) async {
    var url = Uri.parse("http://localhost:8080/addemployee");

    var response = await http.post(url,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(employee));

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
          'Erreur lors de l\'enregistrement de l\'employé : ${response.statusCode}');
    }
  }

  /*
    EmployeeModel employee;//+
    final minimumPadding = 5.5;//+
    TextEditingController employeeNumber;//+
    TextEditingController firstNameController;//+
    TextEditingController lastNameController;//+
    bool _isEnabled = false;//+
    Future<EmployeeModel> employees;//+
//+
    @override//+
    void initState() {//+
      super.initState();//+
      employeeNumber = TextEditingController(text: this.employee.id.toString());//+
      firstNameController = TextEditingController(text: this.employee.firstName);//+
      lastNameController = TextEditingController(text: this.employee.lastName);//+
    }//+
    }
*/
  // ... the rest of the component//+

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
      appBar: AppBar(
          title: const Text('Update Employees'),
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
            icon: const Icon(Icons.arrow_back),
          )),
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
              onPressed: () {},
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
