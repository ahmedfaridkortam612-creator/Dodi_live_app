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
        scaffoldBackgroundColor: const Color(0xFF0F0817),
        primaryColor: const Color(0xFF8A2BE2),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF9C27B0),
          secondary: Color(0xFFFFD700),
          surface: Color(0xFF1A102F),
        ),
        fontFamily: 'Cairo',
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      return LoginScreen(onLoginSuccess: () {
        setState(() {
          isLoggedIn = true;
        });
      });
    }
    return const MainNavigationScreen();
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, required this.onLoginSuccess});
  final VoidCallback onLoginSuccess;

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(colors: [Colors.purpleAccent, Colors.deepPurple]),
                    boxShadow: [
                      BoxShadow(color: Colors.purple.withOpacity(0.5), blurRadius: 20, spreadRadius: 5)
                    ],
                  ),
                  child: const Icon(Icons.live_tv, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  "DODI LIVE",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.white),
                ),
                const Text(
                  "عالم البثوث والألعاب والهدايا الفاخرة",
                  style: TextStyle(fontSize: 14, color: Colors.purpleAccent),
                ),
                const SizedBox(height: 40),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'البريد الإلكتروني أو رقم الهاتف',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                    prefixIcon: const Icon(Icons.person, color: Colors.purpleAccent),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'كلمة المرور',
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                    prefixIcon: const Icon(Icons.lock, color: Colors.purpleAccent),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8A2BE2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 8,
                      shadowColor: Colors.purpleAccent,
                    ),
                    onPressed: onLoginSuccess,
                    child: const Text('تسجيل الدخول / إنشاء حساب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("أو الدخول السريع عبر", style: TextStyle(color: Colors.white38, fontSize: 12)),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton(Icons.facebook, Colors.blue, "فيسبوك", onLoginSuccess),
                    const SizedBox(width: 20),
                    _socialButton(Icons.g_mobiledata, Colors.red, "جوجل", onLoginSuccess),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon, Color color, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const LiveStreamsFeedScreen(),
    const AudioRoomsScreen(),
    const MessagesScreen(),
    const WalletStoreScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF140B22),
        selectedItemColor: const Color(0xFFDA70D6),
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'لايفات'),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'رومات صوتية'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: 'الرسائل'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

class LiveStreamsFeedScreen extends StatelessWidget {
  const LiveStreamsFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("البثوث المباشرة المميزة", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ActiveLiveRoomScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B185F), Color(0xFF1F0D35)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(color: Colors.purple.withOpacity(0.2)),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.amber, width: 1.5),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.star, size: 12, color: Colors.amber),
                          SizedBox(width: 4),
                          Text("VIP 8", style: TextStyle(fontSize: 10, color: Colors.amber, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 12,
                    right: 12,
                    left: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("مشتعلة مع ملكة البثوث 🔥", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                        SizedBox(height: 4),
                        Text("اسم المضيف • 14.5k مشاهد", style: TextStyle(color: Colors.white70, fontSize: 10)),
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

class ActiveLiveRoomScreen extends StatelessWidget {
  const ActiveLiveRoomScreen({Key? key}) : super(key: key);

  void _showGiftPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1B0F2E),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("قسم الهدايا المتحركة (حسب الكوينزات)", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [1, 3, 5, 10, 30, 55].map((count) {
                    return Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: count == 1 ? Colors.purpleAccent : Colors.white10,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text("إرسال $count", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _giftItem("💎 ماسة سريعة", "10 كوينز", "X5"),
                    _giftItem("🏎️ سيارة فخمة", "500 كوينز", "X15"),
                    _giftItem("🚀 صاروخ الانفجار", "1000 كوينز", "X100 💥"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _giftItem(String name, String price, String multiplier) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.purple.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(multiplier, style: const TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(name, style: const TextStyle(color: Colors.white, fontSize: 12)),
          Text(price, style: const TextStyle(color: Colors.white54, fontSize: 10)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF240D42), Color(0xFF0F0817)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.purpleAccent, width: 2)),
                            child: const CircleAvatar(radius: 20, backgroundColor: Colors.purple),
                          ),
                          const SizedBox(width: 8),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("أحمد كورتام", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              Text("3.2k معجب", style: TextStyle(color: Colors.white60, fontSize: 10)),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'اكتب تعليقاً...',
                            hintStyle: const TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Colors.black38,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: const Color(0xFFFFD700),
                        child: const Icon(Icons.card_giftcard, color: Colors.black),
                        onPressed: () => _showGiftPanel(context),
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

class AudioRoomsScreen extends StatelessWidget {
  const AudioRoomsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("رومات الصوت المباشرة", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF190C29),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF38155E), Color(0xFF1B0B2E)]),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.purpleAccent.withOpacity(0.4)),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("روم سهرتنا البنفسجية ✨", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const Text("المضيف: أحمد كورتام", style: TextStyle(color: Colors.purpleAccent, fontSize: 11)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent),
                  onPressed: () {
                    _showRoomControlModal(context);
                  },
                  child: const Text("دخول الروم", style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showRoomControlModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF22113B),
        title: const Text("صلاحيات إدارة الروم", style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.amber),
              title: const Text("قفل / فتح المقاعد", style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.person_remove, color: Colors.redAccent),
              title: const Text("طرد مستخدم مزعج", style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الرسائل الخاصة", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF190C29),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.purpleAccent, child: Icon(Icons.person, color: Colors.white)),
            title: const Text("مستخدم مميز", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: const Text("أهلاً بك، هل يمكننا التحدث؟", style: TextStyle(color: Colors.white54)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(10)),
              child: const Text("VIP 2", style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("ملاحظة: خاصية الرد والمراسلة الحرة تتطلب اشتراك VIP 1 كحد أدنى!")),
              );
            },
          );
        },
      ),
    );
  }
}

