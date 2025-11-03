import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              //logout action
              await SharedPreferences.getInstance().then((prefs) {
                prefs.remove('auth_token');
                Navigator.pushReplacementNamed(context, '/login');
              });
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(child: Text('Welcome to the Home Screen!')),
    );
  }
}
