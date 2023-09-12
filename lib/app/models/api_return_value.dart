import 'package:nylo_framework/nylo_framework.dart';

/// ApiReturnValue Model.

class ApiReturnValue<T> extends Model {
  int? code;
  String? message;
  bool status;
  T? value;
  ApiReturnValue({this.code = 400, this.status = false, this.message, this.value});
  
  factory ApiReturnValue.fromJson(Map<String, dynamic> data, {T? value}) => ApiReturnValue(
    code: data['meta']['code'],
    status: data['meta']['status'],
    message: data['meta']['message'],
    value: value
  );
  
  toJson() {

  }
}
