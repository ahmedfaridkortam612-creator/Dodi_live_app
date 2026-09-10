import 'package:flutter/material.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎥 البث المباشر وتحديات PK', style: TextStyle(fontSize: 14)),
        backgroundColor: const Color(0xFF1A0B36),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A1B4E),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
            ),
            child: Stack(
              children: [
                const Center(child: Text('👩‍🰰', style: TextStyle(fontSize: 40))),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                    child: const Text('LIVE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
                const Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('نور الشام ✨', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                      Text('تحدي PK ساخن 🔥', style: TextStyle(fontSize: 10, color: Colors.amber)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
