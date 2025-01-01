import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/data/models/todo_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todo_app/main.dart';

class NotificationService {




  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<bool> requestAlarmPermission() async {
    // Check if permission is granted
    final status = await Permission.notification.request();
    if (!status.isGranted) {
      // Handle permission denial
      print("Permission denied. Unable to set alarms.");
      return false;
    }
    return true;
  }

  Future<void> scheduleTodoNotification(TodoModel todo) async {
    // Ensure permission for Android 14+ (alarm permission)
    if (await Permission.notification.isGranted) {
      if (todo.reminder == null) return;

      const androidDetails = AndroidNotificationDetails(
        'todo_channel',
        'Todo Notifications',
        channelDescription: 'Notifications for todo tasks',
        importance: Importance.max,
        priority: Priority.high,
      );

      const iosDetails = DarwinNotificationDetails();
      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await flutterLocalNotificationsPlugin.zonedSchedule(
        todo.hashCode,
        'Todo Reminder',
        todo.title,
        tz.TZDateTime.from(todo.reminder!, tz.local),
        details,
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } else {
      final isGranted = await requestAlarmPermission();
      if (isGranted) scheduleTodoNotification(todo);
    }
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
