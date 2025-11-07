import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sakt/screens/forgetpassword.dart';
import 'package:sakt/screens/web_login.dart';
import 'package:sakt/utils/networkApi.dart';
import 'package:sakt/widgets/bezierContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = 'ziemann.bella@example.org';
    passwordController.text = 'password';
  }

  Future<void> _login() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sila isi semua medan'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
    );

    final request = NetworkApi(path: 'login', timeout: Duration(seconds: 20));
    final response = await request.post(
      'login',
      body: {'email': email, 'password': password},
    );

    if (!mounted) return;
    Navigator.of(context).pop();

    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final token = body['data']['access_token'];
      final name = body['data']['user']['name'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', token);
      await prefs.setString('name', name);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Gagal: ${body['message']}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: -320, child: BezierContainer()),
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png', width: 350),
                Text(
                  'LOGIN',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Selamat Datang, Sila Log Masuk Untuk Teruskan',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 20),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Emel'),
                        controller: emailController,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Kata Laluan',
                        ),
                        controller: passwordController,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _login();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Log Masuk'),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const Forgetpassword(),
                                ),
                              );
                            },
                            child: const Text('Lupa Kata Laluan?'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle register action
                            },
                            child: const Text('Daftar Akaun Baru'),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const WebLogin(
                                loginUrl:
                                    'https://satuid.treasury.gov.my/gk/login?service=https%3A%2F%2Fsak.treasury.gov.my',
                                redirectUrlPattern: '/callback',
                              ),
                            ),
                          );
                        },
                        child: const Text('Log Masuk 1 ID'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
