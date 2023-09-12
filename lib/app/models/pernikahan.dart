import 'package:nylo_framework/nylo_framework.dart';

/// Pernikahan Model.

class Pernikahan extends Model {
  final int? id;
  final String? namaPria, namaWanita;
  final String? tanggal;
  final String? jam;
  final String? alamat;
  final int? idUnit;

  Pernikahan({this.id, this.namaPria, this.namaWanita, this.tanggal, this.jam, this.alamat, this.idUnit});
  
  factory Pernikahan.fromJson(Map<String, dynamic> data) => Pernikahan(
    id: data['id'],
    namaPria: data['nama_pria'],
    namaWanita: data['nama_wanita'],
    tanggal: data['tanggal'],
    jam: data['jam'],
    alamat: data['alamat'],
    idUnit: data['id_unit'],
  );

  toJson() {

  }
}
