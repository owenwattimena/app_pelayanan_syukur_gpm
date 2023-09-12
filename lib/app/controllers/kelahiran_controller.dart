import 'package:get/get.dart';

import '../models/kelahiran.dart';
import '../networking/api_service.dart';
import '../respositories/auth_repository.dart';

class KelahiranController extends GetxController {
  ApiService _apiService = ApiService();
  AuthRepository _authRepo = new AuthRepository();
  Rx<List<Kelahiran>?> kelahiranList = Rx<List<Kelahiran>?>([]);

  Future<void> getKelahiran() async {
    final result = await _apiService.fetchPelayananKelahiranData(token: _authRepo.token);

    if (result != null) {
      if (result.status) {
        kelahiranList.update((val) {
          kelahiranList.value = (result.value as List<Kelahiran>);
        });
      }
    }
  }
}
