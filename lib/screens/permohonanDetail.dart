import 'package:flutter/material.dart';
import 'package:sakt/models/permohonanResponse.dart';

class Permohonandetail extends StatefulWidget {
  Permohonan permohonan;

  Permohonandetail({required this.permohonan, super.key});

  @override
  State<Permohonandetail> createState() => _PermohonandetailState();
}

class _PermohonandetailState extends State<Permohonandetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Status Permohonan ${widget.permohonan.vehicleDetails.noPendaftaran}',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No Rujukan: ${widget.permohonan.noRujukan}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Nama Pemohon: ${widget.permohonan.user.name}'),
            SizedBox(height: 10),
            Text(
              'No Pendaftaran Kenderaan: ${widget.permohonan.vehicleDetails.noPendaftaran}',
            ),
            SizedBox(height: 10),
            Text('Tarikh Mohon: ${widget.permohonan.tarikhMohon}'),
            SizedBox(height: 10),
            Text('Tarikh Mula: ${widget.permohonan.period.tarikhMula}'),
            SizedBox(height: 10),
            Text('Tarikh Tamat: ${widget.permohonan.period.tarikhTamat}'),
            SizedBox(height: 10),
            Text(
              'Status Permohonan: ${widget.permohonan.statusPermohonanText}',
            ),
            // Add more fields as necessary
          ],
        ),
      ),
    );
  }
}
