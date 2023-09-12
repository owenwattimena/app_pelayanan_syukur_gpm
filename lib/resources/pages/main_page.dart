import 'dart:async';

import 'package:com.wentox.pelayanansyukurgpm/app/controllers/push_notification_controller.dart';
import 'package:com.wentox.pelayanansyukurgpm/app/services/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_listener_service/notification_event.dart';
import 'package:nylo_framework/nylo_framework.dart';
// import '../../app/services/local_notification.dart';
import '../../app/models/notifikasi.dart';
import '../../app/models/user.dart';
import '../../app/networking/api_service.dart';
import '../../app/respositories/auth_repository.dart';
import 'home_page.dart';
import 'pernikahan_page.dart';
import 'akun_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notification_listener_service/notification_listener_service.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MainPage extends NyStatefulWidget {
  final PushNotificationController controller = PushNotificationController();

  static const path = '/main';

  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends NyState<MainPage> {
  StreamSubscription<ServiceNotificationEvent>? _subscription;
  ApiService _apiService = ApiService();
  AuthRepository _authRepo = new AuthRepository();

  List<ServiceNotificationEvent> events = [];
  int _currentIndex = 0;
  User? _user;

  final List<Widget> _screens = [
    HomePage(),
    PernikahanPage(),
    AkunPage(),
  ];

  @override
  init() async {
    super.init();

    /// check if notification permession is enebaled
    final bool status = await NotificationListenerService.isPermissionGranted();
    _user = await Auth.user<User>();

    /// request notification permission
    /// it will open the notifications settings page and return `true` once the permission granted.
    if (!status) {
      await NotificationListenerService.requestPermission();
    }

    NotificationListenerService.notificationsStream.listen((event) async {
      if (event.packageName == 'com.wentox.pelayanansyukurgpm') {
        // if (_user != null) {
        await _apiService.postNotifikasi(
            token: _authRepo.token,
            notifikasi: Notifikasi(
                judul: event.title, isi: event.content, idUnit: _user?.idUnit));
        print("Current notification: $event");
        // }
      }
    });

    /// stream the incoming notification events

    widget.controller.initNotifications();
    // LocalNotification().scheduleNotification(title: 'title', body: 'body', dateTime: DateTime.now().subtract(Duration(minutes: 1)), flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin, scheduledNotificationDateTime: DateTime.now().subtract(Duration(minutes: 2)));

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print("Message data: ${message.data}");

      if (message.notification != null) {
        LocalNotification().showNotification(
            title: '${message.notification!.title}',
            body: '${message.notification!.body}');

        // LocalNotification().scheduleNotification(
        //   id: 1,
        //   dateTime: DateTime.parse(message.data['tanggal']),
        //   flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin,
        //   scheduledNotificationDateTime:
        //       DateTime.parse(message.data['tanggal']),
        //   title: message.notification!.title,
        //   body: message.notification!.body,
        // );
        print(
            'Message also contained a notification: ${message.notification!.body}');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.info), label: 'Notifikasi'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
