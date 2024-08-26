import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rpgl/bases/webservice.dart';

class ShowAllParticipantsAPI {
  String? processSts;
  String? processMsg;
  List<AllParticipantDetails>? allParticipantDetails;

  ShowAllParticipantsAPI(
      {this.processSts, this.processMsg, this.allParticipantDetails});

  ShowAllParticipantsAPI.fromJson(Map<String, dynamic> json) {
    processSts = json['process_sts'];
    processMsg = json['process_msg'];
    if (json['all_participant_details'] != null) {
      allParticipantDetails = <AllParticipantDetails>[];
      json['all_participant_details'].forEach((v) {
        allParticipantDetails!.add(new AllParticipantDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['process_sts'] = this.processSts;
    data['process_msg'] = this.processMsg;
    if (this.allParticipantDetails != null) {
      data['all_participant_details'] =
          this.allParticipantDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Future<ShowAllParticipantsAPI> leaderboardlist() async {
    Uri url = Uri.parse(
        "${Webservice.rootURL}${Webservice.show_all_participants_list}");
    final request = http.MultipartRequest('POST', url);
    print(url);
    request.fields.addAll({'leagueid': Webservice.appNickname});

    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    print('Response: $responseString'); // Print the response to debug

    return ShowAllParticipantsAPI.fromJson(jsonDecode(responseString));
  }
}

class AllParticipantDetails {
  String? id;
  String? participantName;
  String? team;
  String? teamId;
  String? handicap;
  String? participantImage;
  String? achievements;
  List<String>? sports;
  String? totalGames;
  String? groupName;

  AllParticipantDetails(
      {this.id,
      this.participantName,
      this.team,
      this.teamId,
      this.handicap,
      this.participantImage,
      this.achievements,
      this.sports,
      this.totalGames,
      this.groupName});

  AllParticipantDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    participantName = json['participant_name'];
    team = json['team'];
    teamId = json['team_id'];
    handicap = json['handicap'];
    participantImage = json['participant_image'];
    achievements = json['achievements'];
    sports = json['sports'].cast<String>();
    totalGames = json['total_games'];
    groupName = json['group_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['participant_name'] = this.participantName;
    data['team'] = this.team;
    data['team_id'] = this.teamId;
    data['handicap'] = this.handicap;
    data['participant_image'] = this.participantImage;
    data['achievements'] = this.achievements;
    data['sports'] = this.sports;
    data['total_games'] = this.totalGames;
    data['group_name'] = this.groupName;
    return data;
  }
}
