import 'package:flutter/material.dart';
import 'package:rpgl/bases/api/about.dart';
import 'package:rpgl/bases/themes.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  Future<AboutAPI>? _aboutDataFuture;

  @override
  void initState() {
    super.initState();
    _aboutDataFuture = AboutAPI.leaderboardlist();
  }

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
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(16.0),
              //   child: Image.asset('assets/images/aboutphoto.jpg'),
              // ),
              const SizedBox(height: 16),
              FutureBuilder<AboutAPI>(
                future: _aboutDataFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData ||
                      snapshot.data!.aboutData == null) {
                    return Center(child: Text('No data available'));
                  } else {
                    return Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.aboutData!.length,
                          itemBuilder: (context, index) {
                            final item = snapshot.data!.aboutData![index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title ?? 'No Title',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppThemes.getBackground(),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    item.description ?? 'No Description',
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.6,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  if (index !=
                                      snapshot.data!.aboutData!.length - 1)
                                    Divider(color: Colors.grey[100]),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
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
