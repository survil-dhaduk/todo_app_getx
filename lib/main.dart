import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/core/constants/app_strings.dart';
import 'package:todo_app/core/utils/notification_service.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/presentation/bindings/todo_binding.dart';
import 'package:todo_app/presentation/pages/home/home_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  final detroit = tz.getLocation('Asia/Kolkata');
  tz.setLocalLocation(detroit);

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>('todos');

  await NotificationService().requestAlarmPermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: TodoBinding(),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
