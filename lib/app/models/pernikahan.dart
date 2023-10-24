import 'package:nylo_framework/nylo_framework.dart';

/// Pernikahan Model.

class Pernikahan extends Model {
  final int? id;
  final String? namaPria, namaWanita;
  final String? tanggal;
  final int? usia;
  final String? alamat;
  final int? idUnit;

  Pernikahan({this.id, this.namaPria, this.namaWanita, this.tanggal, this.usia, this.alamat, this.idUnit});
  
  factory Pernikahan.fromJson(Map<String, dynamic> data) => Pernikahan(
    id: int.tryParse(data['id']),
    namaPria: data['suami'],
    namaWanita: data['istri'],
    tanggal: data['tanggal_menikah'],
    usia: int.tryParse(data['usia']),
    alamat: data['alamat'],
    idUnit: int.tryParse(data['id_unit']),
  );

  toJson() {

  }
}
