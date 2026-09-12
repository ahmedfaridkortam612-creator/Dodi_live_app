import 'package:flutter/material.dart';
import 'wallet_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D061A),
      appBar: AppBar(
        title: const Text('الملف الشخصي (VIP)'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('الإعدادات قيد التطوير')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // صورة البروفايل واسم المستخدم الملكي
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.purpleAccent,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 15),
            const Text(
              'أحمد فريد (Ahmed Farid)',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'VIP 12 - أسطوري',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // بطاقات الإحصائيات (المستويات والألماس)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('مستوى الثراء', 'Lv. 12', Colors.amber),
                _buildStatCard('مستوى الجاذبية', 'Lv. 9', Colors.purpleAccent),
                // زرار سريع للانتقال للمحفظة عند الضغط على الكوينز
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WalletScreen()),
                    );
                  },
                  child: _buildStatCard('الكوينز', '4,500', Colors.tealAccent),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // القائمة الملكية
            _buildMenuItem(Icons.account_balance_wallet, 'محفظة الشحن والألماس', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WalletScreen()),
              );
            }),
            _buildMenuItem(Icons.star, 'شارات الشرف والألقاب', () {}),
            _buildMenuItem(Icons.card_giftcard, 'سجل الهدايا', () {}),
            _buildMenuItem(Icons.security, 'الأمان وكلمة المرور', () {}),
            _buildMenuItem(Icons.headset_mic, 'الدعم الفني', () {}),
          ],
        ),
      ),
    );
  }

  static Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: 100,
      decoration: BoxDecoration(
        color: const Color(0xFF150A33),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 11)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  static Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF150A33),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.purpleAccent),
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 14)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
        onTap: onTap,
      ),
    );
  }
}
