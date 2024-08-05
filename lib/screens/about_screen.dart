import 'package:flutter/material.dart';
import 'package:rpgl/widgets/CustomWebView.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset('assets/images/aboutphoto.jpg'),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300, // Adjust the height as needed
                child: CustomWebView(
                  initialUrl:
                      'https://birdie.forcempower.com/about_details/about.php?leagueid=leagueid&username=',
                ),
              ),
              // const SizedBox(height: 16),
              // const Text(
              //   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              //   'Sed ut perspiciatis unde omnis iste natus error sit voluptatem '
              //   'accusantium doloremque laudantium, totam rem aperiam, eaque ipsa '
              //   'quae ab illo inventore veritatis et quasi architecto beatae vitae '
              //   'dicta sunt explicabo.',
              //   style: TextStyle(fontSize: 16, height: 1.5),
              // ),
              // const SizedBox(height: 16),
              // Center(
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.red,
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 32.0, vertical: 12.0),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12.0),
              //       ),
              //     ),
              //     child: const Text('Delete Account',
              //         style: TextStyle(fontSize: 16, color: Colors.white)),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
