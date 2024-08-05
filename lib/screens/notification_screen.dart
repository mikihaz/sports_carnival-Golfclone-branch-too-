import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: 10, // Replace with the actual count of notifications
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey[300],
            thickness: 1,
          ),
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(
                Icons.notifications,
                color: Colors.blueAccent,
                size: 30,
              ),
              title: Text(
                'Notification Title $index',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                'This is the description for notification $index. It provides more details about the notification.',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.0),
              onTap: () {
                // Handle notification tap
              },
            );
          },
        ),
      ),
    );
  }
}
