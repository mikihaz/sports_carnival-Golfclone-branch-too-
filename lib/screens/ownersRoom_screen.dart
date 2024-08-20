import 'package:flutter/material.dart';
import 'package:rpgl/bases/api/schedule.dart';
import 'package:rpgl/bases/api/showMyTeam.dart';
import 'package:rpgl/bases/themes.dart';
import 'package:rpgl/screens/assign_admin_screen.dart';
import 'package:rpgl/screens/home_screen.dart';
import 'package:rpgl/screens/login_screen.dart';
import 'package:rpgl/widgets/MatchCard.dart';
import 'package:url_launcher/url_launcher.dart';

class OwnersRoomScreen extends StatefulWidget {
  final String teamId; // This can be a file path or URL
  final String teamImage; // This can be a file path or URL
  final String teamName; // This can be a file path or URL
  final String ownerName; // This can be a file path or URL
  final String ownerid; // This can be a file path or URL
  final String ownerimage; // This can be a file path or URL

  const OwnersRoomScreen(
      {super.key,
      required this.teamId,
      required this.teamImage,
      required this.teamName,
      required this.ownerName,
      required this.ownerid,
      required this.ownerimage});
  @override
  _OwnersRoomScreenState createState() => _OwnersRoomScreenState();
}

class _OwnersRoomScreenState extends State<OwnersRoomScreen> {
  int _selectedIndex = 0;
  late Future<ShowMyTeamAPI> _teamFuture;

  final List<String> _buttons = ['My Team', 'Schedule', 'Results'];
  final List<String> _extraButtons = ['Make my pair', 'Play off Pair'];

