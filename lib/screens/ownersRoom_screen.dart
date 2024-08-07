import 'package:flutter/material.dart';
import 'package:rpgl/bases/themes.dart';

class OwnersRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Owners Room',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User Profile Section
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
            ),
            const SizedBox(height: 16),
            // Grid of Buttons
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  final items = [
                    {'icon': Icons.group, 'name': 'My Team'},
                    {'icon': Icons.schedule, 'name': 'Schedule'},
                    {'icon': Icons.bar_chart, 'name': 'Results'},
                    {
                      'icon': Icons.link,
                      'name': 'Make My Pair'
                    }, // Update the icon accordingly
                    {
                      'icon': Icons.admin_panel_settings,
                      'name': 'Assign Admin'
                    },
                    {
                      'icon': Icons.play_circle_outline,
                      'name': 'Play Off Pair'
                    }, // Update the icon accordingly
                  ];
                  final item = items[index];
                  return _buildButton(
                      item['icon'] as IconData, item['name'] as String);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String name) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // Handle button tap
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: AppThemes.getBackground(),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppThemes.getBackground(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
