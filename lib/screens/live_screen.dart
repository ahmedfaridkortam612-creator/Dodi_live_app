import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  // معرف تطبيق أجورا الخاص بك
  static const String appId = "648a267e49184ca4bd518b790e990a97";
  static const String channelName = "dodi_live_channel";
  static const String token = ""; // ضع الـ Token هنا إذا كان السيرفر مفعل

  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // طلب صلاحيات الكاميرا والمايكروفون من المستخدم
    await [Permission.microphone, Permission.camera].request();

    // إنشاء محرك أجورا
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
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    // الانضمام لقناة البث
    await _engine.joinChannel(
      token: token,
      channelId: channelName,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ),
      uid: 0,
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("غرفة البث المباشر - Dodi Live"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          // عرض كاميرا الضيف أو المتصل الآخر
          Center(
            child: _remoteUid != null
                ? AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: _engine,
                      canvas: VideoCanvas(uid: _remoteUid),
                      connection: const RtcConnection(channelId: channelName),
                    ),
                  )
                : const Text(
                    'في انتظار انضمام مذيع آخر للبث...',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
          ),
          // عرض كاميرتك الشخصية في زاوية الشاشة (صورة مصغرة)
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: 110,
                height: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _localUserJoined
                      ? AgoraVideoView(
                          controller: VideoViewController(
                            rtcEngine: _engine,
                            canvas: const VideoCanvas(uid: 0),
                          ),
                        )
                      : const Center(child: CircularProgressIndicator(color: Colors.purpleAccent)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
