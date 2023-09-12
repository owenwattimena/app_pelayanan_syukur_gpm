import 'package:nylo_framework/nylo_framework.dart';

/// Pengaturan Model.

class Pengaturan extends Model {
  final int? id;
  final String? namaJemaat;
  Pengaturan({this.id, this.namaJemaat});

  factory Pengaturan.fromJson(Map<String, dynamic> json) =>
      Pengaturan(id: json['id'], namaJemaat: json['nama_jemaat']);

  toJson() {}
}
