import 'package:flutter/material.dart';
import 'package:sakt/screens/forgetpassword.dart';
import 'package:sakt/screens/home.dart';
import 'package:sakt/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _loading = true;
  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  Future<void> _checkLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    setState(() {
      _loggedIn = token != null;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _loggedIn ? const Home() : const Login(),
      routes: {
        '/login': (context) => const Login(),
        '/forgetpassword': (context) => const Forgetpassword(),
        '/home': (context) => const Home(),
      },
    );
  }
}
