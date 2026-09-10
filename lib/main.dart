import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const LiveAppStep6());
}

class LiveAppStep6 extends StatelessWidget {
  const LiveAppStep6({Key? key}) : super(key: key);

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

// 1. شاشة الترحيب
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
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
              CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFF8A2BE2),
                child: Icon(Icons.live_tv, size: 50, color: Colors.white),
              ),
              SizedBox(height: 20),
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

// نموذج بيانات المستخدم مع الكوينز والماس
class UserProfileModel {
  final String name;
  final String birthDate;
  final String country;
  final String gender;
  final String email;
  int diamonds; // الماس (للكسب أو الاستبدال)
  int coins;    // الكوينزات (للعب وإرسال الهدايا)

  UserProfileModel({
    required this.name,
    required this.birthDate,
    required this.country,
    required this.gender,
    required this.email,
    this.diamonds = 500,  // رصيد ماس افتراضي
    this.coins = 200,     // رصيد كوينز افتراضي للعب
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

// 3. لوحة التحكم الرئيسية
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
      WalletScreen(user: widget.user),
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
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

// شاشة الرومات الحية
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

// 4. غرفة البث مع صندوق الهدايا المتكامل
class ActiveLiveRoom extends StatefulWidget {
  final UserProfileModel user;
  const ActiveLiveRoom({Key? key, required this.user}) : super(key: key);

  @override
  State<ActiveLiveRoom> createState() => _ActiveLiveRoomState();
}

class _ActiveLiveRoomState extends State<ActiveLiveRoom> {
  // دالة إظهار صندوق الهدايا التفاعلي
  void _openGiftBox() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1B0F2E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(20),
              height: 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.between,
                    children: [
                      const Text('🎁 صندوق هدايا Dodi Live', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
                      Text('رصيدك: ${widget.user.coins} كوينز 🪙', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        _buildGiftItem('وردة 🌹', 10, setModalState),
                        _buildGiftItem('قلب ❤️', 50, setModalState),
                        _buildGiftItem('سيارة 🚗', 200, setModalState),
                        _buildGiftItem('قصر 🏰', 500, setModalState),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildGiftItem(String giftName, int cost, StateSetter setModalState) {
    return GestureDetector(
      onTap: () {
        if (widget.user.coins >= cost) {
          setState(() {
            widget.user.coins -= cost;
          });
          setModalState(() {});
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم إرسال ($giftName) بنجاح! تم خصم $cost كوينز 🪙')),
          );
        } else {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('رصيد الكوينزات لا يكفي، قم بفك الماسات أو شحن رصيدك!')),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2C164D),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.amber.withOpacity(0.5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.card_giftcard, size: 35, color: Colors.amber),
            const SizedBox(height: 5),
            Text(giftName, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            Text('$cost كوينز', style: const TextStyle(color: Colors.white70, fontSize: 10)),
          ],
        ),
      ),
    );
  }

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
                      // زر فتح صندوق الهدايا داخل اللايف
                      FloatingActionButton(
                        heroTag: "giftBtn",
                        mini: true,
                        backgroundColor: Colors.amber,
                        child: const Icon(Icons.card_giftcard, color: Colors.black),
                        onPressed: _openGiftBox,
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

// 5. شاشة المحفظة واستبدال الماسات إلى كوينزات
class WalletScreen extends StatefulWidget {
  final UserProfileModel user;
  const WalletScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  // دالة تحويل الماس إلى كوينز (كل 1 ماسة = 2 كوينز مثلاً)
  void _exchangeDiamondsToCoins(int diamondsToExchange) {
    if (widget.user.diamonds >= diamondsToExchange) {
      setState(() {
        widget.user.diamonds -= diamondsToExchange;
        widget.user.coins += (diamondsToExchange * 2);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('تم تحويل $diamondsToExchange ماسة إلى ${diamondsToExchange * 2} كوينز بنجاح! 🪙')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ليس لديك رصيد كافٍ من الماسات للتحويل!')),
      );
    }
  }

  void _rechargeDiamonds(int amount) {
    setState(() {
      widget.user.diamonds += amount;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم شحن $amount ماسة بنجاح! 💎')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محفظة Dodi Live'),
        backgroundColor: const Color(0xFF1B0F2E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            // بطاقة الأرصدة (الكوينز والماس)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF8A2BE2), Color(0xFF4A0E4E)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text('رصيد الكوينز 🪙', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      const SizedBox(height: 5),
                      Text('${widget.user.coins}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber)),
                    ],
                  ),
                  Container(height: 40, width: 1, color: Colors.white24),
                  Column(
                    children: [
                      const Text('رصيد الماس 💎', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      const SizedBox(height: 5),
                      Text('${widget.user.diamonds}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // قسم فك الماسات إلى كوينزات
            const Text('فك الماسات إلى كوينزات للعب والهدايا:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.amber)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  onPressed: () => _exchangeDiamondsToCoins(50),
                  child: const Text('فك 50 ماسة ➔ 100 كوينز'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                  onPressed: () => _exchangeDiamondsToCoins(200),
                  child: const Text('فك 200 ماسة ➔ 400 كوينز'),
                ),
              ],
            ),
            const SizedBox(height: 25),

            const Text('شحن الماسات الفوري:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.amber)),
            const SizedBox(height: 10),
            _buildRechargeCard(500, '5.00 \$', Colors.purple),
            _buildRechargeCard(1200, '10.00 \$', Colors.deepPurple),
            _buildRechargeCard(3000, '25.00 \$', Colors.blueAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildRechargeCard(int diamonds, String price, Color color) {
    return Card(
      color: const Color(0xFF1B0F2E),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.cyanAccent,
          child: Icon(Icons.diamond, color: Colors.black),
        ),
        title: Text('$diamonds ماسة 💎', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        subtitle: const Text('شحن فوري لحسابك', style: TextStyle(color: Colors.white54, fontSize: 12)),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: color),
          onPressed: () => _rechargeDiamonds(diamonds),
          child: Text(price, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

// 6. شاشة الملف الشخصي تعرض رصيد الكوينزات بوضوح
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
              const SizedBox(height: 12),
              // رصيد الكوينزات والماس ظاهر بوضوح في الصفحة الشخصية
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B0F2E),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.amber.withOpacity(0.5)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('الكوينز: ${user.coins} 🪙', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(width: 20),
                    Text('الماس: ${user.diamonds} 💎', style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                ),
              ),
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
