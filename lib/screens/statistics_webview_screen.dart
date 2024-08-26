import 'package:flutter/material.dart';
import 'package:rpgl/widgets/CustomWebView.dart';

class StatisticsWebViewScreen extends StatelessWidget {
  final String url =
      'https://sports.forcempower.com/about_details/statistic_current_year.php';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: CustomWebView(initialUrl: url),
    );
  }
}
