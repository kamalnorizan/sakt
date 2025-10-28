import 'package:flutter/material.dart';
import 'package:sakt/screens/login.dart';

void main() {
  runApp(const Login());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // Action for settings button
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Action for FAB
          },
          backgroundColor: Colors.deepOrange,
          child: Icon(Icons.add),
        ),
        body: Center(child: Text('Hello World!')),
      ),
    );
  }
}
