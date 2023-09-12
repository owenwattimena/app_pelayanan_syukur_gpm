import 'package:nylo_framework/nylo_framework.dart';

class User extends Model {
  int? id;
  String? namalengkap;
  String? email;
  String? telepon;
  int? idUnit;
  String? username;
  String? password;
  String? token;

  User({this.id, this.namalengkap, this.email, this.telepon, this.idUnit, this.username, this.password, this.token});

  factory User.fromJson(Map<String, dynamic> data, {String? token}) => User(
    id : data['id'],
    namalengkap : data['nama_lengkap'],
    email : data['email'],
    telepon : data['telepon'],
    idUnit : data['id_unit'],
    username : data['username'],
    password : data['password'] ?? null,
    token: token
  );

  Map<String, dynamic> toJson() => {
    "id": id, 
    "nama_lengkap": namalengkap, 
    "email": email,
    "telepon": telepon,
    "id_unit": idUnit,
    "username": username,
    "password": password,
  };

  User copyWith({String? namaLengkap, String? email, String? telepon}) => User(
    id : this.id,
    namalengkap : namaLengkap ?? this.namalengkap,
    email : email ?? this.email,
    telepon : telepon ?? this.telepon,
    idUnit : this.idUnit,
    username : this.username,
    password : this.password,
    token: token
  );
}
