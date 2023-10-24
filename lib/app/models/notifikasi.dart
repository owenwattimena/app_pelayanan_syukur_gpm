import 'package:nylo_framework/nylo_framework.dart';

/// Notifikasi Model.

class Notifikasi extends Model {
  final int? id;
  final String? judul;
  final String? isi;
  final int? idUnit;
  final String? createdAt;
  Notifikasi({this.id, this.judul, this.isi, this.idUnit, this.createdAt});
  
  factory Notifikasi.fromJson(Map<String, dynamic> json) => Notifikasi(
    id: json['id'],
    judul: json['judul'],
    isi: json['isi'],
    idUnit: int.tryParse(json['id_unit']),
    createdAt: json['created_at']
  );

  Map<String, dynamic> toJson() => {
    'judul' : this.judul,
    'isi' : this.isi,
    'id_unit' : this.idUnit,
  };
}
