import 'package:nylo_framework/nylo_framework.dart';

/// Sektor Model.

class Sektor extends Model {
  int? id;
  String? namaSektor;
  Sektor({this.id, this.namaSektor});
  
  factory Sektor.fromJson(Map<String, dynamic> data) => Sektor(
    id : data['id'],
    namaSektor : data['nama_sektor']
  );

  Map<String, dynamic> toJson() {
    return {'id' : id, 'nama_sektor' : namaSektor};
  }
}
