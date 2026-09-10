import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💰 المحفظة والرصيد', style: TextStyle(fontSize: 14)),
        backgroundColor: const Color(0xFF1A0B36),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF3B1863), Color(0xFF1A0B36)]),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.withOpacity(0.5)),
              ),
              child: Column(
                children: const [
                  Text('🪙 رصيد العملات الحالي', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  SizedBox(height: 5),
                  Text('4', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.amber)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A1B4E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('42,500 Coins', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text('\$0.99', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A1B4E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('425,000 Coins', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text('\$9.99', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
