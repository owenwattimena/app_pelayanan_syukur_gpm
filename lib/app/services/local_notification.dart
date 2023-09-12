import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz1;

class LocalNotification {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
        });

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
      print('local noti');
    });
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduledNotificationDateTime,
      required DateTime dateTime,
      required FlutterLocalNotificationsPlugin
          flutterLocalNotificationsPlugin}) async {
    tz1.initializeTimeZones();
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduleddate = tz.TZDateTime(
            tz.local, now.year, now.month, now.day, now.hour, now.minute)
        .add(Duration(minutes: 1));

    return await notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        // tz.TZDateTime.from(
        //   scheduledNotificationDateTime,
        //   tz.getLocation('Asia/Jayapura'),
        // ),
        scheduleddate,
        await notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static void initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {}
}


// class LocalNotification {
//   static Future initialize(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidInitialize =
//         const AndroidInitializationSettings('mipmap/ic_launcher');
//     DarwinInitializationSettings darwinInitializationSettings =
//         const DarwinInitializationSettings();
//     var initislizationsSettings = InitializationSettings(
//         android: androidInitialize, iOS: darwinInitializationSettings);
//     await flutterLocalNotificationsPlugin.initialize(initislizationsSettings);
//   }

//   static Future show(
//       {var id = 0,
//       required String title,
//       required String body,
//       required DateTime dateTime,
//       required FlutterLocalNotificationsPlugin
//           flutterLocalNotificationsPlugin}) async {
//     AndroidNotificationDetails androidNotificationDetails =
//         const AndroidNotificationDetails('channelId', 'channelName',
//             playSound: true,
//             importance: Importance.max,
//             priority: Priority.high);

//     const DarwinNotificationDetails darwinNotificationDetails =
//         DarwinNotificationDetails(presentSound: false);

//     var notificationDetails = NotificationDetails(
//         android: androidNotificationDetails, iOS: darwinNotificationDetails);

//     // tz.TZDateTime scheduledDate = tz.TZDateTime.from(dateTime, tz.local);
//     // tz.TZDateTime scheduledDate = tz.TZDateTime.local(dateTime.year, dateTime.month, dateTime.day, dateTime.minute);
//     // await flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails);

//     // final scheduledDate = tz.TZDateTime.from(dateTime, tz.local);
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.from(dateTime, tz.local),
//       notificationDetails,
//       uiLocalNotificationDateInterpretation:
//           UILocalNotificationDateInterpretation.absoluteTime,
//     );
//     print('Schedule notif');
//   }
// }
