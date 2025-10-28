import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/logo.jpg', width: 350),
              const Text(
                'LOGIN',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text('Welcome back! Please sign in to your account.'),
              Text('Hello World'),
              Text('Hello World'),
            ],
          ),
        ),
      ),
    );
  }
}
