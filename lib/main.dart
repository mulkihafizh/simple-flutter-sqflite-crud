import 'package:flutter/material.dart';
import 'package:coba/screens/home_screen.dart';
import 'package:coba/screens/create_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple CRUD SQFlite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(),
        "/create": (context) => const CreateScreen(),
      },
    );
  }
}
