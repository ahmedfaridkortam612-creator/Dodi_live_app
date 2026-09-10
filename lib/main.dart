import 'package:flutter/material.dart';

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
        scaffoldBackgroundColor: const Color(0xFF0F051D),
        primaryColor: const Color(0xFF7B2CBF),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF9D4EDD),
          secondary: Color(0xFFFF007F),
          surface: Color(0xFF10002B),
        ),
      ),
      home: const AuthScreen(),
    );
  }
}

// 1. شاشة تسجيل الدخول
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  void _submit(BuildContext context) {
    if (_emailController.text.isNotEmpty || _passController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainHomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى إدخال البريد الإلكتروني أو الهاتف"), backgroundColor: Colors.purple),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3C096C), Color(0xFF10002B), Color(0xFF0F051D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.live_tv_rounded, size: 90, color: Color(0xFFE0AAFF)),
                const SizedBox(height: 12),
                const Text("DODI LIVE", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 3.0)),
                const Text("عالم البث المباشر والوكالات الفاخرة", style: TextStyle(color: Colors.white60, fontSize: 13)),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: "البريد الإلكتروني أو رقم الهاتف",
                          labelStyle: TextStyle(color: Colors.white70),
                          prefixIcon: Icon(Icons.person_outline, color: Colors.purpleAccent),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.purpleAccent)),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: "كلمة المرور",
                          labelStyle: TextStyle(color: Colors.white70),
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.purpleAccent),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.purpleAccent)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7B2CBF),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: () => _submit(context),
                          child: Text(_isLogin ? "تسجيل الدخول" : "إنشاء حساب جديد", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () => setState(() => _isLogin = !_isLogin),
                        child: Text(_isLogin ? "لا تمتلك حساباً؟ سجل الآن" : "لديك حساب بالفعل؟ سجل دخولك", style: const TextStyle(color: Color(0xFFE0AAFF))),
                      ),
                    ],
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

// 2. الواجهة الرئيسية
class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeStreamsTab(),
    const GamesLobbyTab(),
    const AgencyManagementTab(), // تبويب الوكالات والمضيفين الجديد
    const WalletAndStoreTab(),   // تبويب المحفظة والسحب المالي
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF10002B),
        selectedItemColor: const Color(0xFFE0AAFF),
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.live_tv_rounded), label: 'اللايفات'),
          BottomNavigationBarItem(icon: Icon(Icons.casino), label: 'الألعاب'),
          BottomNavigationBarItem(icon: Icon(Icons.business_center), label: 'الوكالات'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_rounded), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'حسابي'),
        ],
      ),
    );
  }
}

