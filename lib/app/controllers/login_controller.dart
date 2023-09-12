import 'package:get/get.dart';

import '../models/api_return_value.dart';
import '../models/user.dart';
import '../networking/api_service.dart';

import '../respositories/auth_repository.dart';
// import 'controller.dart';
// import 'package:flutter/widgets.dart';

class LoginController extends GetxController {
  // RxBool _isLoggedIn = false.obs;
  ApiService _apiService = ApiService();
  // construct(BuildContext context) {
  //   super.construct(context);
  // }

  Future<ApiReturnValue> doLogin(User user) async {
    AuthRepository _authRepo = new AuthRepository();
    try {
      final result = await _apiService.login(user: user);
      if (result != null) {
        print(result.code);
        if (result.status) {
          final data = result.value as User;
          _authRepo.saveToken = data.token!;
          _authRepo.saveUserData = data.toJson();
          _authRepo.saveLoginStatus = true;
          // login();
        } else {
          _authRepo.clearData();
          // logout();
        }
      } else {
        _authRepo.clearData();
        // logout();
      }
      return result!;
    } catch (e) {
      return ApiReturnValue(status: false, message: e.toString());
    }
  }

  void login() {
    // Perform your login logic here, and set _isLoggedIn to true if successful.
    // _isLoggedIn.value = true;
  }

  void logout() {
    // Perform your logout logic here, and set _isLoggedIn to false.
    // _isLoggedIn.value = false;
  }
}
