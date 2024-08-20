import 'package:flutter/material.dart';
import 'package:rpgl/bases/themes.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String selectedOption = 'Top Players';
  String performanceOption = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildOptionButton('Top Players'),
                    _buildOptionButton('Top Pairs'),
                    _buildOptionButton('Overall Performance'),
                  ],
                ),
              ),
            ),
            // const SizedBox(height: 20),
            // Text(
            //   'Selected Option: $selectedOption',
            //   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 20),
            if (selectedOption == 'Top Players') TopPlayersSection(),
            if (selectedOption == 'Top Pairs') TopPairsSection(),
            if (selectedOption == 'Overall Performance')
              OverallPerformanceSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String option) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            selectedOption = option;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedOption == option
              ? AppThemes.getBackground()
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
        ),
        child: Text(
          option,
          style: TextStyle(
            color: selectedOption == option
                ? Colors.white
                : AppThemes.getBackground(),
          ),
        ),
      ),
    );
  }
}

class TopPlayersSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8.0, // Increase shadow elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align items to start
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(16.0), // Rounded corners for image
                  child: Container(
                    width: double.infinity,
                    height: 300, // Adjusted height for better aspect ratio
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueAccent,
                          Colors.purpleAccent
                        ], // Gradient background
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      image: DecorationImage(
                        image: AssetImage('assets/images/bg_esplash.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black
                              .withOpacity(0.3), // Overlay for better contrast
                          BlendMode.darken,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Player Name',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  'Position: 1',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(height: 8),
                Text(
                  'Won: 10/10',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),
        ));
  }
}

class TopPairsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(5, (index) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation:
                  12.0, // Increased shadow elevation for a more pronounced effect
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(24.0), // More rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Row(
                      children: [
                        // First player image
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                16.0), // Rounded corners for images
                            child: Image.asset(
                              'assets/images/bg_splash.jpg',
                              height: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors
                                      .grey[300], // Background color for error
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 30, // Icon size
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 8), // Reduced space between images
                        // Second player image
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                16.0), // Rounded corners for images
                            child: Image.asset(
                              'assets/images/bg_splash.jpg',
                              height: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors
                                      .grey[300], // Background color for error
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 30, // Icon size
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Pair Name ${index + 1} & ${index + 2}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        letterSpacing:
                            1.2, // Added letter spacing for a modern look
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Position: ${index + 1}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Matches Won: ${20 - index}',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      }),
    );
  }
}

class OverallPerformanceSection extends StatefulWidget {
  @override
  _OverallPerformanceSectionState createState() =>
      _OverallPerformanceSectionState();
}

class _OverallPerformanceSectionState extends State<OverallPerformanceSection> {
  String dropdownValue = 'Option 1';
  String selectedView = 'Player-wise';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: dropdownValue,
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>['Option 1', 'Option 2', 'Option 3']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black87,
          ),
          iconSize: 24,
          underline: Container(
            height: 2,
            color: AppThemes.getBackground(),
          ),
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          dropdownColor: Colors.white,
          elevation: 8,
          borderRadius: BorderRadius.circular(12.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedView = 'Player-wise';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedView == 'Player-wise'
                    ? AppThemes.getBackground()
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              child: Text(
                'Player-wise',
                style: TextStyle(
                    color: selectedView == 'Player-wise'
                        ? Colors.white
                        : AppThemes.getBackground()),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedView = 'Team-wise';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedView == 'Team-wise'
                    ? AppThemes.getBackground()
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
              child: Text(
                'Team-wise',
                style: TextStyle(
                    color: selectedView == 'Team-wise'
                        ? Colors.white
                        : AppThemes.getBackground()),
              ),
            ),
          ],
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/team${index + 1}.jpg'),
                ),
                title: Text('Name $index'),
                subtitle: Text('Team Name $index\nPosition: ${index + 1}'),
                trailing: CircleAvatar(
                  child: Text('${100 - index}'),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
