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
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.pink,
      ),
      home: const MainHomeScreen(),
    );
  }
}

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
    const WalletAndStoreTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.white60,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'البث المباشر'),
          BottomNavigationBarItem(icon: Icon(Icons.games), label: 'الألعاب والحظ'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'المحفظة'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
      ),
    );
  }
}

// تبويب البث المباشر والصوتي
class HomeStreamsTab extends StatelessWidget {
  const HomeStreamsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dodi Live - البثوث المباشرة"),
        backgroundColor: Colors.grey.shade900,
        actions: [
          IconButton(
            icon: const Icon(Icons.mic, color: Colors.pinkAccent),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AudioRoomScreen()));
            },
          )
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LiveStreamRoomScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1516450360452-9312f5e86fc7'),
                  fit: BoxFit.cover,
                  opacity: 0.6,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
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
                        const Text("👁️ 1.4K", style: TextStyle(fontSize: 12, color: Colors.white70)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("قناة المذيع المميز", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text("غرفة البث المباشر والدردشة", style: TextStyle(color: Colors.white70, fontSize: 10)),
                      ],
                    )
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

// شاشة البث المباشر (فيديو + هدايا ميكو وبيجو)
class LiveStreamRoomScreen extends StatelessWidget {
  const LiveStreamRoomScreen({Key? key}) : super(key: key);

  void _showGiftsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade900,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("هدايا Dodi الفاخرة (بيجو وميكو)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.pinkAccent)),
              const SizedBox(height: 15),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  children: [
                    _giftItem("🏎️", "سيارة فارهة", "5000"),
                    _giftItem("💍", "خاتم الماس", "2000"),
                    _giftItem("🦁", "أسود الملك", "10000"),
                    _giftItem("🌹", "وردة حمراء", "100"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _giftItem(String emoji, String name, String price) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 30)),
        Text(name, style: const TextStyle(fontSize: 10, color: Colors.white70)),
        Text("$price كوينز", style: const TextStyle(fontSize: 10, color: Colors.pinkAccent)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.grey.shade800,
              child: const Center(child: Text("🎥 بث مباشر يعمل الآن...", style: TextStyle(color: Colors.white54))),
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
                            CircleAvatar(radius: 15, backgroundColor: Colors.pinkAccent, child: Icon(Icons.person, size: 16)),
                            SizedBox(width: 8),
                            Text("اسم المضيف", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "اكتب تعليقاً...",
                            hintStyle: const TextStyle(color: Colors.white60),
                            filled: true,
                            fillColor: Colors.black54,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: Colors.pinkAccent,
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

// غرفة البث الصوتي (صوتيات فقط)
class AudioRoomScreen extends StatelessWidget {
  const AudioRoomScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("غرف الدردشة الصوتية"), backgroundColor: Colors.pink.shade900),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: 9,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(color: Colors.grey.shade900, shape: BoxShape.circle, border: Border.all(color: Colors.pinkAccent, width: 2)),
            child: const Center(child: Icon(Icons.mic, color: Colors.white70, size: 30)),
          );
        },
      ),
    );
  }
}

// تبويب الألعاب وألعاب الحظ (السمك، الخضار، البوكر، والمكسب والخسارة والتفجيرات)
class GamesLobbyTab extends StatelessWidget {
  const GamesLobbyTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ألعاب الحظ والترفيه (الميكو والبيجو)"), backgroundColor: Colors.grey.shade900),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _gameCard(context, "🐟 لعبة صيد السمك المحظوظ", "اكسب أضعاف عملاتك مع تفجيرات الحظ الكبرى!"),
          _gameCard(context, "🥕 لعبة سلة الخضار السريعة", "اختر الخضار الرابحة وضاعف رصيدك فوراً."),
          _gameCard(context, "🃏 بوكر وتحديات الملوك", "أعظم طاولات التحدي والجوائز الكبرى."),
          _gameCard(context, "💣 عجلة الحظ والتفجيرات الكبرى", "جرب حظك الآن: ربح مضاعف أو خسارة مثيرة!"),
        ],
      ),
    );
  }

  Widget _gameCard(BuildContext context, String title, String desc) {
    return Card(
      color: Colors.grey.shade900,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
        subtitle: Text(desc, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("🎮 جاري فتح اللعبة وبدء السيستم...")));
          },
          child: const Text("العب الآن"),
        ),
      ),
    );
  }
}

// المحفظة والشحن
class WalletAndStoreTab extends StatelessWidget {
  const WalletAndStoreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("محفظة Dodi Live"), backgroundColor: Colors.grey.shade900),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.pink.shade900.withOpacity(0.3), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.pinkAccent)),
              child: Column(
                children: const [
                  Text("رصيدك الحالي", style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 10),
                  Text("💎 45,200 كوينز", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.styleFrom().runtimeType == ElevatedButton ? SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                onPressed: () {},
                child: const Text("شحن الكوينز فوراً", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}

// البروفايل
class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("حسابي الشخصي"), backgroundColor: Colors.grey.shade900),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(radius: 50, backgroundColor: Colors.pinkAccent, child: Icon(Icons.person, size: 60, color: Colors.white)),
            SizedBox(height: 15),
            Text("مستخدم Dodi Live", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("ID: 885924", style: TextStyle(color: Colors.white60)),
          ],
        ),
      ),
    );
  }
}
