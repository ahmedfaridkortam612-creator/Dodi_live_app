import 'package:flutter/material.dart';
import '../gift_bottom_sheet.dart';
import 'pk_battle_screen.dart';
import 'live_seats_widget.dart';
import 'live_chat_widget.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  // دالة لفتح نافذة الهدايا التفاعلية
  void _openGiftsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const GiftBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("غرفة البث المباشر - Dodi Live"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          // خلفية الشاشة وتصميم البث الأساسي
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF150A33), Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.live_tv, size: 80, color: Colors.purpleAccent),
                  SizedBox(height: 16),
                  Text(
                    'أنت الآن في غرفة البث المباشر',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'تفاعل، أرسل الهدايا الكبرى، واستمتع بالبث',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          
          // فيديو المذيع المصغر في الأعلى (يمين)
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: 110,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade900,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.purpleAccent, width: 1.5),
                ),
                child: const Center(
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ),
            ),
          ),

          // مقاعد البث التفاعلية في الأعلى (يسار)
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: SizedBox(
                width: 180,
                child: LiveSeatsWidget(),
              ),
            ),
          ),

          // نافذة الشات اللحظي في الجانب الأيسر أسفل المقاعد
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 12.0, bottom: 80.0, top: 180.0),
              child: SizedBox(
                width: 220,
                child: LiveChatWidget(),
              ),
            ),
          ),

          // زرار الهدايا العائم أسفل الشاشة (يمين)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton.extended(
                onPressed: _openGiftsMenu,
                backgroundColor: Colors.purpleAccent,
                icon: const Icon(Icons.card_giftcard, color: Colors.white),
                label: const Text('الهدايا', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),

          // زرار تحدي الـ PK العائم أسفل الشاشة (يسار)
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PkBattleScreen()),
                  );
                },
                backgroundColor: Colors.amber,
                icon: const Icon(Icons.flash_on, color: Colors.black),
                label: const Text('تحدي PK', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
