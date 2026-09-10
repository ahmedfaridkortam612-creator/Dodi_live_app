import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const LiveAppStep4());
}

class LiveAppStep4 extends StatelessWidget {
  const LiveAppStep4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dodi Live',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0817),
        primaryColor: const Color(0xFF8A2BE2),
        fontFamily: 'Cairo',
      ),
      home: const SplashScreen(),
    );
  }
}

// 1. شاشة الترحيب (Splash Screen) باسم Dodi Live
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // الانتظار لمدة 3 ثوانٍ ثم الانتقال تلقائياً لشاشة التسجيل
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF240D42), Color(0xFF0F0817)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // أيقونة ترحيبية أو شعار التطبيق
              CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFF8A2BE2),
                child: Icon(Icons.live_tv, size: 50, color: Colors.white),
              ),
              SizedBox(height: 20),
              // اسم التطبيق الاحترافي
              Text(
                'Dodi Live',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'عالمك المفضل للبث المباشر والدردشة',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              SizedBox(height: 30),
              CircularProgressIndicator(
                color: Colors.amber,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// نموذج بيانات المستخدم
class UserProfileModel {
  final String name;
  final String birthDate;
  final String country;
  final String gender;
  final String email;

  UserProfileModel({
    required this.name,
    required this.birthDate,
    required this.country,
    required this.gender,
    required this.email,
  });
}

// 2. شاشة التسجيل
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  final List<Map<String, String>> _countries = [
    {'name': 'Algeria', 'flag': '🇩🇿'},
    {'name': 'Bahrain', 'flag': '🇧🇭'},
    {'name': 'Canada', 'flag': '🇨🇦'},
    {'name': 'Egypt', 'flag': '🇪🇬'},
    {'name': 'France', 'flag': '🇫🇷'},
    {'name': 'Germany', 'flag': '🇩🇪'},
    {'name': 'Iraq', 'flag': '🇮🇶'},
    {'name': 'Jordan', 'flag': '🇯🇴'},
    {'name': 'Kuwait', 'flag': '🇰🇼'},
    {'name': 'Lebanon', 'flag': '🇱🇧'},
    {'name': 'Morocco', 'flag': '🇲🇦'},
    {'name': 'Oman', 'flag': '🇴🇲'},
    {'name': 'Palestine', 'flag': '🇵🇸'},
    {'name': 'Qatar', 'flag': '🇶🇦'},
    {'name': 'Saudi Arabia', 'flag': '🇸🇦'},
    {'name': 'Sudan', 'flag': '🇸🇩'},
    {'name': 'Syria', 'flag': '🇸🇾'},
    {'name': 'Tunisia', 'flag': '🇹🇳'},
    {'name': 'United Arab Emirates', 'flag': '🇦🇪'},
    {'name': 'United States', 'flag': '🇺🇸'},
    {'name': 'Yemen', 'flag': '🇾🇪'},
  ];

  String? _selectedCountry;
  DateTime? _selectedDate;
  String _selectedGender = 'ذكر';

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      locale: const Locale('ar'),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitData() {
    if (_nameController.text.isEmpty ||
        _selectedCountry == null ||
        _selectedDate == null ||
        _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء تعبئة جميع الحقول واختيار الدولة وتاريخ الميلاد')),
      );
      return;
    }

    String formattedDate = "${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}";

    UserProfileModel user = UserProfileModel(
      name: _nameController.text.trim(),
      birthDate: formattedDate,
      country: _selectedCountry!,
      gender: _selectedGender,
      email: _emailController.text.trim(),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainDashboard(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل حساب جديد - Dodi Live'),
        backgroundColor: const Color(0xFF1B0F2E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              'أدخل بياناتك الشخصية:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'الاسم بالكامل', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            InkWell(
              onTap: () => _pickDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(labelText: 'تاريخ الميلاد', border: OutlineInputBorder()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'اختر تاريخ الميلاد (السنة / الشهر / اليوم)'
                          : '${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}',
                      style: TextStyle(color: _selectedDate == null ? Colors.white54 : Colors.white),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.purpleAccent),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              dropdownColor: const Color(0xFF1B0F2E),
              decoration: const InputDecoration(labelText: 'اختر الدولة', border: OutlineInputBorder()),
              value: _selectedCountry,
              items: _countries.map((country) {
                return DropdownMenuItem<String>(
                  value: country['name'],
                  child: Text('${country['flag']}  ${country['name']}'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                });
              },
            ),
            const SizedBox(height: 15),
            const Text('الجنس:', style: TextStyle(color: Colors.white70, fontSize: 14)),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('ذكر 👨'),
                    value: 'ذكر',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('أنثى 👩'),
                    value: 'أنثى',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
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

// لوحة التحكم الرئيسية والرومات الحية
class MainDashboard extends StatefulWidget {
  final UserProfileModel user;
  const MainDashboard({Key? key, required this.user}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      LiveStreamsFeedScreen(user: widget.user),
      ProfileScreen(user: widget.user),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF140B22),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white54,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'الرومات الحية'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

class LiveStreamsFeedScreen extends StatelessWidget {
  final UserProfileModel user;
  const LiveStreamsFeedScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مرحباً في Dodi Live، ${user.name} 👋'),
        backgroundColor: const Color(0xFF1B0F2E),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActiveLiveRoom(user: user)),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(colors: [Color(0xFF3B185F), Color(0xFF1F0D35)]),
                border: Border.all(color: Colors.purpleAccent.withOpacity(0.4)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("غرفة بث مباشر 🔥", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                    SizedBox(height: 4),
                    Text("مضيف مميز • 1.2k مشاهد", style: TextStyle(color: Colors.white70, fontSize: 10)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ActiveLiveRoom extends StatelessWidget {
  final UserProfileModel user;
  const ActiveLiveRoom({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('غرفة البث التفاعلية'),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF240D42), Color(0xFF0F0817)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'اكتب تعليقاً...',
                            filled: true,
                            fillColor: Colors.black38,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.amber,
                        child: const Icon(Icons.card_giftcard, color: Colors.black),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${user.name} أرسل هدية مميزة في الغرفة! 💎')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final UserProfileModel user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي'), backgroundColor: const Color(0xFF1B0F2E)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundColor: Colors.purple,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 15),
              Text(user.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('تاريخ الميلاد: ${user.birthDate}', style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 5),
              Text('الدولة: ${user.country}', style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 5),
              Text('الجنس: ${user.gender}', style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 5),
              Text(user.email, style: const TextStyle(color: Colors.white54, fontSize: 12)),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: () {
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
