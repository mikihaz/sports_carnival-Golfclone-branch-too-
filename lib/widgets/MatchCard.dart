import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MatchCard extends StatelessWidget {
  final String matchNo;
  final String logoA;
  final String teamA;
  final String logoB;
  final String teamB;
  final String date;
  final String time;
  final bool showResult;
  final String? result;
  final String sportsName;

  const MatchCard({
    Key? key,
    required this.matchNo,
    required this.logoA,
    required this.teamA,
    required this.logoB,
    required this.teamB,
    required this.date,
    required this.time,
    required this.sportsName,
    this.showResult = false,
    this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = _formatDate(date);

    return InkWell(
      onTap: () {
        // Add any onTap functionality here for engagement
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with gradient background and match info
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Match No. $matchNo',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      sportsName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Team logos and VS in between
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: _buildTeamColumn(logoA, teamA)),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'VS',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(child: _buildTeamColumn(logoB, teamB)),
                ],
              ),
            ),
            // Date, Time, and Result section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 14, color: Colors.black54),
                          const SizedBox(width: 4),
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.access_time,
                              size: 14, color: Colors.black54),
                          const SizedBox(width: 4),
                          Text(
                            time,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (showResult && result != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.shade700,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Result: $result',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamColumn(String logo, String teamName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: logo.isNotEmpty ? NetworkImage(logo) : null,
            onBackgroundImageError: (_, __) => _buildPlaceholder(teamName),
            child: logo.isEmpty ? _buildPlaceholder(teamName) : null,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          teamName,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
          maxLines: 2, // Allows the text to wrap to a second line if necessary
          overflow:
              TextOverflow.visible, // Ensures wrapping instead of truncation
        ),
      ],
    );
  }

  Widget _buildPlaceholder(String teamName) {
    return CircleAvatar(
      radius: 28,
      backgroundColor: Colors.grey,
      child: Text(
        teamName.isNotEmpty ? teamName[0] : '?',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      final formatter = DateFormat('d MMM yyyy');
      return formatter.format(parsedDate);
    } catch (e) {
      print('Error formatting date: $e');
      return date;
    }
  }
}
