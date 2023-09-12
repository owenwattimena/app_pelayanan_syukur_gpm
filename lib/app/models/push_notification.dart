import 'package:nylo_framework/nylo_framework.dart';

/// PushNotification Model.

class PushNotification extends Model {
  final String? title;
  final String? body;
  PushNotification({this.title, this.body});
  
  factory PushNotification.fromJson(data) => PushNotification();

  toJson() {

  }
}
