import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  static final _localNotification = FlutterLocalNotificationsPlugin();
  static Future init(
      FlutterLocalNotificationsPlugin localNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
    await localNotificationsPlugin.initialize(initializationSettings);
  }

  static _notificationConfig() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
            'pet_food_chanel_id', 'Application Chanel Id',
            importance: Importance.max,
            playSound: true,
            priority: Priority.max),
        iOS: DarwinNotificationDetails());
  }

  static showNotification(String message) async {
    await _localNotification.show(
      0,
      'Pet Food',
      message,
      await _notificationConfig(),
      payload: DateTime.now().toString(),
    );
  }
}
