import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trawell/customer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'ZegoLiveSteamPage.dart';

class LiveBroadcastScreen extends StatefulWidget {
  const LiveBroadcastScreen({required Key key}) : super(key: key);

  @override
  State<LiveBroadcastScreen> createState() => _LiveBroadcastScreenState();
}

class _LiveBroadcastScreenState extends State<LiveBroadcastScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 7,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: RichText(
            text: TextSpan(
                style: GoogleFonts.poppins(
                    fontSize: 30, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: "Go ",
                      style: GoogleFonts.poppins(
                          color: Theme.of(context).primaryColorLight)),
                  TextSpan(
                      text: "Live",
                      style: GoogleFonts.poppins(
                          color: Theme.of(context).primaryColor)),
                ]
            )
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                            side: BorderSide(color: Theme.of(context).primaryColor)
                        )
                    )
                ),
                onPressed: () {
                  Customer customer = Customer();
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ZegoLiveStreamPage(isHost: true, userId: customer.id, userName: customer.name, liveId: customer.id, key: Key('ZegoLiveStreamPage1'),);
                  }));
                },
                child: const Text("Start Broadcasting"),
              ),
            )
          ],
        )
      ),
    );
  }
}
