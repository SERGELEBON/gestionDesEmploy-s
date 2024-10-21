import 'package:flutter/material.dart';

class RegisterEmployee extends StatefulWidget {
  const RegisterEmployee({super.key});

  @override
  State<RegisterEmployee> createState() => _RegisterEmployeeState();
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
              onPressed: () {},
              child: const Text("Submit"),
            ),
          ],
        ),
      )),
    );
  }
}
