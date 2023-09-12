import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import '/bootstrap/app.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'app/services/local_notification.dart';
import 'bootstrap/boot.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotification().initNotification();
  await GetStorage.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Nylo nylo = await Nylo.init(setup: Boot.nylo, setupFinished: Boot.finished);
  tz.initializeTimeZones();
  runApp(
    AppBuild(
      navigatorKey: NyNavigator.instance.router.navigatorKey,
      onGenerateRoute: nylo.router!.generator(),
      debugShowCheckedModeBanner: false,
      initialRoute: nylo.getInitialRoute(),
    ),
  );
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print('Got a message whilst in the background!');
  print("Message data: ${message.data}");

  if (message.notification != null) {
  //   LocalNotification().scheduleNotification(
  //     dateTime: DateTime.parse(message.data['tanggal']),
  //     flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
  //     scheduledNotificationDateTime: DateTime.parse(message.data['tanggal']),
  //     title: message.notification!.title,
  //     body: message.notification!.body,
  //   );
    print(
        'Message also contained a notification: ${message.notification!.body}');
  }
}
