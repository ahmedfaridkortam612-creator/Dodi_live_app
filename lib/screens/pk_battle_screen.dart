import 'package:flutter/material.dart';

class PkBattleScreen extends StatefulWidget {
  const PkBattleScreen({super.key});

  @override
  State<PkBattleScreen> createState() => _PkBattleScreenState();
}

class _PkBattleScreenState extends State<PkBattleScreen> {
  int host1Score = 1250;
  int host2Score = 980;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('معركة التحدي (PK Battle)'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // شريط النتيجة والتحدي العلوي
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: const Color(0xFF150A33),
            child: Column(
              children: [
                const Text(
                  '02:45', // مؤقت المعركة
                  style: TextStyle(color: Colors.redAccent, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$host1Score نقطة', style: const TextStyle(color: Colors.purpleAccent, fontWeight: FontWeight.bold)),
                    const Text('VS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('$host2Score نقطة', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 6),
                // شريط التقدم بين الطرفين
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: host1Score / (host1Score + host2Score),
                    backgroundColor: Colors.amber,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                    minHeight: 10,
                  ),
                ),
              ],
            ),
          ),

          // تقسيم الشاشة بين المذيعين
          Expanded(
            child: Row(
              children: [
                // المذيع الأول
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade900,
                      border: Border.all(color: Colors.purpleAccent, width: 1),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, size: 60, color: Colors.white),
                          SizedBox(height: 8),
                          Text('المذيع أحمد', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                // المذيع الثاني
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade900,
                      border: Border.all(color: Colors.amber, width: 1),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, size: 60, color: Colors.white),
                          SizedBox(height: 8),
                          Text('المذيع الضيف', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
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
