import 'package:flutter/material.dart';
import 'package:rpgl/screens/leaderboard_screen.dart';
import 'package:rpgl/screens/schedule_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 60.0, // Reduced height for the BottomNavigationBar
          decoration: BoxDecoration(
            color: Colors.blueAccent,
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
                  MaterialPageRoute(builder: (context) => LeaderboardScreen()),
                ),
              ),
              buildNavItem(
                context,
                Icons.calendar_month,
                'Schedule',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScheduleScreen()),
                ),
              ),
              const SizedBox(width: 40), // Space for the middle item
              buildNavItem(
                context,
                Icons.star,
                'Result',
                () {},
              ),
              buildNavItem(
                context,
                Icons.person,
                "Owner's Room",
                () {},
              ),
            ],
          ),
        ),
        Center(
          heightFactor: 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.white,
                child: const Icon(Icons.sports_golf_rounded,
                    color: Colors.blueAccent),
                elevation: 8.0,
              ),
              const SizedBox(
                  height: 2), // Reduced spacing between icon and text
              const Text(
                "Scoreboard",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildNavItem(BuildContext context, IconData icon, String label,
      VoidCallback onPressed) {
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
