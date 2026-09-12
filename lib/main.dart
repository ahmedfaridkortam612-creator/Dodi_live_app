import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // تأكد إن ملف الـ splash موجود جوه مجلد screens

void main() {
  runApp(const DodiLiveApp());
}

class DodiLiveApp extends StatelessWidget {
  const DodiLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dodi Live',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color(0xFF000000),
      ),
      home: const SplashScreen(), // أول شاشة بتظهر للمستخدم عند فتح التطبيق
    );
  }
}
