import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase init error: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dodi Live',
      debugShowCheckedModeBanner: false,
      home: const AuthScreen(),
    );
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // عرض الصورة الخلفية لتملأ الشاشة بالكامل بدون فراغات
          Positioned.fill(
            child: Image.asset(
              'assets/splash_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // طبقة شفافة خفيفة جداً لتحسين وضوح الأزرار فوق الصورة
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),

          // الأزرار والنصوص في الأسفل فوق الصورة
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Start / Login',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Agree our to\nPrivacy Policy and Terms of Service',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodi Live Home'),
      ),
      body: const Center(
        child: Text(
          'أهلاً بك في تطبيق دودي لايف!',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
