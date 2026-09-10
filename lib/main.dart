import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const DodiLiveApp());
}

class DodiLiveApp extends StatelessWidget {
  const DodiLiveApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dodi Live',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0410),
        primaryColor: const Color(0xFF8A2BE2),
        fontFamily: 'Cairo',
      ),
      home: const SplashScreen(),
    );
  }
}

// 1. شاشة افتتاحية احترافية
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=1000&auto=format&fit=crop',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.7), const Color(0xFF1A0B2E).withOpacity(0.9)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.amber, width: 2),
                    boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.6), blurRadius: 20)],
                  ),
                  child: const CircleAvatar(
                    radius: 55,
                    backgroundColor: Color(0xFF8A2BE2),
                    child: Icon(Icons.live_tv, size: 55, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Dodi Live',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'عالمك المفضل للبث المباشر والألعاب والدردشة',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 40),
                const CircularProgressIndicator(color: Colors.amber),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileModel {
  final String name;
  final String age;
  final String country;
  final String gender;
  final String email;
  final String avatarUrl;
  int diamonds;
  int coins;

  UserProfileModel({
    required this.name,
    required this.age,
    required this.country,
    required this.gender,
    required this.email,
    required this.avatarUrl,
    this.diamonds = 1200,
    this.coins = 50000,
  });
}

// 2. شاشة تسجيل الحساب (العمر كتابة يدوية)
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();

  final List<Map<String, String>> _countries = [
    {'name': 'Afghanistan', 'flag': '🇦🇫'},
    {'name': 'Algeria', 'flag': '🇩🇿'},
    {'name': 'Argentina', 'flag': '🇦🇷'},
    {'name': 'Australia', 'flag': '🇦🇺'},
    {'name': 'Bahrain', 'flag': '🇧🇭'},
    {'name': 'Brazil', 'flag': '🇧🇷'},
    {'name': 'Canada', 'flag': '🇨🇦'},
    {'name': 'Egypt', 'flag': '🇪🇬'},
    {'name': 'France', 'flag': '🇫🇷'},
    {'name': 'Germany', 'flag': '🇩🇪'},
    {'name': 'India', 'flag': '🇮🇳'},
    {'name': 'Iraq', 'flag': '🇮🇶'},
    {'name': 'Italy', 'flag': '🇮🇹'},
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
    {'name': 'United Kingdom', 'flag': '🇬🇧'},
    {'name': 'United States', 'flag': '🇺🇸'},
    {'name': 'Yemen', 'flag': '🇾🇪'},
  ];

  String? _selectedCountry;
  String _selectedGender = 'ذكر';
  
  final List<String> _avatarOptions = [
    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150',
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
    'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=150',
    'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=150',
  ];
  late String _selectedAvatar;

  @override
  void initState() {
    super.initState();
    _selectedAvatar = _avatarOptions[0];
  }

  void _submitData() {
    if (_nameController.text.isEmpty ||
        _selectedCountry == null ||
        _ageController.text.isEmpty ||
        _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء إكمال كافة البيانات (الاسم، العمر، الدولة، البريد)')),
      );
      return;
    }

    UserProfileModel user = UserProfileModel(
      name: _nameController.text.trim(),
      age: _ageController.text.trim(),
      country: _selectedCountry!,
      gender: _selectedGender,
      email: _emailController.text.trim(),
      avatarUrl: _selectedAvatar,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainDashboard(user: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل حساب جديد - Dodi Live', style: TextStyle(fontSize: 18)),
        backgroundColor: const Color(0xFF150824),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF150824), Color(0xFF0B0410)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const Text('اختر صورتك الشخصية:', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _avatarOptions.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedAvatar == _avatarOptions[index];
                    return GestureDetector(
                      onTap: () => setState(() => _selectedAvatar = _avatarOptions[index]),
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: isSelected ? Colors.amber : Colors.transparent, width: 3),
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(_avatarOptions[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'الاسم بالكامل',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'العمر (مثال: 25)',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                dropdownColor: const Color(0xFF1B0F2E),
                decoration: InputDecoration(
                  labelText: 'اختر الدولة',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                value: _selectedCountry,
                items: _countries.map((country) {
                  return DropdownMenuItem<String>(
                    value: country['name'],
                    child: Text('${country['flag']}  ${country['name']}'),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedCountry = val),
              ),
              const SizedBox(height: 15),
              const Text('الجنس:', style: TextStyle(color: Colors.white70)),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('ذكر 👨'),
                      value: 'ذكر',
                      groupValue: _selectedGender,
                      onChanged: (val) => setState(() => _selectedGender = val!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('أنثى 👩'),
                      value: 'أنثى',
                      groupValue: _selectedGender,
                      onChanged: (val) => setState(() => _selectedGender = val!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8A2BE2),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: _submitData,
                child: const Text('دخول عالم Dodi Live 🚀', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
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
      HomeFeedScreen(user: widget.user),
      VoiceRoomsScreen(user: widget.user),
      GamesHubScreen(user: widget.user),
      WalletScreen(user: widget.user),
      ProfileScreen(user: widget.user),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF10061B),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        onTap: (idx) => setState(() => _currentIndex = idx),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'اللايف'),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'الصوتي'),
          BottomNavigationBarItem(icon: Icon(Icons.games), label: 'الألعاب'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

// أ. شاشة رومات اللايف
class HomeFeedScreen extends StatelessWidget {
  final UserProfileModel user;
  const HomeFeedScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مرحباً، ${user.name} 🔥'),
        backgroundColor: const Color(0xFF150824),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box, color: Colors.amber),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ActiveLiveRoom(user: user, roomTitle: 'بثي المباشر المميز')));
            },
          )
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.78,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ActiveLiveRoom(user: user, roomTitle: 'غرفة بث مباشر رقم ${index + 1}')),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=500'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: const [
                        CircleAvatar(radius: 12, backgroundColor: Colors.red, child: Icon(Icons.fiber_manual_record, size: 10, color: Colors.white)),
                        SizedBox(width: 5),
                        Text("مباشر حر 🔥", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text("مضيف رقم ${index + 1}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                    const Text("👁️ 2.4k مشاهد", style: TextStyle(color: Colors.white70, fontSize: 10)),
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

// ب. غرفة اللايف المتكاملة
class ActiveLiveRoom extends StatefulWidget {
  final UserProfileModel user;
  final String roomTitle;
  const ActiveLiveRoom({Key? key, required this.user, required this.roomTitle}) : super(key: key);

  @override
  State<ActiveLiveRoom> createState() => _ActiveLiveRoomState();
}

class _ActiveLiveRoomState extends State<ActiveLiveRoom> {
  final List<bool> _seatMuted = [false, true, false, true, false, false];
  final List<String?> _seatUsers = ['أحمد', null, 'سارة', null, 'محمد', 'ريم'];

  String? _broadcastMessage;
  String? _broadcastGiftImage;

  void _triggerBigGiftAnnouncement(String sender, String giftImg) {
    setState(() {
      _broadcastMessage = "$sender أرسل هدية فاخرة كبرى!";
      _broadcastGiftImage = giftImg;
    });
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _broadcastMessage = null;
          _broadcastGiftImage = null;
        });
      }
    });
  }

  void _openGiftBox() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1B0F2E),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('🎁 صندوق الهدايا الملكية', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
                  Text('رصيدك: ${widget.user.coins} 🪙', style: const TextStyle(color: Colors.white70)),
                ],
              ),
              const Divider(color: Colors.white24),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _giftCard('وردة فاخرة 🌹', 1000, 'https://cdn-icons-png.flaticon.com/512/2965/2965567.png', false),
                    _giftCard('سيارة رياضية 🏎️', 25000, 'https://cdn-icons-png.flaticon.com/512/741/741407.png', false),
                    _giftCard('قصر الأساطير 🏰', 75000, 'https://cdn-icons-png.flaticon.com/512/3067/3067407.png', true),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _giftCard(String name, int price, String imgUrl, bool isMega) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        if (widget.user.coins >= price) {
          setState(() => widget.user.coins -= price);
          if (price > 50000) {
            _triggerBigGiftAnnouncement(widget.user.name, imgUrl);
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم إرسال ($name) بنجاح!')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('رصيدك لا يكفي، شحن الكوينز مطلوب!')));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2C164D),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: isMega ? Colors.amber : Colors.purpleAccent),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(imgUrl, width: 35, height: 35),
            const SizedBox(height: 5),
            Text(name, style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
            Text('$price كوينز', style: const TextStyle(fontSize: 9, color: Colors.amber)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network('https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=1000&auto=format&fit=crop', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(backgroundImage: NetworkImage(widget.user.avatarUrl)),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.roomTitle, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              const Text('ID: 889234 • 3.2k', style: TextStyle(color: Colors.white70, fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                if (_broadcastMessage != null)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Colors.amber, Colors.deepOrange]),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.8), blurRadius: 10)],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_broadcastGiftImage != null) Image.network(_broadcastGiftImage!, width: 30, height: 30),
                        const SizedBox(width: 10),
                        Text(_broadcastMessage!, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
                      ],
                    ),
                  ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      bool hasUser = _seatUsers[index] != null;
                      bool isMuted = _seatMuted[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _seatMuted[index] = !_seatMuted[index];
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: hasUser ? Colors.purpleAccent : Colors.white24),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.purple,
                                child: Text('${index + 1}', style: const TextStyle(fontSize: 11, color: Colors.white)),
                              ),
                              const SizedBox(width: 6),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(hasUser ? _seatUsers[index]! : 'مقعد فارغ', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                  Icon(isMuted ? Icons.mic_off : Icons.mic, size: 12, color: isMuted ? Colors.red : Colors.greenAccent),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'اكتب تعليقاً...',
                            filled: true,
                            fillColor: Colors.black45,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton(
                        heroTag: 'giftBtn',
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

// ج. الغرف الصوتية
class VoiceRoomsScreen extends StatelessWidget {
  final UserProfileModel user;
  const VoiceRoomsScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('غرف الصوت التفاعلية 🎙️'), backgroundColor: const Color(0xFF150824)),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF2E124F), Color(0xFF150824)]),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.purple.withOpacity(0.4)),
            ),
            child: Row(
              children: [
                const CircleAvatar(radius: 30, backgroundColor: Colors.amber, child: Icon(Icons.mic, color: Colors.black, size: 30)),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('سهرة طرب وغناء رقم ${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 5),
                      const Text('🎤 8 متحدثين • 120 مستمع', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8A2BE2)),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم الانضمام للغرفة الصوتية بنجاح')));
                  },
                  child: const Text('دخول'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// د. الألعاب
class GamesHubScreen extends StatelessWidget {
  final UserProfileModel user;
  const GamesHubScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مركز الألعاب التفاعلية 🎮'), backgroundColor: const Color(0xFF150824)),
      body: GridView.count(
        padding: const EdgeInsets.all(15),
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          _gameCard(context, 'لعبة الحظ السعيد 🎰', 'العب واربح أضعاف الكوينزات', Colors.deepPurple),
          _gameCard(context, 'تحدي المعارك ⚔️', 'نافس الأصدقاء بالبث المباشر', Colors.indigo),
          _gameCard(context, 'عجلة الحظ الملكية 🎡', 'لف العجلة واكسب جوائز ضخمة', Colors.purple),
          _gameCard(context, 'لعبة التخمين 🔮', 'اختبر ذكائك واكسب الماسات', Colors.deepOrange),
        ],
      ),
    );
  }

  Widget _gameCard(BuildContext context, String title, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber.withOpacity(0.5)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.sports_esports, size: 45, color: Colors.amber),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
          const SizedBox(height: 5),
          Text(desc, style: const TextStyle(fontSize: 10, color: Colors.white70), textAlign: TextAlign.center),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, minimumSize: const Size(double.infinity, 30)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('جاري بدء تشغيل $title...')));
            },
            child: const Text('العب الآن', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

// هـ. المحفظة
class WalletScreen extends StatefulWidget {
  final UserProfileModel user;
  const WalletScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  void _exchangeDiamonds(int amount) {
    if (widget.user.diamonds >= amount) {
      setState(() {
        widget.user.diamonds -= amount;
        widget.user.coins += (amount * 3);
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم تحويل $amount ماسة إلى ${amount * 3} كوينز بنجاح!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('رصيد الماس لا يكفي')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('محفظة الأرباح والشحن 💰'), backgroundColor: const Color(0xFF150824)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF8A2BE2), Color(0xFF4A0E4E)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [
                  const Text('الكوينز 🪙', style: TextStyle(color: Colors.white70)),
                  Text('${widget.user.coins}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.amber)),
                ]),
                Container(height: 30, width: 1, color: Colors.white24),
                Column(children: [
                  const Text('الماس 💎', style: TextStyle(color: Colors.white70)),
                  Text('${widget.user.diamonds}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 25),
          const Text('استبدال الماسات إلى كوينز:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            onPressed: () => _exchangeDiamonds(200),
            child: const Text('تحويل 200 ماسة ➔ 600 كوينز'),
          ),
          const SizedBox(height: 25),
          const Text('شحن فوري:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
          const SizedBox(height: 10),
          ListTile(
            tileColor: const Color(0xFF1B0F2E),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            leading: const Icon(Icons.diamond, color: Colors.cyanAccent),
            title: const Text('1000 ماسة 💎'),
            subtitle: const Text('باقات الشحن السريع الآمن'),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              onPressed: () {
                setState(() => widget.user.diamonds += 1000);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم الشحن بنجاح!')));
              },
              child: const Text('\$10.00'),
            ),
          ),
        ],
      ),
    );
  }
}

// و. الملف الشخصي
class ProfileScreen extends StatelessWidget {
  final UserProfileModel user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي'), backgroundColor: const Color(0xFF150824)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 50, backgroundImage: NetworkImage(user.avatarUrl)),
              const SizedBox(height: 15),
              Text(user.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber)),
              const SizedBox(height: 5),
              Text('الدولة: ${user.country}', style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 5),
              Text('العمر: ${user.age} سنة', style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegistrationScreen()));
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
