import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @interface
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  
  bool _isLogin = true; // عشان نغير بين تسجيل الدخول وإنشاء حساب جديد
  bool _usePhoneAuth = false; // عشان نغير بين الإيميل ورقم الهاتف

  // دالة تسجيل الدخول أو التسجيل باستخدام الإيميل وكلمة المرور
  Future<void> _submitAuthForm() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      if (_isLogin) {
        // تسجيل دخول مستخدم قديم
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        // إنشاء حساب جديد
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      // لو كل حاجة تمام، ممكن تنقل المستخدم لشاشة التطبيق الرئيسية هنا
    } catch (error) {
      // إظهار رسالة خطأ لو فيه مشكلة في الإيميل أو الباسورد
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Dodi Live',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                
                // حقل الإيميل أو الهاتف حسب الاختيار
                if (!_usePhoneAuth) ...[
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'البريد الإلكتروني',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'كلمة المرور',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ] else ...[
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'رقم الهاتف (مثال: +20...)',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
                
                const SizedBox(height: 25),
                
                // زر التنفيذ الأساسي
                ElevatedButton(
                  onPressed: _submitAuthForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    _isLogin ? 'تسجيل الدخول' : 'إنشاء حساب جديد',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                
                const SizedBox(height: 15),
                
                // زر التبديل بين تسجيل الدخول وحساب جديد
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin ? 'ليس لديك حساب؟ انشئ حساب جديد' : 'لديك حساب بالفعل؟ سجل دخولك',
                    style: const TextStyle(color: Colors.purpleAccent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
