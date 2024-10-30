import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rpgl/screens/livescoring_screen.dart';

class ScoreCarousel extends StatefulWidget {
  final List<String> scoreImages;
  final List<String> scoreLinks;

  const ScoreCarousel({
    Key? key,
    required this.scoreImages,
    required this.scoreLinks,
  }) : super(key: key);

  @override
  _ScoreCarouselState createState() => _ScoreCarouselState();
}

class _ScoreCarouselState extends State<ScoreCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoRotation();
  }

  void _startAutoRotation() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.toInt() + 1;
        if (nextPage >= widget.scoreImages.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: PageView.builder(
          itemCount: widget.scoreImages.length,
          controller: _pageController,
          itemBuilder: (context, index) {
            final imageUrl = widget.scoreImages[index];
            final linkUrl =
                widget.scoreLinks.isNotEmpty ? widget.scoreLinks[index] : '';
            return GestureDetector(
              onTap: () {
                if (linkUrl.isNotEmpty) {
                  // Handle link opening
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LiveScoringScreen(
                        // builder: (context) => SquadScreen(
                        url: linkUrl,
                      ),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      Image.network(
                        imageUrl,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[300],
                          child: const Center(child: Icon(Icons.error)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.5),
                              Colors.transparent
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Text(
                          'Live Score',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'LIVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
