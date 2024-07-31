import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorScreen extends StatelessWidget {
  final List<Sponsor> sponsors = List.generate(
    20,
    (index) => Sponsor(
      name: 'Forcepower',
      message: 'App Parter',
      image:
          'assets/images/sponsor.png', // Replace with your sponsor image path
      url: 'https://www.sponsorwebsite.com', // Replace with the sponsor URL
    ),
  );

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
        title: const Text('Sponsors & Partners',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 3 / 4,
          ),
          itemCount: sponsors.length,
          itemBuilder: (context, index) {
            return SponsorCard(sponsor: sponsors[index]);
          },
        ),
      ),
    );
  }
}

class SponsorCard extends StatelessWidget {
  final Sponsor sponsor;

  SponsorCard({required this.sponsor});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: () async {
          if (await canLaunch(sponsor.url)) {
            await launch(sponsor.url);
          } else {
            throw 'Could not launch ${sponsor.url}';
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  sponsor.image,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                sponsor.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 8),
              Text(
                sponsor.message,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Sponsor {
  final String name;
  final String message;
  final String image;
  final String url;

  Sponsor({
    required this.name,
    required this.message,
    required this.image,
    required this.url,
  });
}
