import 'package:flutter/material.dart';
import 'package:rpgl/widgets/CustomWebView.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlayAlongScreen extends StatelessWidget {
  final member_id;
  const PlayAlongScreen({super.key, required this.member_id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Play Along',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: CustomWebView(
        initialUrl:
            'https://sports.forcempower.com/auth/play_along.php?member_id=${member_id}',
      ),
    );
  }
}
