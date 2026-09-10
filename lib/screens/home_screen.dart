import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('👑 Magic Live - الغرف الصوتية', style: TextStyle(fontSize: 14)),
        backgroundColor: const Color(0xFF1A0B36),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text('🔥 الغرف النشطة الآن', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          // عينة لغرفة صوتية
          Card(
            color: const Color(0xFF2A1B4E),
            child: ListTile(
              leading: const CircleAvatar(backgroundColor: Colors.amber, child: Text('🎙️')),
              title: const Text('سهرة العندليب الطربية 🎵', style: TextStyle(color: Colors.white, fontSize: 13)),
              subtitle: const Text('المضيف: كابتن أحمد • 7/8 أعضاء', style: TextStyle(color: Colors.grey, fontSize: 11)),
              trailing: const Text('انضم 🚀', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              onTap: () {
                // سيتم ربطها بشاشة الروم الصوتي التفصيلية لاحقاً
              },
            ),
          ),
        ],
      ),
    );
  }
}
