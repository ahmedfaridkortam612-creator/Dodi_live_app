import 'package:flutter/material.dart';

void main() {
  runApp(const LiveAppStep1());
}

class LiveAppStep1 extends StatelessWidget {
  const LiveAppStep1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live App Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0817),
        primaryColor: const Color(0xFF8A2BE2),
        fontFamily: 'Cairo',
      ),
      home: const RegistrationScreen(),
    );
  }
}

// نموذج لحفظ بيانات المستخدم الحقيقية
class UserProfileModel {
  final String name;
  final String age;
  final String country;
  final String email;

  UserProfileModel({
    required this.name,
    required this.age,
    required this.country,
    required this.email,
  });
}

// 1. شاشة التسجيل الحقيقية للمستخدم الجديد
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _countryController = TextEditingController();
  final _emailController = TextEditingController();

  void _submitData() {
    if (_nameController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _countryController.text.isEmpty ||
        _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء تعبئة جميع الحقول بشكل صحيح')),
      );
      return;
    }

    // حفظ البيانات المدخلة في الموديل
    UserProfileModel user = UserProfileModel(
      name: _nameController.text.trim(),
      age: _ageController.text.trim(),
      country: _countryController.text.trim(),
      email: _emailController.text.trim(),
    );

    // الانتقال للشاشة الرئيسية مع تمرير بيانات المستخدم الحقيقية
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل مستخدم جديد'),
        backgroundColor: const Color(0xFF1B0F2E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              'أدخل بياناتك الشخصية للبدء:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'الاسم بالكامل', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'العمر', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _countryController,
              decoration: const InputDecoration(labelText: 'الدولة', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'البريد الإلكتروني', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8A2BE2),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _submitData,
              child: const Text('حفظ والدخول للتطبيق', style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. الشاشة الرئيسية التي تستقبل بيانات المستخدم وتعرضها
class HomeScreen extends StatelessWidget {
  final UserProfileModel user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مرحباً بك، ${user.name}'),
        backgroundColor: const Color(0xFF1B0F2E),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.purple,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text('الاسم: ${user.name}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text('العمر: ${user.age} سنة', style: const TextStyle(fontSize: 16, color: Colors.white70)),
              const SizedBox(height: 10),
              Text('الدولة: ${user.country}', style: const TextStyle(fontSize: 16, color: Colors.white70)),
              const SizedBox(height: 10),
              Text('الإيميل: ${user.email}', style: const TextStyle(fontSize: 14, color: Colors.white54)),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: () {
                  // العودة لشاشة التسجيل لتسجيل حساب جديد
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                  );
                },
                child: const Text('تسجيل الخروج'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
