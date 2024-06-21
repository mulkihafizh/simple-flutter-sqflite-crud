import 'package:flutter/material.dart';
import 'package:coba/services/database_service.dart';
import 'edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    DatabaseService.instance.database;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple CRUD SQLite'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create').then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
      body: studentsList(),
    );
  }

  Widget studentsList() {
    return FutureBuilder(
      future: DatabaseService.instance.readAllUsers(),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          final students = snapshot.data!;
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (BuildContext context, int index) {
              final student = students[index];
              return ListTile(
                onLongPress: () => {
                  _showDialog(students[index], context),
                },
                title: Text(student['name']),
                subtitle: Text(student['address']),
                trailing: Text("Age: ${student['age']}"),
              );
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  void _showDialog(Map<String, dynamic> user, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditScreen(user: user),
                    ),
                  ).then((value) {
                    Navigator.pop(context);
                    setState(() {});
                  });
                },
                child: const Text('Edit'),
              ),
              TextButton(
                onPressed: () {
                  DatabaseService.instance.deleteUser(user['id']);
                  setState(() {});
                  Navigator.pop(context);
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
    );
  }
}
