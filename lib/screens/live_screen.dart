import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'live_seats_widget.dart';
import 'live_chat_widget.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  static const String appId = "648a267e49184ca4bd518b790e990a97"; 
  static const String channel = "dodi_live_channel";
  static const String token = "";

  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("Local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
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

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. كاميرا البث الحية
          Center(
            child: _localUserJoined
                ? AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: _engine,
                      canvas: const VideoCanvas(uid: 0),
                    ),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.amber),
                      SizedBox(height: 12),
                      Text(
                        'جاري فتح الكاميرا وبدء البث المباشر... 🎥',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
          ),
          
          // 2. الهيدر العلوي (اسم المضيف وزر الإغلاق)
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(radius: 15, backgroundColor: Colors.amber),
                      SizedBox(width: 8),
                      Text('Dodi Host 🌟', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // 3. شبكة الكراسي والمايكات (في منتصف/أعلى الشاشة)
          Positioned(
            top: 110,
            left: 10,
            right: 10,
            child: SizedBox(
              height: 140,
              child: LiveSeatsWidget(
                seatCount: 6,
                onSeatTap: (seatIndex) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('مقعد رقم ${seatIndex + 1} 🎤'),
                      duration: const Duration(milliseconds: 800),
                    ),
                  );
                },
              ),
            ),
          ),

          // 4. الشات الحي التفاعلي أسفل الشاشة
          const Positioned(
            bottom: 20,
            left: 10,
            right: 10,
            child: LiveChatWidget(),
          ),
        ],
      ),
    );
  }
}
