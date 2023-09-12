import 'package:get_storage/get_storage.dart';

class AuthRepository {
  GetStorage store = new GetStorage();

  set saveLoginStatus(bool status) {
    store.write('isLogin', status);
  }
  bool get getLoginStatus {
    return store.read('isLogin');
  }

  set saveToken(String token) {
    store.write('token', token);
  }

  String get token {
    return store.read('token');
  }

  set saveUserData(Map<String, dynamic> user) {
    store.write('user', user);
  }

  Map<String, dynamic> get userData {
    return store.read('user');
  }

  // Method to clear user data and token (logout).
  void clearData() {
    store.remove('token');
    store.remove('user');
  }
}
