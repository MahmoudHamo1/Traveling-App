import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class ZegoLiveStreamPage extends StatefulWidget {
  final bool isHost;
  final String liveId;
  final String userName;
  final String userId;

  const ZegoLiveStreamPage({required Key key, required this.isHost, required this.liveId, required this.userName, required this.userId}) : super(key: key);

  @override
  State<ZegoLiveStreamPage> createState() => _ZegoLiveStreamPageState();
}

class _ZegoLiveStreamPageState extends State<ZegoLiveStreamPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: 1196654629,
        appSign: 'c25e9c994a7601e3b0cfe48863fa72f7d518e39de93a8b003d0337d60189b68e',
        userID: widget.userId, // userID should only contain numbers, English characters and  '_'
        userName: widget.userName,
        liveID: widget.liveId,
        config: widget.isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
      ),
    );
  }
}
