import 'package:flutter/material.dart';
import 'auth_screen.dart'; // استيراد صفحة التسجيل والبروفايل
import 'daily_payout_screen.dart';
import 'recharge_modal.dart';
import 'services/wallet_api_service.dart'; // تأكد من مسار الخدمة حسب مجلداتك

void main() {
  runApp(const DodiLiveApp());
}

class DodiLiveApp extends StatelessWidget {
  const DodiLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dodi Live App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
      ),
      // جعل شاشة تسجيل الدخول هي الواجهة الأولى للتطبيق
      home: AuthScreen(
        onLoginSuccess: () {
          // دالة الانتقال للمحفظة بعد النجاح (يمكنك تعديلها لاحقاً)
        },
      ),
    );
  }
}
