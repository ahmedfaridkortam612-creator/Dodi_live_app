import 'package:flutter/material.dart';

class LiveChatWidget extends StatelessWidget {
  const LiveChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة رسائل تجريبية للمتفاعلين في الغرفة
    final List<Map<String, String>> chatMessages = [
      {'user': 'محمود', 'message': 'منور البث يا أسد! 🔥'},
      {'user': 'سارة', 'message': 'أحلى بث والله Dodi Live 💜'},
      {'user': 'كريم', 'message': 'أرسلوا هدايا شباب انضموا للتحدي!'},
      {'user': 'منى', 'message': 'الجو العام فخم جداً ✨'},
    ];

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.builder(
        reverse: true, // عشان الرسائل الجديدة تظهر تحت زي التيك توك
        itemCount: chatMessages.length,
        itemBuilder: (context, index) {
          final msg = chatMessages[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${msg['user']}: ',
                    style: const TextStyle(
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  TextSpan(
                    text: msg['message'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
