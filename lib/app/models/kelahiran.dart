import 'package:nylo_framework/nylo_framework.dart';

/// Kelahiran Model.

class Kelahiran extends Model {
  final int? id;
  final String? nama;
  final String? tanggal;
  final String? jam;
  final String? alamat;
  final int? idUnit;

  Kelahiran({this.id, this.nama, this.tanggal, this.jam, this.alamat, this.idUnit});
  
  factory Kelahiran.fromJson(Map<String, dynamic> data) => Kelahiran(
    id: data['id'],
    nama: data['nama'],
    tanggal: data['tanggal'],
    jam: data['jam'],
    alamat: data['alamat'],
    idUnit: data['id_unit']
  );

  toJson() {

  }
}
