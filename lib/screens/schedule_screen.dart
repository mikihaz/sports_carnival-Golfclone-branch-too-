import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  final List<List<Map<String, String>>> matches = [
    [
      {
        'matchNo': '1',
        'teamA': 'Team A',
        'logoA': 'assets/images/teama.png',
        'teamB': 'Team B',
        'logoB': 'assets/images/teama.png',
        'date': '2024-07-20',
        'time': '18:00',
      },
    ],
    [
      {
        'matchNo': '2',
        'teamA': 'Team C',
        'logoA': 'assets/images/teama.png',
        'teamB': 'Team D',
        'logoB': 'assets/images/teama.png',
        'date': '2024-07-21',
        'time': '20:00',
      },
    ],
    [
      {
        'matchNo': '3',
        'teamA': 'Team E',
        'logoA': 'assets/images/teama.png',
        'teamB': 'Team F',
        'logoB': 'assets/images/teama.png',
        'date': '2024-07-22',
        'time': '16:00',
      },
    ],
    [
      {
        'matchNo': '4',
        'teamA': 'Team G',
        'logoA': 'assets/images/teama.png',
        'teamB': 'Team H',
        'logoB': 'assets/images/teama.png',
        'date': '2024-07-23',
        'time': '14:00',
      },
    ],
    [
      {
        'matchNo': '5',
        'teamA': 'Team I',
        'logoA': 'assets/images/teami.png',
        'teamB': 'Team J',
        'logoB': 'assets/images/teamj.png',
        'date': '2024-07-24',
        'time': '18:00',
      },
      {
        'matchNo': '6',
        'teamA': 'Team K',
        'logoA': 'assets/images/teamk.png',
        'teamB': 'Team L',
        'logoB': 'assets/images/teaml.png',
        'date': '2024-07-25',
        'time': '20:00',
      },
    ],
  ];

  final List<String> options = ['Green', 'Red', 'QF', 'Final', '3rd/4th'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Schedule', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              // Add your refresh logic here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: options.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                      _pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width / options.length,
                    decoration: BoxDecoration(
                      border: _selectedIndex == index
                          ? const Border(
                              bottom: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            )
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        options[index],
                        style: TextStyle(
                          color: _selectedIndex == index
                              ? Colors.blue
                              : Colors.black,
                          fontWeight: _selectedIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              itemCount: matches.length,
              itemBuilder: (context, index) {
                return ListView.builder(
                  itemCount: matches[index].length,
                  itemBuilder: (context, matchIndex) {
                    final match = matches[index][matchIndex];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                            ),
                            child: Text(
                              'Match No. ${match['matchNo']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Image.asset(
                                          match['logoA']!,
                                          width: 50,
                                          height: 50,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return CircleAvatar(
                                              radius: 25,
                                              backgroundColor: Colors.grey,
                                              child: Text(
                                                match['teamA']![0],
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          match['teamA']!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Text(
                                      'vs',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Column(
                                          children: [
                                            Image.asset(
                                              match['logoB']!,
                                              width: 50,
                                              height: 50,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return CircleAvatar(
                                                  radius: 25,
                                                  backgroundColor: Colors.grey,
                                                  child: Text(
                                                    match['teamB']![0],
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              match['teamB']!,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Date: ${match['date']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Time: ${match['time']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
