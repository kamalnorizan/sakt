import 'dart:convert';

class PermohonanResponse {
  final String requestedDate;
  final int totalRecords;
  final List<Permohonan>? permohonan;

  PermohonanResponse({
    required this.requestedDate,
    required this.totalRecords,
    this.permohonan,
  });

  factory PermohonanResponse.fromJson(Map<String, dynamic> json) {
    return PermohonanResponse(
      requestedDate: json['requested_date'],
      totalRecords: json['total_records'],
      permohonan: (json['permohonan_list'] as List)
          .map((e) => Permohonan.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'requested_date': requestedDate,
    'total_records': totalRecords,
    'permohonan': permohonan?.map((e) => e.toJson()).toList(),
  };
}

class Permohonan {
  final int id;
  final String uuid;
  final String noRujukan;
  final User user;
  final Lot? lot;
  final VehicleDetails vehicleDetails;
  final ParkingDetails parkingDetails;
  final Period period;
  final String tujuan;
  final String tarikhMohon;
  final int statusPermohonan;
  final String statusPermohonanText;
  final String createdAt;

  Permohonan({
    required this.id,
    required this.uuid,
    required this.noRujukan,
    required this.user,
    this.lot,
    required this.vehicleDetails,
    required this.parkingDetails,
    required this.period,
    required this.tujuan,
    required this.tarikhMohon,
    required this.statusPermohonan,
    required this.statusPermohonanText,
    required this.createdAt,
  });

  factory Permohonan.fromJson(Map<String, dynamic> json) {
    return Permohonan(
      id: json['id'],
      uuid: json['uuid'],
      noRujukan: json['no_rujukan'],
      user: User.fromJson(json['user']),
      lot: json['lot'] != null
          ? Lot.fromJson(json['lot'])
          : Lot.fromJson({'id': 0, 'name': 'Open Parking'}),
      vehicleDetails: VehicleDetails.fromJson(json['vehicle_details']),
      parkingDetails: ParkingDetails.fromJson(json['parking_details']),
      period: Period.fromJson(json['period']),
      tujuan: json['tujuan'],
      tarikhMohon: json['tarikh_mohon'],
      statusPermohonan: json['status_permohonan'],
      statusPermohonanText: json['status_permohonan_text'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'uuid': uuid,
    'no_rujukan': noRujukan,
    'user': user.toJson(),
    'lot': lot?.toJson(),
    'vehicle_details': vehicleDetails.toJson(),
    'parking_details': parkingDetails.toJson(),
    'period': period.toJson(),
    'tujuan': tujuan,
    'tarikh_mohon': tarikhMohon,
    'status_permohonan': statusPermohonan,
    'status_permohonan_text': statusPermohonanText,
    'created_at': createdAt,
  };
}

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json['id'], name: json['name'], email: json['email']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'email': email};
}

class Lot {
  final int id;
  final String name;

  Lot({required this.id, required this.name});

  factory Lot.fromJson(Map<String, dynamic> json) =>
      Lot(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class VehicleDetails {
  final String model;
  final String noPendaftaran;
  final String? warna;

  VehicleDetails({
    required this.model,
    required this.noPendaftaran,
    this.warna,
  });

  factory VehicleDetails.fromJson(Map<String, dynamic> json) => VehicleDetails(
    model: json['model'],
    noPendaftaran: json['no_pendaftaran'],
    warna: json['warna'],
  );

  Map<String, dynamic> toJson() => {
    'model': model,
    'no_pendaftaran': noPendaftaran,
    'warna': warna,
  };
}

class ParkingDetails {
  final String aras;
  final String bangunan;

  ParkingDetails({required this.aras, required this.bangunan});

  factory ParkingDetails.fromJson(Map<String, dynamic> json) =>
      ParkingDetails(aras: json['aras'], bangunan: json['bangunan']);

  Map<String, dynamic> toJson() => {'aras': aras, 'bangunan': bangunan};
}

class Period {
  final String tarikhMula;
  final String tarikhTamat;

  Period({required this.tarikhMula, required this.tarikhTamat});

  factory Period.fromJson(Map<String, dynamic> json) => Period(
    tarikhMula: json['tarikh_mula'],
    tarikhTamat: json['tarikh_tamat'],
  );

  Map<String, dynamic> toJson() => {
    'tarikh_mula': tarikhMula,
    'tarikh_tamat': tarikhTamat,
  };
}

/// Helper to decode from raw JSON string
PermohonanResponse permohonanResponseFromJson(String str) =>
    PermohonanResponse.fromJson(json.decode(str));

/// Helper to encode back to JSON string
String permohonanResponseToJson(PermohonanResponse data) =>
    json.encode(data.toJson());
