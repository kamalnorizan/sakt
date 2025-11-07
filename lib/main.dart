import 'package:flutter/material.dart';
import 'package:sakt/screens/dateselect.dart';
import 'package:sakt/screens/forgetpassword.dart';
import 'package:sakt/screens/home.dart';
import 'package:sakt/screens/login.dart';
import 'package:sakt/utils/networkApi.dart';
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
  bool isLoggedIn = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png', width: 200),
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? Home() : Login(),
      routes: {
        '/login': (context) => Login(),
        '/forgetpassword': (context) => Forgetpassword(),
        '/home': (context) => Home(),
        '/dateSelect': (context) => DateSelect(),
      },
    );
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    if (token != null && token.isNotEmpty) {
      // NetworkApi request = NetworkApi(
      //   path: 'profile',
      //   timeout: Duration(seconds: 20),
      // );

      // final response = await request.get(
      //   'profile',
      //   headers: {'Authorization': 'Bearer $token'},
      // );
      // print(response.body);
      // if (response.statusCode == 200) {
      setState(() {
        isLoggedIn = true;
        isLoading = false;
      });
      // } else {
      //   await SharedPreferences.getInstance().then((prefs) {
      //     prefs.remove('access_token');
      //     prefs.remove('name');
      //   });
      //   setState(() {
      //     isLoggedIn = false;
      //     isLoading = false;
      //   });
      // }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
