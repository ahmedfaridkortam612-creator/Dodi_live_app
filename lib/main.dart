import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/auth_screen.dart';

void main() async {
  // خطوة إجبارية عشان فلاتر يجهز نفسه قبل تشغيل السيرفر
  WidgetsFlutterBinding.ensureInitialized();
  
  // تشغيل وتهيئة اتصال السيرفر بـ Firebase
  await Firebase.initializeApp();
  
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
        scaffoldBackgroundColor: const Color(0xFF0B0716),
      ),
      home: const AuthScreen(),
    );
  }
}
