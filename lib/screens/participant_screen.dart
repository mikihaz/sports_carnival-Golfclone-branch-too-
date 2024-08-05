import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String teamImage; // This can be a file path or URL
  final String participantImage; // This can be a file path or URL

  const ProfilePage(
      {super.key, required this.teamImage, required this.participantImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // AppBar with cover photo
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double top = constraints.biggest.height;
                bool isCollapsed = top < 91.0;

                return Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none, // Allow overflow of the avatar
                  children: <Widget>[
                    FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            teamImage, // Replace with your cover photo URL
                            fit: BoxFit.cover,
                          ),
                          Container(
                            color: Colors.black
                                .withOpacity(0.5), // Black overlay with opacity
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: isCollapsed ? 60.0 : top - 60.0,
                      left: isCollapsed
                          ? MediaQuery.of(context).size.width / 2 - 50
                          : 16.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            _createPageRoute(FullScreenImage(
                              imageUrl: participantImage,
                            )),
                          );
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                participantImage), // Replace with participant image URL
                          ),
                        ),
                      ),
                    ),
                    if (isCollapsed)
                      Positioned(
                        top: 130.0,
                        left: MediaQuery.of(context).size.width / 2 - 60,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: isCollapsed ? 1.0 : 0.0,
                          child: Text(
                            'Person Name', // Replace with the person's name
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 60), // Space for profile image
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Person Name', // Replace with the person's name
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            onPressed: () {
                              // Button 1 action
                            },
                            child: Text(
                              'Button 1',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(width: 16), // Space between buttons
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            onPressed: () {
                              // Button 2 action
                            },
                            child: Text(
                              'Button 2',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 20),
                    ],
                  ),
                ),
                // List of sports events (won/lost)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10, // Replace with your item count
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Event ${index + 1}', // Replace with event title
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Description of the event won or lost.', // Replace with event description
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Custom Page Route with transition animation
  PageRouteBuilder _createPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        title: Text(
          'Profile Image',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1, // Adjust the aspect ratio as needed
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