class WalletStoreScreen extends StatelessWidget {
  const WalletStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المحفظة والشحن والأرباح", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF190C29),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF6A0DAD), Color(0xFF3B185F)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("رصيدك الحالي من الكوينز", style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 8),
                  Text("💎 142,500 كوينز (1,425\$)", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8A2BE2)),
                    onPressed: () {},
                    child: const Text("شحن كوينز", style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                    onPressed: () {
                      _showWithdrawDialog(context);
                    },
                    child: const Text("سحب الأرباح", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showWithdrawDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF22113B),
        title: const Text("سحب الأرباح (كاش / بنك)", style: TextStyle(color: Colors.white)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("اختر طريقة السحب المناسبة لأرباح الوكالة أو المضيف:", style: TextStyle(color: Colors.white70, fontSize: 13)),
            SizedBox(height: 15),
            ListTile(
              leading: Icon(Icons.phone_android, color: Colors.amber),
              title: Text("محفظة إلكترونية (فودافون كاش / إنستا باي)", style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
            ListTile(
              leading: Icon(Icons.account_balance, color: Colors.amber),
              title: Text("حساب بنكي / CIB Prime", style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("إغلاق", style: TextStyle(color: Colors.purpleAccent))),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الملف الشخصي والوكالات والـ VIP", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF190C29),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.amber, width: 3),
                  ),
                  child: const CircleAvatar(radius: 40, backgroundColor: Colors.purple),
                ),
                const SizedBox(height: 10),
                const Text("أحمد فارد كورتام", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(20)),
                  child: const Text("👑 VIP 10 الملكي", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Card(
            color: const Color(0xFF1E0E35),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: const Icon(Icons.business_center, color: Colors.purpleAccent),
              title: const Text("الوكالات وإدارة المضيفين", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text("قبول أو رفض الانضمام للوكالة واحتساب نسب التارجت", style: TextStyle(color: Colors.white60, fontSize: 11)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 10),
          Card(
            color: const Color(0xFF1E0E35),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: const Icon(Icons.workspace_premium, color: Colors.amber),
              title: const Text("متجر مستويات الـ VIP (1 إلى 10)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: const Text("ترقية حسابك للحصول على إطارات أفخم وتمييز كامل", style: TextStyle(color: Colors.white60, fontSize: 11)),
              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
