import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'gift_bottom_sheet.dart'; // استيراد ملف الهدايا اللي لسه عاملينه

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  static const String appId = "648a267e49184ca4bd518b790e990a97"; 
  static const String channel = "dodi_live_channel";
  static const String token = "";

  bool _localUserJoined = false;
  bool _isMuted = false;
  int _hostDiamonds = 1200000; // عداد الماس الخاص بالمضيف
  late RtcEngine _engine;

  final List<Map<String, String>> _liveMessages = [
    {'user': 'خالد النجار', 'text': 'منور البث يا بطل 🔥'},
    {'user': 'ياسمين', 'text': 'أحلى صوت وأجمل إضاءة 🌟'},
  ];

  @override
  void initState() {
    super.initState();
    _initAgoraEngine();
  }

  Future<void> _initAgoraEngine() async {
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            _localUserJoined = true;
          });
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  // دالة إظهار نافذة الهدايا ومعالجة إرسال الهدية
  void _openGiftBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return GiftBottomSheet(
          onGiftSelected: (giftName, giftPrice) {
            setState(() {
              _hostDiamonds += giftPrice; // زيادة الأرباح لحظياً
              _liveMessages.add({
                'user': 'نظام الهدايا 🎁',
                'text': 'أرسل هدية فاخرة: $giftName (💎 $giftPrice)'
              });
            });

            // تنبيه مرئي بإن الهدية وصلت بنجاح
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('تم إرسال $giftName بنجاح! 🔥'),
                backgroundColor: Colors.purple,
                duration: const Duration(seconds: 2),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0716),
      body: Stack(
        children: [
          // 1. كاميرا البث الحية في الخلفية
          Positioned.fill(
            child: _localUserJoined
                ? AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: _engine,
                      canvas: const VideoCanvas(uid: 0),
                    ),
                  )
                : Container(
                    color: const Color(0xFF130B22),
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.amberAccent),
                    ),
                  ),
          ),

          // 2. تدرج لوني خفيف لضمان وضوح النصوص
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // 3. شريط المعلومات العلوي (البروفايل، الأرباح المتحدثة، زر الخروج)
          Positioned(
            top: 45,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.amberAccent.withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.amber,
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Dodi Star', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                          Text('الماس: $_hostDiamonds', style: const TextStyle(color: Colors.amberAccent, fontSize: 10)),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('متابعة', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded, color: Colors.white, size: 26),
                  style: IconButton.styleFrom(backgroundColor: Colors.black.withOpacity(0.4)),
                ),
              ],
            ),
          ),

          // 4. مقاعد الضيوف والمايكات المتعددة
          Positioned(
            top: 115,
            left: 16,
            right: 16,
            child: SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    width: 60,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.5),
                      border: Border.all(color: Colors.purpleAccent, width: 1.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.mic_off, color: Colors.white54, size: 20),
                        const SizedBox(height: 2),
                        Text('مقعد ${index + 1}', style: const TextStyle(color: Colors.white70, fontSize: 9)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // 5. شاشة الشات والرسائل التفاعلية (بما فيها رسائل الهدايا اللحظية)
          Positioned(
            bottom: 80,
            left: 16,
            right: 100,
            child: SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: _liveMessages.length,
                itemBuilder: (context, index) {
                  final msg = _liveMessages[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${msg['user']}: ',
                            style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          TextSpan(
                            text: msg['text'],
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // 6. شريط التحكم السفلي (زر الهدية دلوقتي بيربط النافذة الحية)
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Text('قل شيئاً لطيفاً...', style: TextStyle(color: Colors.white54, fontSize: 13)),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => setState(() => _isMuted = !_isMuted),
                  icon: Icon(_isMuted ? Icons.mic_off : Icons.mic, color: Colors.white),
                  style: IconButton.styleFrom(backgroundColor: Colors.black.withOpacity(0.5)),
                ),
                IconButton(
                  onPressed: () => _engine.switchCamera(),
                  icon: const Icon(Icons.cameraswitch_rounded, color: Colors.white),
                  style: IconButton.styleFrom(backgroundColor: Colors.black.withOpacity(0.5)),
                ),
                // زر الهدية الفخم المرتبط بالنافذة الحية
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [Colors.amber, Colors.deepOrange]),
                  ),
                  child: IconButton(
                    onPressed: _openGiftBottomSheet, // فتح لستة الهدايا الحية
                    icon: const Icon(Icons.card_giftcard, color: Colors.black),
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
