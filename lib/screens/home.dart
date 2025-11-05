import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sakt/models/permohonanResponse.dart';
import 'package:sakt/screens/permohonanDetail.dart';
import 'package:sakt/utils/networkApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PermohonanResponse? permohonanResponse;

  @override
  void initState() {
    super.initState();
    _loadPermohonan();
  }

  Future<void> _loadPermohonan() async {
    // Simulate loading data
    NetworkApi request = NetworkApi(
      path: 'permohonan/bydate',
      timeout: Duration(seconds: 20),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    DateTime now = DateTime.now();

    print(now.toIso8601String().split('T').first);
    final response = await request.post(
      'permohonan/bydate',
      headers: {'Authorization': 'Bearer $token'},
      body: {'date': now.toIso8601String().split('T').first},
    );

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        permohonanResponse = PermohonanResponse.fromJson(data['data']);
      });
    } else {
      // Handle error
      print('Failed to load permohonan data');
    }
  }

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
            child: ListView.builder(
              itemCount: permohonanResponse?.permohonan?.length ?? 0,

              itemBuilder: (context, index) => ListTile(
                isThreeLine: true,
                leading: CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.pregnant_woman, size: 40),
                ),
                minLeadingWidth: 40,
                title: Text(
                  '${permohonanResponse!.permohonan![index].vehicleDetails.noPendaftaran} - ${permohonanResponse!.permohonan![index].user.name}',
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  (permohonanResponse!.permohonan![index].lot?.name ??
                          'Open Parking') +
                      ' | ${permohonanResponse!.permohonan![index].vehicleDetails.model ?? '-'} | ${permohonanResponse!.permohonan![index].vehicleDetails.warna ?? 'N/A'}',
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Permohonandetail(
                        permohonan: permohonanResponse!.permohonan![index],
                      ),
                    ),
                  );
                },
              ),
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
