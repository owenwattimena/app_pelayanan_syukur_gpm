import 'package:get/get.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../models/user.dart';

class AkunController extends GetxController {
  Rx<User?> user = Rx<User?>(User());
  Future<void> getUser() async{
    user.value =  await Auth.user<User>();
  }
} 
