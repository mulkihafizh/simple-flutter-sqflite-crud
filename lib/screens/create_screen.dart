import 'package:flutter/material.dart';
import 'package:coba/services/database_service.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  Map<String, dynamic> user = {
    'name': '',
    'address': '',
    'age': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Screen'),
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
                onChanged: (value) {
                  user['name'] = value;
                },
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                onChanged: (value) {
                  user['address'] = value;
                },
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              TextField(
                keyboardType: TextInputType.number,
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
                  DatabaseService.instance.createUser(user);
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ));
  }
}
