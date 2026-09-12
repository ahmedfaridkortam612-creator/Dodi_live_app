import 'package:flutter/material.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  final List<Map<String, dynamic>> _messages = [
    {'user': 'أحمد كورتام', 'text': 'أنضم إلى البث المباشر الفاخر 💎', 'isVip': true},
    {'user': 'ساره', 'text': 'منور البث يا ملك الأساطير 👑', 'isVip': false},
    {'user': 'النظام', 'text': 'أرسل هدية ماسية لتفعيل التأثيرات العالمية ✨', 'isSystem': true},
  ];

  final TextEditingController _messageController = TextEditingController();
  int _totalDiamonds = 25480; // عداد الماس المتجمع في البث على طريقة ميكو وبجو

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          'user': 'أنت',
          'text': _messageController.text.trim(),
          'isVip': true,
        });
        _messageController.clear();
      });
    }
  }

  // نافذة إرسال الهدايا الفاخرة (نظام الـ Miko / Bigo)
  void _showGiftModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF140824),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'متجر هدايا Dodi Live الفاخرة 🎁',
                    style: TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'رصيدك: 💎 1,250',
                      style: TextStyle(color: Colors.amberAccent, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: [
                    _buildGiftCard('👑', 'تاج ملكي', '999'),
                    _buildGiftCard('🏎️', 'سوبر كار', '520'),
                    _buildGiftCard('💎', 'ألماس حر', '199'),
                    _buildGiftCard('🌹', 'وردة ذهبية', '50'),
                    _buildGiftCard('🚀', 'صاروخ فضاء', '1314'),
                    _buildGiftCard('🦁', 'أسد الغابة', '2999'),
                    _buildGiftCard('🏰', 'قلعة الأساطير', '5000'),
                    _buildGiftCard('🎉', 'احتفال خاص', '100'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGiftCard(String emoji, String name, String price) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _totalDiamonds += int.parse(price);
          _messages.add({
            'user': 'النظام',
            'text': 'أرسل هدية فاخرة ($name $emoji) ! شعلل البث 🔥',
            'isSystem': true,
          });
        });
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تم إرسال $name بنجاح! 🚀'),
            backgroundColor: Colors.purple.shade900,
            duration: const Duration(seconds: 1),
          ),
        );
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
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 4),
            Text(name, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text('💎 $price', style: const TextStyle(color: Colors.amberAccent, fontSize: 9)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1F0D3D),
              Color(0xFF0D041A),
              Color(0xFF000000),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // محاكاة خلفية فيديو البث المباشر مع تأثيرات سينمائية
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purpleAccent.withOpacity(0.2),
                          blurRadius: 60,
                          spreadRadius: 20,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.spatial_audio_off_rounded,
                      size: 70,
                      color: Colors.white24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'البث المباشر جاري الآن 🔴',
                    style: TextStyle(color: Colors.white38, fontSize: 13, letterSpacing: 1),
                  ),
                ],
              ),
            ),

            // 1. شريط المضيف العلوي على طريقة Miko و Bigo
            Positioned(
              top: 45,
              left: 12,
              right: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // بيانات المضيف
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.amberAccent.withOpacity(0.5)),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.amberAccent,
                          child: Icon(Icons.person, color: Colors.black, size: 20),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'أميرة Dodi VIP',
                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'ID: 884920',
                              style: TextStyle(color: Colors.white60, fontSize: 9),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text('متابعة', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),

                  // عداد الماس والخرج (Diamonds Counter)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.amber.withOpacity(0.4)),
                    ),
                    child: Row(
                      children: [
                        const Text('💎', style: TextStyle(fontSize: 14)),
                        const SizedBox(width: 4),
                        Text(
                          '$_totalDiamonds',
                          style: const TextStyle(color: Colors.amberAccent, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  // زر الخروج من البث
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white, size: 22),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // 2. مقاعد الميكروفون المتاحة في البث (المضيفين المشتركين - PK/Seats)
            Positioned(
              top: 110,
              left: 12,
              right: 12,
              child: SizedBox(
                height: 65,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildSeatItem('المضيف الأساسي', '👑', true),
                    _buildSeatItem('المقعد 1', '🎙️', false),
                    _buildSeatItem('المقعد 2', '➕', false),
                    _buildSeatItem('المقعد 3', '🔒', false),
                    _buildSeatItem('المقعد 4', '➕', false),
                  ],
                ),
              ),
            ),

            // 3. شات البث التفاعلي (المحادثة الحية)
            Positioned(
              bottom: 80,
              left: 12,
              right: 80,
              height: 200,
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: msg['isSystem'] == true 
                          ? Colors.amber.withOpacity(0.15) 
                          : Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                      border: msg['isSystem'] == true 
                          ? Border.all(color: Colors.amberAccent.withOpacity(0.3)) 
                          : null,
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${msg['user']}: ',
                            style: TextStyle(
                              color: msg['isVip'] == true ? Colors.amberAccent : Colors.purpleAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: '${msg['text']}',
                            style: const TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // 4. أزرار التفاعل السفلي (شات، هدايا، لايكات، وفعاليات)
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: _messageController,
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: InputDecoration(
                          hintText: 'قل شيئاً لطيفاً...',
                          hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.amberAccent),
                    onPressed: _sendMessage,
                  ),
                  // زر صندوق الحظ / الفعاليات
                  FloatingActionButton.small(
                    heroTag: "giftBtn",
                    backgroundColor: Colors.purple.shade700,
                    child: const Icon(Icons.card_giftcard_rounded, color: Colors.amberAccent),
                    onPressed: () => _showGiftModal(context),
                  ),
                  // زر التفاعل السريع (القلوب المتطايرة)
                  FloatingActionButton.small(
                    heroTag: "heartBtn",
                    backgroundColor: Colors.redAccent,
                    child: const Icon(Icons.favorite_rounded, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _totalDiamonds += 10;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('❤️ تم إرسال إعجاب للبث!'),
                          duration: Duration(milliseconds: 500),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatItem(String title, String iconOrEmoji, bool isActive) {
    return Container(
      width: 55,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? Colors.amberAccent : Colors.purpleAccent.withOpacity(0.3),
          width: isActive ? 1.5 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(iconOrEmoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 8),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
