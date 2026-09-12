import 'package:flutter/material.dart';
import 'complete_profile_screen.dart'; // الشاشة التالية لاستكمال البيانات

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // خلفية سوداء احتياطية في حال تحميل الصورة
          Container(color: const Color(0xFF0A0314)),
          
          // محاكاة أو وضع خلفية الصورة الفخمة (يمكن استخدام NetworkImage أو AssetImage حسب رفعك للصورة في الأصول)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF2D124D),
                    Color(0xFF0F051D),
                    Color(0xFF000000),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.stars_rounded, size: 80, color: Colors.amberAccent),
                    const SizedBox(height: 10),
                    const Text(
                      'Dodi live',
                      style: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'مكانك للتألق والتميز ✨',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // أزرار تسجيل الدخول السفلية (الموبايل، الإيميل، فيسبوك)
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Column(
              children: [
                // زر تسجيل الدخول برقم الموبايل
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ).wrap(
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      ),
                      onPressed: () => _goToCompleteProfile(context),
                      child: const Text('تسجيل برقم الموبايل 📱', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // زر تسجيل الدخول بالبريد الإلكتروني
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.amberAccent),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    onPressed: () => _goToCompleteProfile(context),
                    child: const Text('تسجيل بالبريد الإلكتروني ✉️', style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 14)),
                  ),
                ),
                const SizedBox(height: 12),

                // زر تسجيل الدخول بـ Facebook
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1877F2),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                    onPressed: () => _goToCompleteProfile(context),
                    child: const Text('المتابعة بواسطة فيسبوك 🌐', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  ),
                ),
                const SizedBox(height: 20),

                // شروط الاستخدام وسياسة الخصوصية الموجودة في أسفل صورتك
                const Text(
                  'Agree our to Privacy Policy and Terms of Service',
                  style: TextStyle(color: Colors.white38, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _goToCompleteProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CompleteProfileScreen()),
    );
  }
}