// تبويب اللايفات
class HomeStreamsTab extends StatelessWidget {
  const HomeStreamsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dodi Live ✨ البثوث المباشرة", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF10002B),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF10002B), Color(0xFF0F051D)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.72,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LiveStreamRoomScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(colors: [Color(0xFF3C096C), Color(0xFF5A189A)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  border: Border.all(color: const Color(0xFFE0AAFF).withOpacity(0.4), width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.pinkAccent, borderRadius: BorderRadius.circular(8)),
                            child: const Text("LIVE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                          const Text("🔥 3.4K", style: TextStyle(fontSize: 11, color: Colors.white70)),
                        ],
                      ),
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: const Color(0xFFFFD700), width: 3),
                              ),
                            ),
                            const CircleAvatar(radius: 28, backgroundColor: Colors.purple, child: Icon(Icons.person, size: 35)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("نجمة البثوث 👑", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
                          SizedBox(height: 2),
                          Text("غرفة الحفلات الكبرى", style: TextStyle(color: Colors.white60, fontSize: 10)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// 3. شاشة البث المباشر والهدايا المتحركة بالأعداد
class LiveStreamRoomScreen extends StatefulWidget {
  const LiveStreamRoomScreen({Key? key}) : super(key: key);

  @override
  State<LiveStreamRoomScreen> createState() => _LiveStreamRoomScreenState();
}

class _LiveStreamRoomScreenState extends State<LiveStreamRoomScreen> {
  int _selectedQuantity = 1;
  final List<int> _quantities = [1, 3, 5, 10, 30, 55];
  
  final List<Map<String, dynamic>> _giftsList = [
    {"name": "وردة رقيقة", "emoji": "🌹", "price": 10},
    {"name": "قلب حب متحرك", "emoji": "💖", "price": 50},
    {"name": "خاتم الماس", "emoji": "💍", "price": 500},
    {"name": "سيارة فارهة", "emoji": "🏎️", "price": 2500},
    {"name": "أسد الملك", "emoji": "🦁", "price": 10000},
    {"name": "تفجيرة الصواريخ الكبرى", "emoji": "🚀", "price": 25000},
  ];

  void _showGiftsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF18023A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: 420,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("هدايا Dodi الملكية (مرتبة حسب الكوينز) 🎁", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFFE0AAFF))),
                  const SizedBox(height: 12),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.9, crossAxisSpacing: 10, mainAxisSpacing: 10),
                      itemCount: _giftsList.length,
                      itemBuilder: (context, index) {
                        final gift = _giftsList[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.purple.shade900.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.purpleAccent.withOpacity(0.4)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(gift['emoji'], style: const TextStyle(fontSize: 32)),
                              const SizedBox(height: 4),
                              Text(gift['name'], style: const TextStyle(fontSize: 10, color: Colors.white70)),
                              Text("💎 ${gift['price']}", style: const TextStyle(fontSize: 10, color: Color(0xFFE0AAFF), fontWeight: FontWeight.bold)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(color: Colors.white24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("اختر عدد الهدية:", style: TextStyle(color: Colors.white70, fontSize: 13)),
                      DropdownButton<int>(
                        value: _selectedQuantity,
                        dropdownColor: const Color(0xFF240046),
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        items: _quantities.map((q) {
                          return DropdownMenuItem<int>(
                            value: q,
                            child: Text("$q قطعة ⚡"),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setModalState(() {
                            _selectedQuantity = val!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("🎵✨ تم تشغيل صوت الهدية وتأثيرها المتحرك بعدد [$_selectedQuantity] بنجاح!"),
                            backgroundColor: Colors.purple,
                          ),
                        );
                      },
                      child: Text("إرسال الهدية المتحركة (العدد: $_selectedQuantity)", style: const TextStyle(fontWeight: FontWeight.bold)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF240046), Color(0xFF0F051D)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
              child: const Center(child: Text("🎥 البث المباشر يعمل الآن...", style: TextStyle(color: Colors.white54))),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: const [
                            CircleAvatar(radius: 14, backgroundColor: Color(0xFF9D4EDD), child: Icon(Icons.person, size: 16)),
                            SizedBox(width: 8),
                            Text("المضيف المميز", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                      ),
                      IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "اكتب تعليقاً...",
                            hintStyle: const TextStyle(color: Colors.white38),
                            filled: true,
                            fillColor: Colors.black38,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: const Color(0xFF7B2CBF),
                        child: const Icon(Icons.card_giftcard, color: Colors.white),
                        onPressed: () => _showGiftsModal(context),
                      ),
                    ],
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

// 4. ألعاب الحظ مع المضاعفات الكبرى والتفجيرة ×100
class GamesLobbyTab extends StatelessWidget {
  const GamesLobbyTab({Key? key}) : super(key: key);

  void _openGameDialog(BuildContext context, String gameName) {
    showDialog(
      context: context,
      builder: (context) {
        int selectedMultiplier = 1;
        return AlertDialog(
          backgroundColor: const Color(0xFF18023A),
          title: Text(gameName, style: const TextStyle(color: Color(0xFFE0AAFF), fontWeight: FontWeight.bold)),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("اختر معامل المضاعفة للحظ والتفجير:", style: TextStyle(color: Colors.white70, fontSize: 13)),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [1, 2, 10, 15, 20, 100].map((m) {
                      bool isSelected = selectedMultiplier == m;
                      return ChoiceChip(
                        label: Text(m == 100 ? "💣 تفجيرة ×100" : "×$m"),
                        selected: isSelected,
                        selectedColor: Colors.pinkAccent,
                        backgroundColor: const Color(0xFF240046),
                        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontWeight: FontWeight.bold),
                        onSelected: (val) {
                          setState(() {
                            selectedMultiplier = m;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Text("الرهان الحالي مضاعف بنسبة: [ $selectedMultiplier ]", style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("إلغاء", style: TextStyle(color: Colors.white60)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("🎉 مبروك! دارت اللعبة وسجلت ربحاً أو خسارة في سيستم الحظ والتفجيرات!"), backgroundColor: Colors.purple),
                );
              },
              child: const Text("ابدأ الجولة الآن"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ألعاب الحظ والتفجيرات الكبرى 🎮"), backgroundColor: const Color(0xFF10002B)),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF10002B), Color(0xFF0F051D)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _gameCard(context, "🐟 صيد السمك المحظوظ", "أضعاف الحظ والتفجيرات الكبرى (ضرب حتى ×100)"),
            _gameCard(context, "🥕 سلة الخضار السريعة", "اختر الخضار الرابحة وضاعف رصيدك فوراً"),
            _gameCard(context, "🃏 بوكر تحديات الملوك", "أعظم طاولات التحدي والجوائز الكبرى"),
            _gameCard(context, "💣 عجلة التفجيرات الخارقة", "مكسب مضاعف أو خسارة مثيرة (تدعم ضرب ×100)"),
          ],
        ),
      ),
    );
  }

  Widget _gameCard(BuildContext context, String title, String desc) {
    return Card(
      color: const Color(0xFF240046),
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.purpleAccent.withOpacity(0.3)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE0AAFF))),
        subtitle: Text(desc, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7B2CBF)),
          onPressed: () => _openGameDialog(context, title),
          child: const Text("العب الآن"),
        ),
      ),
    );
  }
}

// 5. تبويب إدارة الوكالات والمضيفين (انضمام المضيف وتفعيل الوكالة ونسب التارجت)
class AgencyManagementTab extends StatefulWidget {
  const AgencyManagementTab({Key? key}) : super(key: key);

  @override
  State<AgencyManagementTab> createState() => _AgencyManagementTabState();
}

class _AgencyManagementTabState extends State<AgencyManagementTab> {
  bool _isJoinedAgency = false;
  String _agencyName = "وكالة النجوم الملكية (ID: 5541)";

  void _showJoinRequestDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF18023A),
          title: const Text("دعوة انضمام لوكالة", style: TextStyle(color: Color(0xFFE0AAFF))),
          content: Text("هل تريد قبول الانضمام إلى [ $_agencyName ] لتفعيل حسابك كمضيف والحصول على نسب التارجت والدعم؟"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("رفض", style: TextStyle(color: Colors.redAccent)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              onPressed: () {
                setState(() {
                  _isJoinedAgency = true;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("✅ تم قبول الانضمام للوكالة بنجاح وتفعيل حساب المضيف!"), backgroundColor: Colors.purple),
                );
              },
              child: const Text("قبول الانضمام"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إدارة الوكالات والمضيفين 🏢"), backgroundColor: const Color(0xFF10002B)),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF10002B), Color(0xFF0F051D)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF3C096C), Color(0xFF5A189A)]),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE0AAFF), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("حالة حساب المضيف في الوكالة", style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_isJoinedAgency ? "🟢 مفعل داخل الوكالة" : "🔴 غير منضم لوكالة", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _isJoinedAgency ? Colors.greenAccent : Colors.amberAccent)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: _isJoinedAgency ? Colors.red.shade800 : Colors.pinkAccent),
                        onPressed: _isJoinedAgency ? () {
                          setState(() => _isJoinedAgency = false);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم مغادرة الوكالة.")));
                        } : _showJoinRequestDialog,
                        child: Text(_isJoinedAgency ? "مغادرة الوكالة" : "قبول الدعوة"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("حاسبة أرباح وتارجت الوكلاء والمضيفين:", style: TextStyle(color: Color(0xFFE0AAFF), fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 10),
            _infoCard("📊 تارجت المضيف الحالي", "50,000 نقطة (تحقيق نسبة أرباح عالية)"),
            _infoCard("💼 عمولة الوكيل (Agency Commission)", "تحويل نسبة مئوية تلقائية للوكيل من تارجت المضيفين"),
            _infoCard("🏛️ نسبة الإدارة (Admin Share)", "اقتطاع نسبة المنصة والنظام الآلي"),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF240046),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 13)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 11)),
        ],
      ),
    );
  }
}

// 6. المحفظة وسحب الأرباح (محفظة كاش أو تحويل بنكي)
class WalletAndStoreTab extends StatefulWidget {
  const WalletAndStoreTab({Key? key}) : super(key: key);

  @override
  State<WalletAndStoreTab> createState() => _WalletAndStoreTabState();
}

class _WalletAndStoreTabState extends State<WalletAndStoreTab> {
  String _selectedWithdrawMethod = "محفظة كاش (Vodafone / Instapay)";
  final _accountController = TextEditingController();

  void _showWithdrawModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF18023A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("سحب أرباح المضيف والوكيل 💸", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFE0AAFF))),
                  const SizedBox(height: 15),
                  const Text("اختر طريـقة السحب:", style: TextStyle(color: Colors.white70, fontSize: 13)),
                  DropdownButton<String>(
                    value: _selectedWithdrawMethod,
                    dropdownColor: const Color(0xFF240046),
                    isExpanded: true,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    items: ["محفظة كاش (Vodafone / Instapay)", "تحويل بنكي مباشر"].map((method) {
                      return DropdownMenuItem(value: method, child: Text(method));
                    }).toList(),
                    onChanged: (val) {
                      setModalState(() {
                        _selectedWithdrawMethod = val!;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _accountController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: _selectedWithdrawMethod.contains("كاش") ? "رقم الهاتف / انستاباي" : "رقم الحساب البنكي IBAN",
                      labelStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.purpleAccent)),
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("🚀 تم إرسال طلب السحب بنجاح وسيتم المعالجة والتحويل قريباً!"), backgroundColor: Colors.purple),
                        );
                      },
                      child: const Text("تأكيد طلب السحب", style: TextStyle(fontWeight: FontWeight.bold)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("محفظة الأرباح وسحب الأموال 💎"), backgroundColor: const Color(0xFF10002B)),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF10002B), Color(0xFF0F051D)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF5A189A), Color(0xFF3C096C)]),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE0AAFF), width: 1.5),
              ),
              child: Column(
                children: const [
                  Text("أرباح المضيف القابلة للسحب", style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 10),
                  Text("💎 142,500 كوينز ($1,425)", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7B2CBF)),
                onPressed: _showWithdrawModal,
                child: const Text("سحب الأرباح (كاش / بنك)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 7. حسابي الشخصي
class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الملف الشخصي 👑"), backgroundColor: const Color(0xFF10002B)),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF10002B), Color(0xFF0F051D)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFFFD700), width: 4),
                  ),
                ),
                const CircleAvatar(radius: 48, backgroundColor: Color(0xFF7B2CBF), child: Icon(Icons.person, size: 60, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 15),
            const Text("أحمد فرید", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 5),
            const Text("ID: 9941207", style: TextStyle(color: Color(0xFFE0AAFF))),
          ],
        ),
      ),
    );
  }
}
