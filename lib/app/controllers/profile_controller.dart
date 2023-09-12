import 'package:com.wentox.pelayanansyukurgpm/app/networking/api_service.dart';
import 'package:get/get.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../models/user.dart';
import '../respositories/auth_repository.dart';

class ProfileController extends GetxController {
  ApiService _apiService = ApiService();
  AuthRepository _authRepo = new AuthRepository();

  Rx<User?> user = Rx<User?>(User());

  Future<void> getUser() async{
    user.value =  await Auth.user<User>();
  }

  Future<User?> updateProfile(User user) async
  {
    final result = await _apiService.updateUserData(token: _authRepo.token, user: user);

    if(result != null)
    {
      if(result.status)
      {
        User user = result.value as User;
        _authRepo.saveUserData = user.toJson();
        return user;
      }
    }
    return null;
  }
} 
