import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpeakNative extends StatefulWidget {
  const SpeakNative({required Key key}) : super(key: key);

  @override
  State<SpeakNative> createState() => _SpeakNativeState();
}

class _SpeakNativeState extends State<SpeakNative> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          const WebView(
            initialUrl: "https://translate.google.com/",
            javascriptMode: JavascriptMode.unrestricted,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              color: Colors.white,
              height: 110,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.only(left: 19),
                child: RichText(
                    text: TextSpan(
                        style: GoogleFonts.poppins(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: "Cant understand? ",
                              style: GoogleFonts.poppins(
                                  color: Theme.of(context).primaryColorLight)),
                          TextSpan(
                              text: "Translate",
                              style: GoogleFonts.poppins(
                                  color: Theme.of(context).primaryColor)),
                        ]
                    )
                ),
              )
            ),
          ),
        ]),
      ),
    );
  }
}
