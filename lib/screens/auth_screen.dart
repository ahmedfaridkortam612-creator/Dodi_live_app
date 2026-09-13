import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  
  String? _selectedAuthType; // بيحدد إحنا في القائمة الرئيسية ولا جوه إدخال الإيميل/الهاتف
  bool _isLogin = true;

  Future<void> _submitAuthForm() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      if (_selectedAuthType == "email") {
        if (_isLogin) {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
        } else {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. خلفية داكنة وفخمة مؤقتاً لحد ما نربط الصورة
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF1A0033), Color(0xFF000000)],
                ),
              ),
            ),
          ),
          
          // 2. المحتوى والأزرار
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // اسم التطبيق في الأعلى
                  const Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Dodi live',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE8C39E),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'مكانك للتألق والتميز',
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ],
                  ),

                  // الأزرار أو خانات الإدخال
                  Column(
                    children: [
                      if (_selectedAuthType == null) ...[
                        // زر الإيميل
                        _buildButton(
                          icon: Icons.email_outlined,
                          text: 'Email login',
                          onTap: () {
                            setState(() {
                              _selectedAuthType = "email";
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        // زر الهاتف
                        _buildButton(
                          icon: Icons.phone_android_outlined,
                          text: 'Phone login',
                          onTap: () {
                            setState(() {
                              _selectedAuthType = "phone";
                            });
                          },
                        ),
                      ] else ...[
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Column(
                            children: [
                              Text(
                                _selectedAuthType == "email" ? 'تسجيل الدخول بالبريد' : 'تسجيل الدخول برقم الهاتف',
                                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              if (_selectedAuthType == "email") ...[
                                TextField(
                                  controller: _emailController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: _inputDecoration('البريد الإلكتروني', Icons.email),
                                ),
                                const SizedBox(height: 15),
                                TextField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: _inputDecoration('كلمة المرور', Icons.lock),
                                ),
                              ] else ...[
                                TextField(
                                  controller: _phoneController,
                                  keyboardType: TextInputType.phone,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: _inputDecoration('رقم الهاتف (مثال: +20...)', Icons.phone),
                                ),
                              ],
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _submitAuthForm,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8B5CF6),
                                  minimumSize: const Size(double.infinity, 48),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: Text(
                                  _isLogin ? 'تسجيل الدخول' : 'إنشاء حساب جديد',
                                  style: const TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedAuthType = null;
                                  });
                                },
                                child: const Text(
                                  'الرجوع للخلف',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),

                  // شروط الاستخدام في الأسفل
                  const Text(
                    'Agree our to\nPrivacy Policy and Terms of Service',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.white54),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({required IconData icon, required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black87),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white30),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF8B5CF6), width: 2),
      ),
    );
  }
}
