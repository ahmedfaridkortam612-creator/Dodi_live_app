import 'package:flutter/material.dart';

void main() {
  runApp(const MicoBigoLiveApp());
}

class MicoBigoLiveApp extends StatelessWidget {
  const MicoBigoLiveApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Stream Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0817),
        primaryColor: const Color(0xFF8A2BE2),
        fontFamily: 'Cairo',
      ),
      home: const UserRegistrationScreen(),
    );
  }
}

// نموذج بيانات المستخدم الحقيقي
class UserProfileData {
  final String name;
  final String age;
  final String country;
  final String email;

  UserProfileData({
    required this.name,
    required this.age,
    required this.country,
    required this.email,
  });
}

// 1. شاشة التسجيل الحقيقية (تطلب البيانات من أي مستخدم جديد)
class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _countryController = TextEditingController();
  final _emailController = TextEditingController();

  void _completeRegistration() {
    if (_nameController.text.trim().isEmpty || 
        _ageController.text.trim().isEmpty || 
        _countryController.text.trim().isEmpty || 
        _emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إدخال جميع البيانات الشخصية المطلوبة بدقة')),
      );
      return;
    }
    
    // حفظ البيانات المدخلة وتمريرها للتطبيق
    UserProfileData newUser = UserProfileData(
      name: _nameController.text.trim(),
      age: _ageController.text.trim(),
      country: _countryController.text.trim(),
      email: _emailController.text.trim(),
    );

    // الانتقال للوحة الرئيسية مع بيانات المستخدم الجديد الحقيقية
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainDashboardScreen(userData: newUser),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E0854), Color(0xFF0F0817)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.purpleAccent,
                      child: Icon(Icons.camera_alt, size: 40, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
                        child: const Icon(Icons.add, size: 18, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text("إنشاء حسابك الشخصي الجديد", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 30),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'الاسم بالكامل',
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'العمر',
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _countryController,
                  decoration: InputDecoration(
                    labelText: 'الدولة',
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'البريد الإلكتروني أو الهاتف',
                    labelStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8A2BE2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: _completeRegistration,
                    child: const Text('دخول التطبيق', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
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

// 2. الشاشة الرئيسية مع تمرير بيانات المستخدم الحقيقي لكل الأقسام
class MainDashboardScreen extends StatefulWidget {
  final UserProfileData userData;
  const MainDashboardScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      LiveRoomsGridScreen(userData: widget.userData),
      const AudioChatRoomsScreen(),
      const WalletAndDailyWithdrawScreen(),
      UserProfileScreen(userData: widget.userData),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF140B22),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'لايف'),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'رومات الصوت'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'المحفظة والشحن'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'الملف الشخصي'),
        ],
      ),
    );
  }
}

// 3. شاشة البث المباشر
class LiveRoomsGridScreen extends StatelessWidget {
  final UserProfileData userData;
  const LiveRoomsGridScreen({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("مرحباً، ${userData.name}", style: const TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: Colors.transparent,
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => ActiveLiveStreamRoom(userData: userData)));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(colors: [Color(0xFF3B185F), Color(0xFF1F0D35)]),
                border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
              ),
              child: const Stack(
                children: [
                  Positioned(
                    bottom: 12,
                    right: 12,
                    left: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("غرفة البث الاحترافي 🔥", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                        SizedBox(height: 4),
                        Text("مضيف مميز • 24.5k مشاهد", style: TextStyle(color: Colors.white70, fontSize: 10)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ActiveLiveStreamRoom extends StatefulWidget {
  final UserProfileData userData;
  const ActiveLiveStreamRoom({Key? key, required this.userData}) : super(key: key);

  @override
  State<ActiveLiveStreamRoom> createState() => _ActiveLiveStreamRoomState();
}

class _ActiveLiveStreamRoomState extends State<ActiveLiveStreamRoom> {
  String? activeGiftAnimation;

  void _sendGift(String giftName) {
    setState(() {
      activeGiftAnimation = "${widget.userData.name} أرسل: $giftName";
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          activeGiftAnimation = null;
        });
      }
    });
  }

  void _showGiftsPanel() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1B0F2E),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("الهدايا المتحركة الفورية", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _giftButton("💎 ماسة (x5)", () => _sendGift("💎 ماسة متطايرة!")),
                  _giftButton("🏎️ سيارة (x50)", () => _sendGift("🏎️ سيارة سباق فخمة!")),
                  _giftButton("🚀 صاروخ (x100)", () => _sendGift("🚀 صاروخ عملاق!")),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _giftButton(String label, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
      onPressed: () {
        Navigator.pop(context);
        onTap();
      },
      child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.white)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF240D42), Color(0xFF0F0817)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          if (activeGiftAnimation != null)
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.amber, width: 2)),
                child: Text(activeGiftAnimation!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber), textAlign: TextAlign.center),
              ),
            ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("غرفة: ${widget.userData.name}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                ),
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
                        onPressed: _showGiftsPanel,
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

// 4. رومات الصوت الجماعية
class AudioChatRoomsScreen extends StatelessWidget {
  const AudioChatRoomsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("رومات الصوت الجماعية", style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF190C29)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFF22113B), borderRadius: BorderRadius.circular(16)),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("روم سهرتنا وسوالف شبابية ✨", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 8),
                Text("صلاحيات المضيف كاملة (قفل المايك، طرد، كتم)", style: TextStyle(color: Colors.purpleAccent, fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}

// 5. المحفظة والشحن والسحب اليومي
class WalletAndDailyWithdrawScreen extends StatelessWidget {
  const WalletAndDailyWithdrawScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("المحفظة (شحن وسحب يومي)", style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF190C29)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF6A0DAD), Color(0xFF3B185F)]), borderRadius: BorderRadius.circular(20)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("رصيد الأرباح المتاح للسحب اليومي", style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 8),
                  Text("💎 50,000 كوينز (\$500)", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                    onPressed: () {},
                    child: const Text("شحن رصيد كوينز", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                    onPressed: () {},
                    child: const Text("طلب سحب يومي", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 6. الملف الشخصي الحقيقي للمستخدم المسجل
class UserProfileScreen extends StatelessWidget {
  final UserProfileData userData;
  const UserProfileScreen({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الملف الشخصي", style: TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF190C29)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 45, backgroundColor: Colors.purpleAccent, child: Icon(Icons.person, size: 55, color: Colors.white)),
            const SizedBox(height: 15),
            Text(userData.name, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("العمر: ${userData.age} | الدولة: ${userData.country}", style: const TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 5),
            Text(userData.email, style: const TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)),
              child: const Text("👑 VIP المستوى 10", style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
