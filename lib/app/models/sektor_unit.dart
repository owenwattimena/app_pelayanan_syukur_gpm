import 'package:nylo_framework/nylo_framework.dart';

/// SektorUnit Model.

class SektorUnit extends Model {
  final int? idSektor;
  final String? sektor;
  final int? idUnit;
  final String? unit;
  SektorUnit({this.idSektor, this.sektor, this.idUnit, this.unit});
  
  factory SektorUnit.fromJson(Map<String, dynamic> data) => SektorUnit(
    idSektor: data['sektor']['id'],
    sektor: data['sektor']['nama_sektor'],
    idUnit: data['id'],
    unit: data['nama_unit'],
  );

  toJson() {

  }
}
