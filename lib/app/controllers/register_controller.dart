import 'package:flutter/material.dart';

import '../models/api_return_value.dart';
import '../models/sektor.dart';
import '../models/unit.dart';
import '../models/user.dart';
import '../networking/api_service.dart';
import 'controller.dart';
import 'package:flutter/widgets.dart';

class RegisterController extends Controller {
  ApiService _apiService = ApiService();

  construct(BuildContext context) {
    super.construct(context);
  }

  Future<List<Sektor>?> getSektor() async {
    try {
      return await _apiService.fetchSektorData(); 
    } catch (e) {
      print("Catch : $e");
      return [];
    }
  }
  
  Future<List<Unit>?> getUnit(int idSektor) async {
    try {
      return await _apiService.fetchUnitData(idSektor); 
    } catch (e) {
      print("Catch : $e");
      return [];
    }
  }

  Future<ApiReturnValue?> register(User user) async
  {
    return await _apiService.register(user: user);
  }
}
