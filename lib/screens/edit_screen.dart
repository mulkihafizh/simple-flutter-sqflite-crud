import 'package:flutter/material.dart';
import 'package:coba/services/database_service.dart';

class EditScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const EditScreen({super.key, required this.user});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late Map<String, dynamic> user;

  @override
  void initState() {
    super.initState();
    user = {...widget.user};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Screen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(text: user['name']),
              onChanged: (value) {
                user['name'] = value;
              },
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: TextEditingController(text: user['address']),
              onChanged: (value) {
                user['address'] = value;
              },
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: user['age']),
              onChanged: (value) {
                user['age'] = value;
              },
              decoration: const InputDecoration(labelText: 'Age'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (DatabaseService.checkInput(user, context) == false) {
                  return;
                }
                DatabaseService.instance.updateUser(user);
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
