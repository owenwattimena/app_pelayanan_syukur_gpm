import '/app/models/notifikasi.dart';
import '/app/models/pengaturan.dart';
import '/app/models/push_notification.dart';
import '../app/models/user.dart';
import '../app/networking/dio/base_api_service.dart';
import '/app/models/kelahiran.dart';
import '/app/models/pernikahan.dart';
import '/app/models/sektor_unit.dart';
import '/app/models/token.dart';
import '/app/models/api_return_value.dart';
import '/app/models/unit.dart';
import '/app/models/sektor.dart';
import '/app/networking/api_service.dart';

/*
|--------------------------------------------------------------------------
| Model Decoders
| -------------------------------------------------------------------------
| Model decoders are used in 'app/networking/' for morphing json payloads
| into Models.
|
| Learn more https://nylo.dev/docs/5.x/decoders#model-decoders
|--------------------------------------------------------------------------
*/

final Map<Type, dynamic> modelDecoders = {
  List<User>: (data) => List.from(data).map((json) => User.fromJson(json)).toList(),
  //
  User: (data) => User.fromJson(data),

  // User: (data) => User.fromJson(data),

  List<Sektor>: (data) => List.from(data).map((json) => Sektor.fromJson(json)).toList(),

  Sektor: (data) => Sektor.fromJson(data),

  List<Unit>: (data) => List.from(data).map((json) => Unit.fromJson(json)).toList(),

  Unit: (data) => Unit.fromJson(data),

  List<ApiReturnValue>: (data) => List.from(data).map((json) => ApiReturnValue.fromJson(json)).toList(),

  ApiReturnValue: (data) => ApiReturnValue.fromJson(data),

  List<Token>: (data) => List.from(data).map((json) => Token.fromJson(json)).toList(),

  Token: (data) => Token.fromJson(data),

  List<SektorUnit>: (data) => List.from(data).map((json) => SektorUnit.fromJson(json)).toList(),

  SektorUnit: (data) => SektorUnit.fromJson(data),

  List<Pernikahan>: (data) => List.from(data).map((json) => Pernikahan.fromJson(json)).toList(),

  Pernikahan: (data) => Pernikahan.fromJson(data),

  List<Kelahiran>: (data) => List.from(data).map((json) => Kelahiran.fromJson(json)).toList(),

  Kelahiran: (data) => Kelahiran.fromJson(data),

  List<PushNotification>: (data) => List.from(data).map((json) => PushNotification.fromJson(json)).toList(),

  PushNotification: (data) => PushNotification.fromJson(data),

  List<Pengaturan>: (data) => List.from(data).map((json) => Pengaturan.fromJson(json)).toList(),

  Pengaturan: (data) => Pengaturan.fromJson(data),

  List<Notifikasi>: (data) => List.from(data).map((json) => Notifikasi.fromJson(json)).toList(),

  Notifikasi: (data) => Notifikasi.fromJson(data),
};

/*
|--------------------------------------------------------------------------
| API Decoders
| -------------------------------------------------------------------------
| API decoders are used when you need to access an API service using the
| 'api' helper. E.g. api<MyApiService>((request) => request.fetchData());
|
| Learn more https://nylo.dev/docs/5.x/decoders#api-decoders
|--------------------------------------------------------------------------
*/

final Map<Type, BaseApiService> apiDecoders = {
  ApiService: ApiService(),

  // ...
};
