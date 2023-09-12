import 'package:nylo_framework/nylo_framework.dart';

import '../models/push_notification.dart';
import 'package:firebase_core/firebase_core.dart';

import '../networking/api_service.dart';
import '../respositories/auth_repository.dart';
import 'controller.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationController extends Controller {
  ApiService _apiService = ApiService();
  AuthRepository _authRepo = new AuthRepository();
  late FirebaseMessaging _messaging;

  construct(BuildContext context) {
    super.construct(context);
  }

  Future<void> initNotifications() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    await _messaging.requestPermission();
    final fcmToken = await _messaging.getToken();
    updateFcmToken(fcmToken);
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> updateFcmToken(String? fcmToken) async
  {
    final result = await _apiService.updateFcmTokenData(fcmToken: "$fcmToken", token: _authRepo.token);
    if(result!.code == 401)
    {
      Auth.remove();
      Auth.logout();
    }
    print(result.message);
  
  }

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    PushNotification notification = PushNotification(
      title: message.notification?.title,
      body: message.notification?.body,
    );
    print("Title : ${notification.title}");
    print("Body : ${notification.body}");
    print("Handling a background message: ${message.messageId}");
  }
}
