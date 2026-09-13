import 'package:flutter/material.dart';

class GiftBottomSheet extends StatelessWidget {
  final Function(String giftName, int giftPrice) onGiftSelected;

  const GiftBottomSheet({super.key, required.onGiftSelected});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> gifts = [
      {'name': 'وردة 🌹', 'price': 10, 'icon': '🌹'},
      {'name': 'خاتم ألماس 💍', 'price': 50, 'icon': '💍'},
      {'name': 'سيارة فارهة 🏎️', 'price': 200, 'icon': '🏎️'},
      {'name': 'أسد ملكي 🦁', 'price': 500, 'icon': '🦁'},
      {'name': 'صاروخ فضاء 🚀', 'price': 1000, 'icon': '🚀'},
      {'name': 'قلعة دودي 🏰', 'price': 5000, 'icon': '🏰'},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF130B22),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        border: Border(top: BorderSide(color: Colors.purpleAccent, width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'هدايا البث الفاخرة 🎁',
                style: TextStyle(color: Colors.amberAccent, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amberAccent.withOpacity(0.4)),
                ),
                child: const Text('الرصيد: 💎 1,450', style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gifts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              final gift = gifts[index];
              return GestureDetector(
                onTap: () {
                  onGiftSelected(gift['name'], gift['price']);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amberAccent.withOpacity(0.3)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(gift['icon'], style: const TextStyle(fontSize: 32)),
                      const SizedBox(height: 4),
                      Text(gift['name'], style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      Text('💎 ${gift['price']}', style: const TextStyle(color: Colors.amberAccent, fontSize: 10)),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
