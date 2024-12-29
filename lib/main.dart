import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/constants/app_strings.dart';
import 'package:todo_app/presentation/pages/home/home_page.dart';
import 'package:todo_app/presentation/bindings/todo_binding.dart';

void main() {
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
