import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rpgl/screens/teamandparticipant_screen.dart';

class TeamSplashScreen extends StatefulWidget {
  final String imageUrl; // This can be a file path or URL
  final String teamId; // This can be a file path or URL

  const TeamSplashScreen(
      {super.key, required this.imageUrl, required this.teamId});

  @override
  State<TeamSplashScreen> createState() => _TeamSplashScreenState();
}

class _TeamSplashScreenState extends State<TeamSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();

    _navigateToNextScreen();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _navigateToNextScreen() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Display splash for 2 seconds
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => TeamAndParticipantScreen(
                imageUrl: '${widget.imageUrl}',
                teamId: '${widget.teamId}',
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Make background transparent
      body: Stack(
        children: [
          // Semi-transparent overlay
          Container(
            color: Colors.white.withOpacity(0.5),
          ),
          // Centered logo with animation
          Center(
            child: Transform(
              transform: Matrix4.identity()
                ..rotateY(_animation.value * 8 * 3.14159) // Spin horizontally
                ..scale(_animation.value + 1), // Grow larger
              alignment: Alignment.center,
              child: widget.imageUrl.startsWith('http')
                  ? Image.network(
                      widget.imageUrl ?? '',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(widget.imageUrl),
                      width: 150,
                      height: 150,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
