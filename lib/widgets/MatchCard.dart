import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  final String matchNo;
  // final String matchName;
  final String logoA;
  final String teamA;
  final String logoB;
  final String teamB;
  final String date;
  final String time;

  const MatchCard({
    Key? key,
    required this.matchNo,
    // required this.matchName,
    required this.logoA,
    required this.teamA,
    required this.logoB,
    required this.teamB,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Match No. $matchNo',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // Text(
                //   matchName,
                //   style: const TextStyle(
                //     color: Colors.white,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 14,
                //   ),
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          logoA,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey,
                              child: Text(
                                teamA[0],
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
                          teamA,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/vs.webp',
                      width: 80,
                      height: 80,
                    ),
                    Column(
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              logoB,
                              width: 50,
                              height: 50,
                              errorBuilder: (context, error, stackTrace) {
                                return CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.grey,
                                  child: Text(
                                    teamB[0],
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
                              teamB,
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
                  date,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                Text(
                  time,
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
  }
}
