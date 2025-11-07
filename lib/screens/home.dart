import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sakt/models/permohonanResponse.dart';
import 'package:sakt/screens/permohonanDetail.dart';
import 'package:sakt/utils/networkApi.dart';
import 'package:sakt/widgets/bottomMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PermohonanResponse? permohonanResponse;
  bool _isloadpermohonan = true;
  List<Permohonan>? filteredPermohonan = [];
  TextEditingController searchController = TextEditingController();

  List<Map<String, Object>> cardData = [
    {'title': 'Pas Keselamatan', 'value': 100},
    {'title': 'Pelekat Kenderaan', 'value': 20},
    {'title': 'Petak Wanita Hamil', 'value': 60},
    {'title': 'Petak Tetamu/VIP', 'value': 40},
    {'title': 'Tinggal Kenderaan', 'value': 10},
  ];
  @override
  void initState() {
    super.initState();
    _loadPermohonan();
  }

  Future<void> _loadPermohonan() async {
    // Simulate loading data

    setState(() {
      _isloadpermohonan = true;
    });
    NetworkApi request = NetworkApi(
      path: 'permohonan/bydate',
      timeout: Duration(seconds: 20),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    DateTime now = DateTime.now();

    final response = await request.post(
      'permohonan/bydate',
      headers: {'Authorization': 'Bearer $token'},
      body: {'date': now.toIso8601String().split('T').first},
    );

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        permohonanResponse = PermohonanResponse.fromJson(data['data']);
        filteredPermohonan = permohonanResponse!.permohonan!;
      });
    } else {
      // Handle error
      print('Failed to load permohonan data');
    }

    _isloadpermohonan = false;
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
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Colors.blue),
            alignment: Alignment.topCenter,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 160.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: cardData.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${i['title']}',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            Text(
                              '${i['value']}',
                              style: TextStyle(fontSize: 60.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Positioned(
            top: 280,
            left: 0,
            height: MediaQuery.of(context).size.height - 280,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 280,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Text(
                    'Permohonan Hari Ini',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: _isloadpermohonan
                        ? Center(child: CircularProgressIndicator())
                        : filteredPermohonan!.isEmpty
                        ? Text('Tiada Permohonan Aktif untuk Hari ini')
                        : ListView.builder(
                            itemCount: filteredPermohonan?.length ?? 0,
                            padding: EdgeInsets.all(0),
                            itemBuilder: (context, index) => ListTile(
                              isThreeLine: true,
                              leading: CircleAvatar(
                                radius: 30,
                                child: Icon(Icons.pregnant_woman, size: 40),
                              ),
                              minLeadingWidth: 40,
                              title: Text(
                                '${filteredPermohonan![index].vehicleDetails.noPendaftaran} - ${filteredPermohonan![index].user.name}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                (filteredPermohonan![index].lot?.name ??
                                        'Open Parking') +
                                    ' | ${filteredPermohonan![index].vehicleDetails.model ?? '-'} | ${filteredPermohonan![index].vehicleDetails.warna ?? 'N/A'}',
                              ),
                              trailing: Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Permohonandetail(
                                      permohonan: permohonanResponse!
                                          .permohonan![index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 240,
            left: 15,
            height: 65,
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width - 30,
                height: 65,
                padding: EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Carian',
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    filteredPermohonan = permohonanResponse?.permohonan
                        ?.where(
                          (permohonan) =>
                              permohonan.vehicleDetails.noPendaftaran
                                  .toLowerCase()
                                  .contains(value.toLowerCase()) ||
                              permohonan.user.name.toLowerCase().contains(
                                value.toLowerCase(),
                              ) ||
                              permohonan.lot!.name.toLowerCase().contains(
                                value.toLowerCase(),
                              ),
                        )
                        .toList();

                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              width: MediaQuery.of(context).size.width - 40,

              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: BottomMenu( selectedMenu: 'home'),
            ),
          ),
          Positioned(
            bottom: 23,
            left: (MediaQuery.of(context).size.width - 40) / 2 - 30,
            child: Image.asset(
              'assets/logo2.png',
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
