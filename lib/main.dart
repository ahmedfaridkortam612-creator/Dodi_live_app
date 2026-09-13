import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_screen.dart';
import 'home_screen.dart'; // تأكد إن اسم الملف عندك مظبوط

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dodi Live',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      // بنخلي التطبيق يراقب حالة المستخدم تلقائياً
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // لو جاري التحميل
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          // لو المستخدم مسجل دخول بالفعل، يروح على الرئيسية
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          // لو لأ، يروح على شاشة تسجيل الدخول
          return const AuthScreen();
        },
      ),
    );
  }
}
