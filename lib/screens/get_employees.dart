import 'dart:convert';

import 'package:employeemanagement/Models/employee_model.dart';
import 'package:employeemanagement/screens/delete_employee.dart';
import 'package:employeemanagement/screens/employee_drawer.dart';
import 'package:employeemanagement/screens/update_employee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetEmployees extends StatefulWidget {
  const GetEmployees({super.key});

  @override
  State<GetEmployees> createState() => _GetEmployeesState();
}

class _GetEmployeesState extends State<GetEmployees> {
  var employees = List<EmployeeModel>.generate(
    200,
    (index) => EmployeeModel(
        id: index, firstName: 'FirstName $index', lastName: 'LastName $index'),
  );

  Future<List<EmployeeModel>> getEmployees() async {
    var data =
        await http.get(Uri.parse("http://localhost:8080/getallemployees"));
    var jsonData = json.decode(data.body);

    List<EmployeeModel> employeeList = [];

    for (var e in jsonData) {
      EmployeeModel employee = EmployeeModel(
          id: e['id'], firstName: e['firstName'], lastName: e['lastName']);
      employeeList.add(employee);
    }

    return employeeList; // Ajoutez toujours un return ici
  }

  @override // Déplacez la méthode build ici
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
        body: Container(
          child: FutureBuilder(
              future: getEmployees(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<EmployeeModel>?> snapshot) {
                if (snapshot.data == null) {
                  return Container(
                      child: Center(
                    child: Icon(Icons.error),
                  ));
                } else {
                  //+
                  return ListView.builder(
                    //+
                    itemCount: snapshot.data!.length, //+
                    itemBuilder: (context, index) {
                      //+
                      return ListTile(
                        //+
                        //title: Text(snapshot.data![index].firstName), //+
                        //subtitle: Text(snapshot.data![index].lastName),
                        title: Text('ID' + 'First Name' + ' Last Name'),
                        subtitle: Text('$snapshot.data![index].firstName' +
                            '$snapshot.data![index].lastName' +
                            '$snapshot.data[!index].id'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                employee: snapshot.data![index],
                              ),
                            ),
                          );
                        }, //+
                      ); //+
                    }, //+
                  ); //
                }
              }), //-
        )); //-
  }
}

class DetailPage extends StatelessWidget {
  EmployeeModel employee;
  DetailPage({required this.employee});

  DeleteEmployee1(EmployeeModel employee) async {
    final url = Uri.parse("https://localhost:8080/deleteemployee");
    final request = http.Request("SUPPRIMER", url);
    request.headers.addAll(<String, String>{
      'Content-Type': 'application/json',
    });
    request.body = json.encode(employee);
    final response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employee.firstName),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateEmployees(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Delete the employee data
            },
          ),
        ],
      ),
      body: Container(
        child: Text("Nom " +
            employee.firstName +
            '\n' "Prenom " +
            employee.lastName +
            '\n' " Sa reférence" +
            employee.id.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DeleteEmployee1(employee);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DeleteEmployees(employee)),
          );
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
