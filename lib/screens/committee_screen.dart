import 'package:flutter/material.dart';
import 'package:rpgl/bases/api/committee.dart';
import 'package:rpgl/bases/themes.dart';
import 'package:rpgl/bases/webservice.dart'; // Import the necessary files
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class CommitteeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Committee',
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
      body: FutureBuilder<Committee>(
        future: CommitteeDetails.committeeList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          var tournamentCommittee =
              snapshot.data?.committeeDetails?.tournamentCommittee;
          var clubCommittee = snapshot.data?.committeeDetails?.clubCommittee;
          var sportsCommittee =
              snapshot.data?.committeeDetails?.sportsCommittee;

          return ListView(
            children: [
              if (tournamentCommittee != null && tournamentCommittee.isNotEmpty)
                CommitteeSection(
                  title: 'Tournament Committee',
                  members: tournamentCommittee,
                ),
              if (clubCommittee != null && clubCommittee.isNotEmpty)
                CommitteeSection(
                  title: 'Club Committee',
                  members: clubCommittee,
                ),
              if (sportsCommittee != null && sportsCommittee.isNotEmpty)
                CommitteeSection(
                  title: 'Sports Committee',
                  members: sportsCommittee,
                ),
            ],
          );
        },
      ),
    );
  }
}

class CommitteeSection extends StatelessWidget {
  final String title;
  final List<dynamic> members;

  CommitteeSection({required this.title, required this.members});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppThemes.getBackground(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
            ),
            itemCount: members.length,
            itemBuilder: (context, index) {
              var member = members[index];
              return CommitteeMember(
                name: member.name ?? 'No Name',
                designation: member.role ?? 'No Role',
                image: member.image ?? '',
                phoneNumber: member.phone ?? '',
                email: member.email ?? '',
              );
            },
          ),
        ),
      ],
    );
  }
}

class CommitteeMember extends StatelessWidget {
  final String name;
  final String designation;
  final String image;
  final String phoneNumber;
  final String email;

  CommitteeMember({
    required this.name,
    required this.designation,
    required this.image,
    required this.phoneNumber,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => FullScreenImage(
            image: image,
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shadowColor: AppThemes.getBackground(),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: image.isNotEmpty ? NetworkImage(image) : null,
                backgroundColor: Colors.grey,
                child: image.isEmpty ? const Text('No Image') : null,
              ),
              const SizedBox(height: 8.0),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Flexible(
                child: Text(
                  designation,
                  style: const TextStyle(
                    fontSize: 8,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      _makePhoneCall(phoneNumber);
                    },
                    icon: const Icon(Icons.call),
                    color: AppThemes.getBackground(),
                  ),
                  IconButton(
                    onPressed: () {
                      _sendEmail(email);
                    },
                    icon: const Icon(Icons.mail),
                    color: AppThemes.getBackground(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

void _sendEmail(String email) async {
  final Uri emailUri =
      Uri(scheme: 'mailto', path: email, queryParameters: {'subject': 'Hello'});
  await launchUrl(emailUri);
}

class FullScreenImage extends StatelessWidget {
  final String image;

  FullScreenImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: image.isNotEmpty
          ? GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            )
          : GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: const Text(
                  'No Image Available',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
            ),
    );
  }
}
