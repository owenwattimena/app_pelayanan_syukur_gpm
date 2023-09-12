import 'package:nylo_framework/nylo_framework.dart';

/// Unit Model.

class Unit extends Model {
  final int? id;
  final String? namaUnit;
  final int? idSektor;
  Unit({this.id, this.namaUnit, this.idSektor});
  
  factory Unit.fromJson(Map<String, dynamic> data) => Unit(
    id: data['id'],
    namaUnit: data['nama_unit'],
    idSektor: data['id_sektor']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama_unit' : namaUnit,
    'id_sektor' : idSektor
  };
}
