import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TextToSpeakScreen extends StatefulWidget {
  const TextToSpeakScreen({required Key key}) : super(key: key);

  @override
  State<TextToSpeakScreen> createState() => _TextToSpeakScreenState();
}

class _TextToSpeakScreenState extends State<TextToSpeakScreen> {
  TextEditingController textController = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  bool isPlaying = false;

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(0.8);
    await flutterTts.speak(text);
    await flutterTts.awaitSpeakCompletion(true);
    setState(() {
      isPlaying = false;
    });
  }

  stop() async {
    await flutterTts.stop();
  }

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
                      text: "Type, ",
                      style: GoogleFonts.poppins(
                          color: Theme.of(context).primaryColorLight)),
                  TextSpan(
                      text: "we speak",
                      style: GoogleFonts.poppins(
                          color: Theme.of(context).primaryColor)),
                ]
            )
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Card(
                color: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: textController,
                    maxLines: 18, //or null
                    decoration: const InputDecoration.collapsed(hintText: "Enter your text here"),
                  ),
                )
            ),
            ElevatedButton(
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
                isPlaying ? stop() : speak(textController.text);
                setState( () {
                  isPlaying = !isPlaying;
                });
              },
              child: !isPlaying
                  ? const Text(
                  "🔊 Read out")
                  : const Text(
                  "🛑 Stop"),
            ),
          ],
        )
      ),
    );
  }
}
