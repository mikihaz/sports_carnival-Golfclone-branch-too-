import 'package:flutter/material.dart';
import 'package:rpgl/bases/api/bannerImage.dart';
import 'package:rpgl/bases/api/homescreen.dart'; // Import the API file
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
  String? leagueName; // Variable to store data from the API
  String? homescreensponsor; // Variable to store data from the API
  String? leaderboardsponsor; // Variable to store data from the API

  @override
  void initState() {
    super.initState();
    _fetchBannerImage();
    _fetchHomeScreenData(); // Fetch data from the homescreenlist API
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

  Future<void> _fetchHomeScreenData() async {
    // try {
    HomescreenAPI response = await HomescreenAPI.homescreenlist();
    setState(() {
      leagueName = response.usernameExistStatus;
      homescreensponsor = response.homeScreenSideImage;
      leaderboardsponsor = response.leaderboardImage;
    });
    // } catch (e) {
    //   print("Error fetching home screen data: $e");
    // }
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
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey,
                        ),
                      )
                    : Container(
                        color: Colors.grey,
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
                      },
                      color: Colors.white,
                    ),
                    // IconButton(
                    //   icon: const Icon(Icons.power_settings_new),
                    //   onPressed: () {
                    //     // Handle power button press
                    //   },
                    //   color: Colors.white,
                    // ),
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the radius as needed
                      child: homescreensponsor != null &&
                              homescreensponsor!.isNotEmpty
                          ? Image.network(
                              homescreensponsor!,
                              height: 70,
                              width: 130,
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                height: 70,
                                width: 130,
                                color: Colors.grey,
                              ),
                            )
                          : Container(
                              height: 70,
                              width: 130,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 40,
              color: AppThemes.getBackground(),
              child: Center(
                child: Text(
                  leagueName ?? '', // Use leagueName variable here
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
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 80.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            child: leaderboardsponsor != null &&
                                    leaderboardsponsor!.isNotEmpty
                                ? Image.network(
                                    leaderboardsponsor!,
                                    height: 40,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      height: 40,
                                      width: double.infinity,
                                      color: Colors.grey,
                                    ),
                                  )
                                : Container(
                                    height: 40,
                                    width: double.infinity,
                                    color: Colors.grey,
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
      bottomNavigationBar: CustomBottomNavigationBar(
        sponsorImageUrl: leaderboardsponsor ?? '',
      ),
    );
  }
}
