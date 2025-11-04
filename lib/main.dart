import 'package:flutter/material.dart';
import 'package:sakt/screens/forgetpassword.dart';
import 'package:sakt/screens/home.dart';
import 'package:sakt/screens/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      routes: {
        '/login': (context) => Login(),
        '/forgetpassword': (context) => Forgetpassword(),
        '/home': (context) => Home(),
      },
    );
  }
}
