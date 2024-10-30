import 'package:flutter/material.dart';
import 'package:rpgl/bases/themes.dart';
import 'package:rpgl/screens/leaderboard_screen.dart';
import 'package:rpgl/screens/login_screen.dart';
import 'package:rpgl/screens/ownersRoom_screen.dart';
import 'package:rpgl/screens/result_screen.dart';
import 'package:rpgl/screens/schedule_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final String sponsorImageUrl;

  const CustomBottomNavigationBar({super.key, required this.sponsorImageUrl});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 60.0,
          decoration: BoxDecoration(
            color: AppThemes.getBackground(),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(
                context,
                Icons.bar_chart,
                'Leaderboard',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LeaderboardScreen(
                      sponsorImageUrl: widget.sponsorImageUrl,
                    ),
                  ),
                ),
              ),
              buildNavItem(
                context,
                Icons.calendar_month,
                'Schedule',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScheduleScreen(),
                  ),
                ),
              ),
              buildNavItem(
                context,
                Icons.star,
                'Result',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(),
                  ),
                ),
              ),
              buildNavItem(
                context,
                Icons.person,
                "Captain's Room",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(
                      isFromLogin: true,
                    ),
                  ),
                ),
              ),
            ].map((item) {
              return Expanded(child: item);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          icon: Column(
            children: [
              Icon(icon, color: Colors.white),
              Text(
                label,
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
