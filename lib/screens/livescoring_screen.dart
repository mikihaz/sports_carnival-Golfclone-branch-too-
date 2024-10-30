import 'package:flutter/material.dart';
import 'package:rpgl/widgets/CustomWebView.dart';

class LiveScoringScreen extends StatefulWidget {
  final String url;
  LiveScoringScreen({super.key, required this.url});

  @override
  _LiveScoringScreenState createState() => _LiveScoringScreenState();
}

class _LiveScoringScreenState extends State<LiveScoringScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Light background for modern look
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar with back arrow
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black, size: 28),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            // Expanded WebView
            Expanded(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(20), // Rounded corners for WebView
                child: CustomWebView(initialUrl: widget.url),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
