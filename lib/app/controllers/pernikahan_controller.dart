import 'package:get/get.dart';

import '../models/pernikahan.dart';
import '../networking/api_service.dart';
import '../respositories/auth_repository.dart';

class PernikahanController extends GetxController {
  ApiService _apiService = ApiService();
  AuthRepository _authRepo = new AuthRepository();
  Rx<List<Pernikahan>?> pernikahanList = Rx<List<Pernikahan>?>([]);

  Future<void> getPernikahan() async {
    final result =
        await _apiService.fetchPelayananPernikahanData(token: _authRepo.token);

    if (result != null) {
      if (result.status) {
        pernikahanList.update((val) {
          pernikahanList.value = (result.value as List<Pernikahan>);
        });
      }
    }
  }
}
