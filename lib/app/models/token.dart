import 'package:nylo_framework/nylo_framework.dart';

/// Token Model.

class Token extends Model {
  final String? token;
  Token({this.token});
  
  factory Token.fromJson(Map<String, dynamic> data) => Token(token: data['data']['token']);

  Map<String, dynamic> toJson() => {
    'token' : this.token 
  };
}
