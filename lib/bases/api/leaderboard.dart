import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rpgl/bases/webservice.dart';

class LeaderBoard {
  String? processSts;
  String? processMsg;
  String? leaderboardImage;
  String? leaderboardWeblink;
  LeaderboardDetails? leaderboardDetails;

  LeaderBoard(
      {this.processSts,
      this.processMsg,
      this.leaderboardImage,
      this.leaderboardWeblink,
      this.leaderboardDetails});

  LeaderBoard.fromJson(Map<String, dynamic> json) {
    processSts = json['process_sts'];
    processMsg = json['process_msg'];
    leaderboardImage = json['leaderboard_image'];
    leaderboardWeblink = json['leaderboard_weblink'];
    leaderboardDetails = json['leaderboard_details'] != null
        ? LeaderboardDetails.fromJson(json['leaderboard_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['process_sts'] = processSts;
    data['process_msg'] = processMsg;
    data['leaderboard_image'] = leaderboardImage;
    data['leaderboard_weblink'] = leaderboardWeblink;
    if (leaderboardDetails != null) {
      data['leaderboard_details'] = leaderboardDetails!.toJson();
    }
    return data;
  }

  static Future<LeaderBoard> leaderboardlist() async {
    Uri url = Uri.parse("${Webservice.rootURL}${Webservice.leaderboard}");
    final request = http.MultipartRequest('POST', url);
    print(url);
    request.fields.addAll({'leagueid': Webservice.appNickname});

    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    return LeaderBoard.fromJson(jsonDecode(responseString));
  }
}

class LeaderboardDetails {
  Map<String, List<Group>> groups = {};

  LeaderboardDetails({required this.groups});

  LeaderboardDetails.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      if (value is List) {
        groups[key] = value.map((v) => Group.fromJson(v)).toList();
      }
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    groups.forEach((key, value) {
      data[key] = value.map((v) => v.toJson()).toList();
    });
    return data;
  }
}

class Group {
  dynamic id;
  dynamic team;
  dynamic group;
  dynamic played;
  dynamic won;
  dynamic lost;
  dynamic noresult;
  dynamic points;
  dynamic netDifference;
  dynamic teamImage;
  dynamic tb1;
  dynamic tb2;
  dynamic teamgroup;

  Group(
      {this.id,
      this.team,
      this.group,
      this.played,
      this.won,
      this.lost,
      this.noresult,
      this.points,
      this.netDifference,
      this.teamImage,
      this.tb1,
      this.tb2,
      this.teamgroup});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    team = json['team'];
    group = json['group'];
    played = json['played'];
    won = json['won'];
    lost = json['lost'];
    noresult = json['noresult'];
    points = json['points'];
    netDifference = json['net_difference'];
    teamImage = json['team_image'];
    tb1 = json['tb1'];
    tb2 = json['tb2'];
    teamgroup = json['teamgroup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team'] = team;
    data['group'] = group;
    data['played'] = played;
    data['won'] = won;
    data['lost'] = lost;
    data['noresult'] = noresult;
    data['points'] = points;
    data['net_difference'] = netDifference;
    data['team_image'] = teamImage;
    data['tb1'] = tb1;
    data['tb2'] = tb2;
    data['teamgroup'] = teamgroup;
    return data;
  }
}
