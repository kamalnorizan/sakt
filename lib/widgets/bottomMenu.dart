import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomMenu extends StatefulWidget {
  BottomMenu({required this.selectedMenu, super.key});

  String selectedMenu;
  @override
  State<BottomMenu> createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(
            Icons.home,
            color: widget.selectedMenu == 'home' ? Colors.blue : Colors.grey,
          ),
          onPressed: () async {
            if (widget.selectedMenu == 'home') return;
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        IconButton(
          icon: Icon(
            Icons.calendar_month_sharp,
            color: widget.selectedMenu == 'dateSelect'
                ? Colors.blue
                : Colors.grey,
          ),
          onPressed: () async {
            if (widget.selectedMenu == 'dateSelect') return;
            Navigator.pushReplacementNamed(context, '/dateSelect');
          },
        ),
        SizedBox(width: 50),
        IconButton(
          icon: Icon(Icons.sync, color: Colors.grey),
          onPressed: () async {
            if (widget.selectedMenu == 'sync') return;
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        IconButton(
          icon: Icon(Icons.logout, color: Colors.grey),
          onPressed: () async {
            await SharedPreferences.getInstance().then((prefs) {
              prefs.remove('access_token');
              prefs.remove('name');
              if (!context.mounted) return;

              Navigator.pushReplacementNamed(context, '/login');
            });
          },
        ),
      ],
    );
  }
}
