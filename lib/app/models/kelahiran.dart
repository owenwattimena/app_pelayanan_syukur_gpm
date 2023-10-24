import 'package:nylo_framework/nylo_framework.dart';

/// Kelahiran Model.

class Kelahiran extends Model {
  final int? id;
  final String? nama;
  final String? tanggal;
  final int? usia;
  final String? alamat;
  final int? idUnit;

  Kelahiran({this.id, this.nama, this.tanggal, this.usia, this.alamat, this.idUnit});
  
  factory Kelahiran.fromJson(Map<String, dynamic> data) => Kelahiran(
    id: int.tryParse(data['id']),
    nama: data['nama_lengkap'],
    tanggal: data['tanggal_lahir'],
    usia: int.tryParse(data['usia']),
    alamat: data['alamat'],
    idUnit: int.tryParse(data['id_unit'])
  );

  toJson() {

  }
}
