import 'package:employeemanagement/screens/get_employees.dart';
import 'package:employeemanagement/screens/register_employee.dart';
import 'package:employeemanagement/screens/update_employee.dart';
import 'package:flutter/material.dart';

class EmployeeDrawer extends StatefulWidget {
  const EmployeeDrawer({super.key});

  @override
  State<EmployeeDrawer> createState() => _EmployeeDrawerState();
}

class _EmployeeDrawerState extends State<EmployeeDrawer> {
  final minimumPadding = 5.0;

  void iconButton() {
    print("Icon Button Button ");
  }

  void _iconSeach() {
    print("Icon Search Button press");
  }

  void _iconAdd() {
    print("Icon add Button press ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion des Employés'),
      ),
      body: const Center(
        child: Text("Bienvenue sur la page des employés"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
          children: <Widget>[
            const DrawerHeader(
              child: Text("Gestion des employés"),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Connexion '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterEmployee(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Ajout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GetEmployees(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Recherche'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateEmployees(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Deconnexion'),
              onTap: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _iconAdd,
        child: Icon(Icons.add),
        tooltip: 'Add',
        backgroundColor: Colors.blue,
      ),
    );
  }
}
