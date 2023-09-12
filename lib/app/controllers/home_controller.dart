import 'package:get/get.dart';
import 'package:nylo_framework/nylo_framework.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../models/kelahiran.dart';
import '../models/pengaturan.dart';
import '../models/pernikahan.dart';
import '../models/sektor_unit.dart';
import '../models/user.dart';
import '../networking/api_service.dart';
import '../respositories/auth_repository.dart';

class HomeController extends GetxController {
  ApiService _apiService = ApiService();
  AuthRepository _authRepo = new AuthRepository();

  Rx<User?> user = Rx<User>(User());
  Rx<SektorUnit?> sektorUnit = Rx<SektorUnit>(SektorUnit());
  Rx<Pengaturan?> pengaturan = Rx<Pengaturan>(Pengaturan());
  Rx<List<Pernikahan>?> pernikahanList = Rx<List<Pernikahan>?>([]);
  Rx<List<Kelahiran>?> kelahiranList = Rx<List<Kelahiran>?>([]);
  void getUser() async {
    user.value = await Auth.user<User>();
  }

  Future<void> getPengaturan() async {
    if (user.value != null) {
      if (user.value != null) {
        final result = await _apiService.fetchPengaturanData(
            token: _authRepo.token);

        if (result != null) {
          if (result.status) {
            pengaturan.value = result.value as Pengaturan;
          }
        }
      }
    }
  }
  Future<void> getSektorUnit() async {
    if (user.value != null) {
      if (user.value != null) {
        final result = await _apiService.fetchSektorUnitData(
            token: _authRepo.token, idUnit: user.value!.idUnit!);

        if (result != null) {
          if (result.status) {
            sektorUnit.value = result.value as SektorUnit;
          }
        }
      }
    }
  }

  Future<void> getPernikahan() async {
    if (user.value != null) {
      if (user.value != null) {
        final result = await _apiService.fetchPelayananPernikahanData(
            token: _authRepo.token, limit: 3);

        if (result != null) {
          if (result.status) {
            pernikahanList.update((val) {
              pernikahanList.value = (result.value as List<Pernikahan>);
            });
          }
        }
      }
    }
  }

  Future<void> getKelahiran() async {
    if (user.value != null) {
      if (user.value != null) {
        final result = await _apiService.fetchPelayananKelahiranData(
            token: _authRepo.token, limit: 3);

        if (result != null) {
          if (result.status) {
            kelahiranList.update((val) {
              kelahiranList.value = (result.value as List<Kelahiran>);
            });
          }
        }
      }
    }
  }
}
