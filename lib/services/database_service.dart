import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();

  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('school');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE users (
      id $idType,
      name $textType,
      address $textType,
      age $textType
    )''');
  }

  Future<int> createUser(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('users', row);
  }

  Future<int> updateUser(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db
        .update('users', row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<List<Map<String, dynamic>>> readAllUsers() async {
    final db = await instance.database;
    return await db.query('users');
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  static checkInput(Map<String, dynamic> user, BuildContext context) {
    int numAge = int.tryParse(user['age']) ?? 0;
    if (user['name'] == '' ||
        user['address'] == '' ||
        user['age'] == '' ||
        numAge <= 0 ||
        numAge % 1 != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields with valid data!'),
        ),
      );
      return false;
    }
    return true;
  }
}
