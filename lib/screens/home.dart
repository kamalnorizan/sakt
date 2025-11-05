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
      // appBar: AppBar(
      //   title: const Text('Home'),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.logout),
      //       onPressed: () async {
      //         await SharedPreferences.getInstance().then((prefs) {
      //           prefs.remove('access_token');
      //           prefs.remove('name');
      //           Navigator.pushReplacementNamed(context, '/login');
      //         });
      //       },
      //     ),
      //   ],
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(color: Colors.blue),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
              child: Text(
                'Welcome to the Home Screen!',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
                ListTile(
                  isThreeLine: true,
                  leading: CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.pregnant_woman, size: 40),
                  ),
                  minLeadingWidth: 40,
                  title: Text('WA 4437 - AMYRA ROSLI'),
                  subtitle: Text('Lot: A-01-05, Aras: 1, Bangunan: A'),
                  onTap: () {
                    // Navigate to profile screen
                  },
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 30),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              color: Colors.blue,
            ),
            child: Text('Last Synced: 12-09-2023 10:45 AM'),
          ),
        ],
      ),
    );
  }
}
