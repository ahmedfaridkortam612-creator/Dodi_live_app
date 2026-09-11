import 'package:flutter/material.dart';
import 'gift_bottom_sheet.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  void _openGiftsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
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
          // شاشة عرض البث الأساسية
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
                    'جودة عالية وتفاعل لحظي مع المتابعين',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          
          // فيديو المذيع المصغر في الأعلى
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

          // زرار الهدايا العائم أسفل الشاشة
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
        ],
      ),
    );
  }
}
