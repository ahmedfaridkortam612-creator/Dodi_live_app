import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _userDiamonds = 1250;
  int _userGoldCoins = 45000;

  void _rechargePackage(String title, String price, int coins) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF140824),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.amberAccent, width: 1),
        ),
        title: const Text(
          'تأكيد شحن الباقة 💎',
          style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold),
        ),
        content: Text(
          'هل تريد إتمام عملية شراء ($title) مقابل $price؟',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(color: Colors.white38)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _userGoldCoins += coins;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('تم شحن $coins عملة ذهبية بنجاح! 🚀'),
                  backgroundColor: Colors.purple.shade900,
                ),
              );
            },
            child: const Text('دفع وتأكيد', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A0B2E),
        elevation: 0,
        title: const Text(
          'محفظة Dodi VIP 💰',
          style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.amberAccent),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1A0B2E),
              Color(0xFF0A0314),
              Color(0xFF000000),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // بطاقة الأرصدة الكبرى (الماس والذهب)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade900, Colors.black87],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.amberAccent.withOpacity(0.4), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amberAccent.withOpacity(0.1),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text('💎 أرباح الماس', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      const SizedBox(height: 8),
                      Text(
                        '$_userDiamonds',
                        style: const TextStyle(color: Colors.amberAccent, fontSize: 22, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.amberAccent),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('جاري تحويل أرباح الماس إلى سيولة نقدية... 💵')),
                          );
                        },
                        child: const Text('سحب الأرباح', style: TextStyle(color: Colors.amberAccent, fontSize: 11)),
                      ),
                    ],
                  ),
                  Container(height: 60, width: 1, color: Colors.white24),
                  Column(
                    children: [
                      const Text('🪙 رصيد العملات', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      const SizedBox(height: 8),
                      Text(
                        '$_userGoldCoins',
                        style: const TextStyle(color: Colors.amberAccent, fontSize: 22, fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'جاهزة للهدايا',
                        style: TextStyle(color: Colors.white38, fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'شحن باقات العملات الفاخرة (VIP)',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // شبكة باقات الشحن على طريقة المنصات الكبرى
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                _buildRechargeCard('باقة المبتدئين 🌟', '🪙 5,000', '4.99 \$', 5000),
                _buildRechargeCard('باقة النجوم ✨', '🪙 15,000', '12.99 \$', 15000),
                _buildRechargeCard('باقة الـ VIP 👑', '🪙 50,000', '39.99 \$', 50000),
                _buildRechargeCard('باقة الأساطير 🚀', '🪙 150,000', '99.99 \$', 150000),
              ],
            ),

            const SizedBox(height: 30),
            // سجل المعاملات المالية الأخيرة
            const Text(
              'سجل المعاملات الأخيرة',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildTransactionItem('شحن عبر Google Play / Apple', '+ 15,000 كوينز', 'منذ ساعة', Colors.greenAccent),
            _buildTransactionItem('إرسال هدية (تاج ملكي) لغرفة 884', '- 999 كوينز', 'منذ 3 ساعات', Colors.redAccent),
            _buildTransactionItem('سحب أرباح ماسية', 'تحويل ناجح 💵', 'أمس', Colors.amberAccent),
          ],
        ),
      ),
    );
  }

  Widget _buildRechargeCard(String title, String coins, String price, int coinValue) {
    return GestureDetector(
      onTap: () => _rechargePackage(title, price, coinValue),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(coins, style: const TextStyle(color: Colors.amberAccent, fontSize: 16, fontWeight: FontWeight.w900)),
            const SizedBox(height: 6),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(price, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(String title, String subtitle, String time, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(time, style: const TextStyle(color: Colors.white38, fontSize: 10)),
            ],
          ),
          Text(
            subtitle,
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
