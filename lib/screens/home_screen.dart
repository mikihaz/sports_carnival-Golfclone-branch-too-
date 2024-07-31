import 'package:flutter/material.dart';
import 'package:rpgl/widgets/BottomNavigationBar.dart';
import 'package:rpgl/widgets/StaticButtonGrid.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(150.0), // Increased height of AppBar
        child: AppBar(
          actions: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: const Icon(Icons.power_settings_new),
                onPressed: () {
                  // Handle power button press
                },
              ),
            ),
          ],
          flexibleSpace: Stack(
            children: [
              const Positioned.fill(
                child: Image(
                  image: AssetImage(
                    'assets/images/topbanner.jpg',
                  ), // Ensure this image exists in your assets
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Stack(
                      children: [
                        ClipPath(
                          clipper: InvertedSemiCircleClipper(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(
                                      0.8), // Increase opacity for a darker shadow
                                  blurRadius:
                                      50, // Increase blurRadius for a thicker shadow
                                  offset: const Offset(0,
                                      -20), // Negative offset to move shadow upwards
                                  spreadRadius:
                                      50, // Increase spreadRadius for a more prominent shadow
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: constraints.maxWidth *
                              0.1, // Adjust the position of the man
                          top: constraints.maxHeight *
                              0.5, // Adjust the position of the man
                          child: Image.asset(
                            'assets/images/man.gif', // Replace with the path to the image of the man
                            height: constraints.maxHeight *
                                0.5, // Adjust the size of the man
                          ),
                        ),
                        // Positioned(
                        //   right: constraints.maxWidth *
                        //       0.1, // Adjust the position of the golf ball
                        //   top: constraints.maxHeight *
                        //       0.5, // Adjust the position of the golf ball
                        //   child: Image.asset(
                        //     'assets/images/golf-ball.gif', // Replace with the path to the image of the golf ball
                        //     height: constraints.maxHeight *
                        //         0.3, // Adjust the size of the golf ball
                        //   ),
                        // ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          backgroundColor:
              Colors.transparent, // Make the AppBar background transparent
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
                      color: Colors.blueAccent,
                    ),
                    Container(
                      // color: Colors.white,
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
                      ), // Ensure this image exists in your assets
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 40,
              color: Colors.blueAccent,
              child: const Center(
                child: Text(
                  'Royal Premier Golf League 2023-24',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
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
                )),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar:
          CustomBottomNavigationBar(), // Custom bottom navigation bar
    );
  }
}

class InvertedSemiCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 100); // Move to the start point, adjusted to be higher
    path.quadraticBezierTo(
      size.width / 2, size.height, // Control point, adjusted to be higher
      size.width, size.height - 100, // End point, adjusted to be higher
    );

    path.lineTo(size.width, size.height); // Draw the right side
    path.lineTo(0, size.height); // Draw the bottom side
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
