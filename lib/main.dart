import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sqflite TaskManage',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
      ),
      home: TaskPage(),
    );
  }
}