  @override
  Widget build(BuildContext context) {
    void _handleLogout() {
      // Perform your logout logic here, such as clearing session data
      Navigator.of(context).pushReplacement(
        _createPageRoute(HomeScreen()), // Redirect to login screen after logout
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon:
                    const Icon(Icons.admin_panel_settings, color: Colors.white),
                onPressed: () {
                  // Navigate to assign admin screen
                  Navigator.push(
                    context,
                    _createPageRoute(AssignAdminScreen()),
                  );
                },
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert,
                    color: Colors.white), // Three-dot icon
                onSelected: (String result) {
                  if (result == 'logout') {
                    // Handle logout action
                    _handleLogout();
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Text('Logout'),
                  ),
                ],
              ),
            ],
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
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            widget
                                .teamImage, // Replace with your cover photo URL
                            fit: BoxFit.cover,
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: isCollapsed ? 60.0 : top - 60.0,
                      left: 16.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            _createPageRoute(FullScreenImage(
                              imageUrl: widget
                                  .ownerimage, // Replace with participant image URL
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
                            backgroundImage: NetworkImage(widget
                                .ownerimage), // Replace with participant image URL
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
                            widget.ownerName, // Replace with the person's name
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
                SizedBox(height: 80), // Space for profile image
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.ownerName, // Replace with the person's name
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.teamName, // Replace with the team name
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Modern Buttons Below Profile Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(_buttons.length, (index) {
                          return ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedIndex == index
                                  ? AppThemes.getBackground()
                                  : Colors.white,
                              foregroundColor: _selectedIndex == index
                                  ? Colors.white
                                  : AppThemes.getBackground(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 12.0),
                            ),
                            child: Text(_buttons[index]),
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(_extraButtons.length, (index) {
                          return ElevatedButton(
                            onPressed: () {
                              // Do nothing
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppThemes.getBackground(),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 12.0),
                            ),
                            child: Text(_extraButtons[index]),
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      // Dynamic Content Section
                      _buildContent(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildMyTeam(widget.teamId);
      case 1:
        return _buildSchedule(widget.teamId);
      case 2:
        return _buildResults(widget.teamId);
      default:
        return Container();
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch the team data when the widget is initialized
    _teamFuture = ShowMyTeamAPI.showmyteamlist(widget.teamId);
  }

  Widget _buildMyTeam(String teamId) {
    return FutureBuilder<ShowMyTeamAPI>(
      future: ShowMyTeamAPI.showmyteamlist(teamId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.black,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.memberData == null) {
          return Center(child: Text('No members found'));
        }

        final members = snapshot.data!.memberData!;

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];
            bool isAdmin = member.adminStatus == '1';

            return ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              leading: CircleAvatar(
                backgroundImage: member.participantImage != null
                    ? NetworkImage(member.participantImage!)
                    : AssetImage('assets/player.png') as ImageProvider,
              ),
              title: Text(
                member.memberName ?? 'Unknown Player',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text('Handicap: ${member.handicap ?? 'N/A'}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.mail),
                    onPressed: () {
                      _launchEmail(member.displayParticipantMobile);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.call),
                    onPressed: () {
                      _launchPhoneCall(member.displayParticipantMobile);
                    },
                  ),
                  // Checkbox(
                  //   value: isAdmin,
                  //   onChanged: (bool? value) {
                  //     if (value != null) {
                  //       setState(() {
                  //         isAdmin = value;
                  //         member.adminStatus = value ? '1' : '0';
                  //         // Implement any logic to update the status in the backend if needed
                  //       });
                  //     }
                  //   },
                  // ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _launchEmail(String? email) async {
    if (email != null && email.isNotEmpty) {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {
          'subject': 'Subject Example',
        },
      );
      if (await canLaunch(emailUri.toString())) {
        await launch(emailUri.toString());
      } else {
        throw 'Could not launch $emailUri';
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email is not available')),
      );
    }
  }

  void _launchPhoneCall(String? phoneNumber) async {
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      final Uri phoneUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      if (await canLaunch(phoneUri.toString())) {
        await launch(phoneUri.toString());
      } else {
        throw 'Could not launch $phoneUri';
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Phone number is not available')),
      );
    }
  }

  Widget _buildSchedule(String teamId) {
    return FutureBuilder<ScheduleAPI>(
      future: ScheduleAPI.matchlist(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.black));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ||
            snapshot.data!.scheduleAndResultsDetails == null) {
          return Center(child: Text('No matches found for the selected team.'));
        }

        List<Group> allMatches = [];
        snapshot.data!.scheduleAndResultsDetails!.groups?.forEach((key, value) {
          allMatches.addAll(value);
        });

        List<Group> matches = allMatches
            .where(
                (match) => match.team1Id == teamId || match.team2Id == teamId)
            .toList();

        if (matches.isEmpty) {
          return Center(child: Text('No matches found for the selected team.'));
        }

        return SingleChildScrollView(
          child: Column(
            children: matches.map((match) {
              return MatchCard(
                matchNo: match.id!,
                logoA: match.team1ImageUrl!,
                teamA: match.team1!,
                logoB: match.team2ImageUrl!,
                teamB: match.team2!,
                date: match.date!,
                time: match.time!,
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildResults(String teamId) {
    return FutureBuilder<ScheduleAPI>(
      future: ScheduleAPI.matchlist(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.black));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData ||
            snapshot.data!.scheduleAndResultsDetails == null) {
          return Center(child: Text('No matches found for the selected team.'));
        }

        List<Group> allMatches = [];
        snapshot.data!.scheduleAndResultsDetails!.groups?.forEach((key, value) {
          allMatches.addAll(value);
        });

        List<Group> matches = allMatches
            .where(
                (match) => match.team1Id == teamId || match.team2Id == teamId)
            .toList();

        if (matches.isEmpty) {
          return Center(child: Text('No matches found for the selected team.'));
        }

        return SingleChildScrollView(
          child: Column(
            children: matches.map((match) {
              return MatchCard(
                matchNo: match.id!,
                logoA: match.team1ImageUrl!,
                teamA: match.team1!,
                logoB: match.team2ImageUrl!,
                teamB: match.team2!,
                date: match.date!,
                time: match.time!,
                showResult: true,
                result: match.results ??
                    'No result available', // Provide a default value
              );
            }).toList(),
          ),
        );
      },
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
