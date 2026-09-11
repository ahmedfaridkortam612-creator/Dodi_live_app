import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  // رصيد الكوينز المبدئي للمستخدم
  int _userCoins = 1250;

  void _rechargeCoins(int amount, double price) {
    setState(() {
      _userCoins += amount;
    });

    // إرسال تنبيه نجاح الشحن
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم شحن $amount كوينز بنجاح مقابل \$$price! 🎉'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المحفظة والرصيد'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // كارت عرض الرصيد الحالي
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.deepPurple, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'رصيد الكوينز الحالي',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.monetization_on, color: Colors.amber, size: 32),
                      const SizedBox(width: 8),
                      Text(
                        '$_userCoins',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'اختر باقة الشحن:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // باقات الشحن المتاحة
            Expanded(
              child: ListView(
                children: [
                  _buildRechargeCard('باقة المبتدئين', 1000, 0.99),
                  _buildRechargeCard('الباقة الذهبية', 5000, 4.99),
                  _buildRechargeCard('باقة الأساطير', 15000, 12.99),
                  _buildRechargeCard('باقة الملوك', 50000, 39.99),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRechargeCard(String title, int coins, double price) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF150A33),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: const Icon(Icons.diamond, color: Colors.purpleAccent, size: 36),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$coins كوينز',
          style: const TextStyle(color: Colors.amber),
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => _rechargeCoins(coins, price),
          child: Text('\$$price'),
        ),
      ),
    );
  }
}
