import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLiveActive = false;
  bool isMicOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F051D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A0B36),
        title: const Text('🎙️ Dodi Live Rooms', style: TextStyle(fontSize: 16, color: Colors.amber)),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on, color: Colors.amber),
            onPressed: () {
              // زر شحن الرصيد السريع
              _showRechargeSheet(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // لوحة التحكم السريعة لفتح البث أو الصوت
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3A1B6E), Color(0xFF1A0B36)],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.amber.withOpacity(0.5)),
              ),
              child: Column(
                children: [
                  const Text(
                    'أنشئ غرفتك الخاصة الآن وابدأ البث',
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            isLiveActive = !isLiveActive;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(isLiveActive ? 'تم تشغيل بث الفيديو بنجاح 📹' : 'تم إيقاف البث')),
                          );
                        },
                        icon: const Icon(Icons.videocam),
                        label: Text(isLiveActive ? 'إيقاف البث' : 'فتح لايف'),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isMicOpen = !isMicOpen;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(isMicOpen ? 'تم فتح المايك الصوتي 🎙️' : 'تم قفل المايك')),
                          );
                        },
                        icon: const Icon(Icons.mic),
                        label: Text(isMicOpen ? 'إغلاق المايك' : 'فتح صوتي'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            
            // قسم كراسي الغرفة الصوتية (Mic Seats كما في الصور)
            const Text(
              'منصة الغرفة النشطة (8 مايكات)',
              style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.8,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // إطار ذهبي للمايك
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.amber, width: 2),
                            color: const Color(0xFF2A1B4E),
                          ),
                          child: const Icon(Icons.person, color: Colors.white70),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.mic, size: 12, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'مقعد ${index + 1}',
                      style: const TextStyle(color: Colors.white60, fontSize: 11),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showRechargeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A0B36),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('شحن العملات والألماس 💎', style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.monetization_on, color: Colors.amber),
                title: const Text('10,000 كوينز', style: TextStyle(color: Colors.white)),
                trailing: const Text('\$9.99', style: TextStyle(color: Colors.greenAccent)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.monetization_on, color: Colors.amber),
                title: const Text('50,000 كوينز + هدية مجانية', style: TextStyle(color: Colors.white)),
                trailing: const Text('\$44.99', style: TextStyle(color: Colors.greenAccent)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
