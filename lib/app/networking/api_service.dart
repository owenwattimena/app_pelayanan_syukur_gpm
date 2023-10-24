import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../app/networking/dio/base_api_service.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../models/api_return_value.dart';
import '../models/kelahiran.dart';
import '../models/notifikasi.dart';
import '../models/pengaturan.dart';
import '../models/pernikahan.dart';
import '../models/sektor.dart';
import '../models/sektor_unit.dart';
import '../models/unit.dart';
import '../models/user.dart';

/*
|--------------------------------------------------------------------------
| ApiService
| -------------------------------------------------------------------------
| Define your API endpoints

| Learn more https://nylo.dev/docs/5.x/networking
|--------------------------------------------------------------------------
*/

class ApiService extends BaseApiService {
  ApiService({BuildContext? buildContext}) : super(buildContext);

  @override
  String get baseUrl => getEnv('API_BASE_URL');

  @override
  final interceptors = {
    if (getEnv('APP_DEBUG') == true) PrettyDioLogger: PrettyDioLogger()
  };

  Future fetchTestData() async {
    return await network(
      request: (request) => request.get("/endpoint-path"),
    );
  }

  Future<List<Sektor>?> fetchSektorData() async {
    return await network<List<Sektor>>(
        request: (request) =>
            request.get("/sektor").timeout(Duration(seconds: 180)),
        handleSuccess: (Response response) {
          List<Sektor> list = [];
          dynamic data = response.data;
          for (int i = 0; i < data['data'].length; i++) {
            list.add(Sektor.fromJson(data['data'][i]));
          }
          return list;
        });
  }

  Future<List<Unit>?> fetchUnitData(int idSektor) async {
    return await network<List<Unit>>(
        request: (request) => request
            .get("/sektor/$idSektor/unit")
            .timeout(Duration(seconds: 180)),
        handleSuccess: (Response response) {
          List<Unit> list = [];
          dynamic data = response.data;
          for (int i = 0; i < data['data'].length; i++) {
            list.add(Unit.fromJson(data['data'][i]));
          }
          return list;
        });
  }

  /// Create a User
  Future<ApiReturnValue?> register({required User user}) async {
    return await network<ApiReturnValue>(
        request: (request) => request.post("/user/daftar", data: user.toJson()),
        handleSuccess: (Response response) {
          dynamic data = response.data;
          return ApiReturnValue.fromJson(data);
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        });
  }

  /// login
  Future<ApiReturnValue?> login({required User user}) async {
    return await network<ApiReturnValue>(
        request: (request) => request.post("/login", data: {
              'username': user.username,
              'password': user.password,
            }),
        handleSuccess: (Response response) {
          dynamic data = response.data;
          return ApiReturnValue<User>.fromJson(data,
              value: User.fromJson(data['data']['user'],
                  token: data['data']['token']));
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        });
  }

  /// pelayanan pernikahan
  Future<ApiReturnValue?> fetchPelayananPernikahanData(
      {required String token, int? limit = null}) async {
    String url = "/pelayanan/pernikahan";
    if (limit != null) {
      url += "?limit=$limit";
    }
    return await network<ApiReturnValue>(
        bearerToken: token,
        request: (request) => request.get(
              url,
            ),
        handleSuccess: (Response response) {
          dynamic data = response.data;
          List<Pernikahan> value = [];
          for (var item in data['data']) {
            value.add(Pernikahan.fromJson(item));
          }
          return ApiReturnValue<List<Pernikahan>>.fromJson(data,
              value: value); // perlu diganti dengan data yg benar
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        });
  }

  /// pelayanan kelahiran
  Future<ApiReturnValue?> fetchPelayananKelahiranData(
      {required String token, int? limit = 3}) async {
    String url = "/pelayanan/kelahiran";
    if (limit != null) {
      url += "?limit=$limit";
    }
    return await network<ApiReturnValue>(
        bearerToken: token,
        request: (request) => request.get(
              url,
            ),
        handleSuccess: (Response response) {
          dynamic data = response.data;
          List<Kelahiran> value = [];
          for (var item in data['data']) {
            value.add(Kelahiran.fromJson(item));
          }
          return ApiReturnValue.fromJson(data, value: value);
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        });
  }

  // detail unit
  Future<ApiReturnValue?> fetchSektorUnitData(
      {required String token, required int idUnit}) async {
    return await network<ApiReturnValue>(
        bearerToken: token,
        request: (request) => request.get("/unit/$idUnit"),
        handleSuccess: (Response response) {
          dynamic data = response.data;
          return ApiReturnValue<SektorUnit>.fromJson(data,
              value: SektorUnit.fromJson(
                  data['data'])); // perlu diganti dengan data yg benar
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        });
  }

  // update fcm_token
  Future<ApiReturnValue?> updateFcmTokenData(
      {required String token, required String fcmToken}) async {
    return await network<ApiReturnValue>(
        bearerToken: token,
        request: (request) =>
            request.put("/fcm-token", data: {'fcm_token': fcmToken}),
        handleSuccess: (Response response) {
          dynamic data = response.data;
          return ApiReturnValue<SektorUnit>.fromJson(data);
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        });
  }

  // update User
  Future<ApiReturnValue?> updateUserData(
      {required String token, required User user}) async {
    print(user.namalengkap);

    return await network<ApiReturnValue>(
        bearerToken: token,
        request: (request) => request.put("/user", data: {
              'nama_lengkap': user.namalengkap,
              'email': user.email,
              'telepon': user.telepon,
            }),
        handleSuccess: (Response response) {
          dynamic data = response.data;
          return ApiReturnValue<User>.fromJson(data,
              value: User.fromJson(data['data']['user']));
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        });
  }

  // pengaturan
  Future<ApiReturnValue?> fetchPengaturanData({required String token}) async {
    return await network<ApiReturnValue>(
        bearerToken: token,
        request: (request) => request.get("/pengaturan"),
        handleSuccess: (Response response) {
          dynamic data = response.data;
          return ApiReturnValue<Pengaturan>.fromJson(data,
              value: Pengaturan.fromJson(
                  data['data'] ?? {'id':0, 'nama_jemaat' : ''})); // perlu diganti dengan data yg benar
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        });
  }

  // post notifikasi
  Future<ApiReturnValue?> posNotifikasi(
      {required String token, required Notifikasi notifikasi}) async {
    return await network<ApiReturnValue>(
        bearerToken: token,
        request: (request) =>
            request.post("/notifikasi", data: notifikasi.toJson()),
        handleSuccess: (Response response) {
          dynamic data = response.data;
          return ApiReturnValue<Notifikasi>.fromJson(data,
              value: Notifikasi.fromJson(
                  data['data'])); // perlu diganti dengan data yg benar
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        });
  }

  // get notifikasi
  Future<ApiReturnValue?> fetchNotifikasiData(
      {required String token, required int idUnit}) async {
    return await network<ApiReturnValue>(
        bearerToken: token,
        request: (request) => request.get("/notifikasi/$idUnit"),
        handleSuccess: (Response response) {
          dynamic data = response.data;
          List<Notifikasi> value = [];
          for (var item in data['data']) {
            value.add(Notifikasi.fromJson(item));
          }
          return ApiReturnValue<List<Notifikasi>>.fromJson(data, value: value);
        },
        handleFailure: (DioException e) {
          dynamic data = e.response!.data;
          return ApiReturnValue.fromJson(data);
        });
  }
}
