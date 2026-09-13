import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0716),
      appBar: AppBar(
        backgroundColor: const Color(0xFF130B22),
        elevation: 0,
        title: const Text(
          'الملف الشخصي الفاخر 🌟',
          style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('فتح إعدادات الحساب المتقدمة... ⚙️')),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF130B22), Color(0xFF0B0716), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // 1. كارد البروفايل والمعلومات الأساسية
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const耑 const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.amberAccent, width: 2.5),
                        ),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.purple,
                          child: Icon(Icons.person, size: 50, color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.verified, color: Colors.black, size: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Dodi Star (أحمد)',
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'ID: 88492019',
                    style: TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.purpleAccent.withOpacity(0.4)),
                    ),
                    child: const Text(
                      'المستوى: VIP نجم ذهبي 👑',
                      style: TextStyle(color: Colors.amberAccent, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 2. إحصائيات الحساب (المتابعين، المعجبين، الهدايا)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('1.4M', 'المتابعين'),
                _buildStatItem('350K', 'المعجبون'),
                _buildStatItem('8.9M', 'الألماس المستلم'),
              ],
            ),
            const SizedBox(height: 35),

            // 3. قوائم الإعدادات والخيارات الفخمة
            const Text(
              'إدارة الحساب',
              style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildMenuItem(Icons.live_tv_rounded, 'سجل البثوث السابقة', () {}),
            _buildMenuItem(Icons.card_giftcard_rounded, 'هدايايي المفضلة', () {}),
            _buildMenuItem(Icons.security_rounded, 'الأمان والخصوصية', () {}),
            _buildMenuItem(Icons.headset_mic_rounded, 'الدعم الفني والشكاوى', () {}),
            _buildMenuItem(Icons.logout_rounded, 'تسجيل الخروج', () {}, isRed: true),
          ],
        ),
      ),
    );
  }

  // ودجت إحصائيات الحساب
  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }

  // ودجت عناصر القائمة
  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool isRed = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white10),
      ),
      child: ListTile(
        leading: Icon(icon, color: isRed ? Colors.redAccent : Colors.amberAccent),
        title: Text(
          title,
          style: TextStyle(color: isRed ? Colors.redAccent : Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 16),
        onTap: onTap,
      ),
    );
  }
}
