import 'package:flutter/material.dart';
import 'live_screen.dart';
import 'wallet_screen.dart';
import 'profile_screen.dart';
import 'audio_room_screen.dart'; // استيراد شاشة الغرفة الصوتية

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // القائمة الرئيسية للشاشات اللي بتظهر مع الـ BottomNavigationBar
  final List<Widget> _screens = [
    const Center(
      child: Text(
        'الرئيسية - البثوث المباشرة 🎥',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
    const LiveScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0716),
      // زر عائم (FloatingActionButton) سريع لفتح الغرفة الصوتية في أي وقت
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        child: const Icon(Icons.mic_rounded, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AudioRoomScreen()),
          );
        },
        tooltip: 'فتح غرفة صوتية 🎙️',
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF130B22),
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv_rounded),
            label: 'بث',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_rounded),
            label: 'المحفظة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'بروفايل',
          ),
        ],
      ),
    );
  }
}
