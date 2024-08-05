import 'package:flutter/material.dart';
import 'package:rpgl/bases/api/bannerImage.dart';
import 'package:rpgl/bases/themes.dart';
import 'package:rpgl/screens/notification_screen.dart';
import 'package:rpgl/widgets/BottomNavigationBar.dart';
import 'package:rpgl/widgets/StaticButtonGrid.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? bannerImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchBannerImage();
  }

  Future<void> _fetchBannerImage() async {
    try {
      BannerImageAPI response = await BannerImageAPI.leaderboardlist();
      setState(() {
        bannerImageUrl = response.bannerImage;
      });
    } catch (e) {
      print("Error fetching banner image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              Positioned.fill(
                child: bannerImageUrl != null
                    ? Image.network(
                        bannerImageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/images/topbanner.jpg',
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/images/topbanner.jpg',
                        fit: BoxFit.cover,
                      ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 10,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationScreen()),
                        );
                        // Handle notifications
                      },
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: const Icon(Icons.power_settings_new),
                      onPressed: () {
                        // Handle power button press
                      },
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 40,
                      color: AppThemes.getBackground(),
                    ),
                    Container(
                      height: 35,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Image(
                      height: 70,
                      image: AssetImage(
                        'assets/images/Ballantines-Logo.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 40,
              color: AppThemes.getBackground(),
              child: const Center(
                child: Text(
                  'Royal Premier Golf League 2023-24',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            StaticButtonGrid(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            child: Image(
                              height: 40,
                              width: double.infinity,
                              image: AssetImage(
                                'assets/images/grantthonton.jpg',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text('No Ongoing Matches'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
