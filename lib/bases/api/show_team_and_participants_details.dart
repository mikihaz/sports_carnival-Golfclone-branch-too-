import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rpgl/bases/webservice.dart';

class TeamsAndParticipantAPI {
  String? processSts;
  String? processMsg;
  TeamAndParticipantsDetails? teamAndParticipantsDetails;

  TeamsAndParticipantAPI(
      {this.processSts, this.processMsg, this.teamAndParticipantsDetails});

  TeamsAndParticipantAPI.fromJson(Map<String, dynamic> json) {
    processSts = json['process_sts'];
    processMsg = json['process_msg'];
    teamAndParticipantsDetails = json['team_and_participants_details'] != null
        ? TeamAndParticipantsDetails.fromJson(
            json['team_and_participants_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['process_sts'] = processSts;
    data['process_msg'] = processMsg;
    if (teamAndParticipantsDetails != null) {
      data['team_and_participants_details'] =
          teamAndParticipantsDetails!.toJson();
    }
    return data;
  }
}

class TeamAndParticipantsDetails {
  Map<String, List<Group>>? groups;

  TeamAndParticipantsDetails({this.groups});

  TeamAndParticipantsDetails.fromJson(Map<String, dynamic> json) {
    groups = {};
    json.forEach((key, value) {
      if (value is List) {
        groups![key] = value.map((v) => Group.fromJson(v)).toList();
      } else {
        // Handle the case where 'value' is not a List
        print('Unexpected value for key $key: $value');
      }
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    groups?.forEach((key, value) {
      data[key] = value.map((v) => v.toJson()).toList();
    });
    return data;
  }

  static Future<TeamAndParticipantsDetails> leaderboardlist() async {
    Uri url = Uri.parse(
        "${Webservice.rootURL}${Webservice.show_team_and_participants_details}");
    final request = http.MultipartRequest('POST', url);
    request.fields.addAll({'leagueid': Webservice.appNickname});
    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    print('Response: $responseString'); // Print the response to debug
    Map<String, dynamic> jsonResponse = jsonDecode(responseString);

    // Handle the case where the response is not as expected
    if (jsonResponse['team_and_participants_details'] != null &&
        jsonResponse['team_and_participants_details'] is Map) {
      print('Response: $response'); // Print the response to debug

      return TeamAndParticipantsDetails.fromJson(
          jsonResponse['team_and_participants_details']);
    } else {
      throw Exception('Unexpected response format');
    }
  }
}

class Group {
  String? id;
  String? team;
  String? group;
  String? handicap;
  String? teamgroup;
  String? image;
  String? owners;
  String? theImageLink;
  int? totalPlayedByTheTeam;
  String? theTeamPopupImageLink;
  List<ParticipantsList>? participantsList;

  Group(
      {this.id,
      this.team,
      this.group,
      this.handicap,
      this.teamgroup,
      this.image,
      this.owners,
      this.theImageLink,
      this.totalPlayedByTheTeam,
      this.theTeamPopupImageLink,
      this.participantsList});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    team = json['team'];
    group = json['group'];
    handicap = json['handicap'];
    teamgroup = json['teamgroup'];
    image = json['image'];
    owners = json['owners'];
    theImageLink = json['the_image_link'];
    totalPlayedByTheTeam = json['total_played_by_the_team'];
    theTeamPopupImageLink = json['the_team_popup_image_link'];
    if (json['participants_list'] != null) {
      participantsList = <ParticipantsList>[];
      json['participants_list'].forEach((v) {
        participantsList!.add(ParticipantsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['team'] = team;
    data['group'] = group;
    data['handicap'] = handicap;
    data['teamgroup'] = teamgroup;
    data['image'] = image;
    data['owners'] = owners;
    data['the_image_link'] = theImageLink;
    data['total_played_by_the_team'] = totalPlayedByTheTeam;
    data['the_team_popup_image_link'] = theTeamPopupImageLink;
    if (participantsList != null) {
      data['participants_list'] =
          participantsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ParticipantsList {
  String? participantId;
  String? participantName;
  String? participantHandicap;
  String? participantImage;
  String? colour;
  String? colourCode;
  int? totalPlayed;
  String? displayParticipantMobile;
  String? playerType;
  String? memberRank;
  String? totalPlayedText;

  ParticipantsList(
      {this.participantId,
      this.participantName,
      this.participantHandicap,
      this.participantImage,
      this.colour,
      this.colourCode,
      this.totalPlayed,
      this.displayParticipantMobile,
      this.playerType,
      this.memberRank,
      this.totalPlayedText});

  ParticipantsList.fromJson(Map<String, dynamic> json) {
    participantId = json['participant_id'];
    participantName = json['participant_name'];
    participantHandicap = json['participant_handicap'];
    participantImage = json['participant_image'];
    colour = json['colour'];
    colourCode = json['colour_code'];
    totalPlayed = json['total_played'];
    displayParticipantMobile = json['display_participant_mobile'];
    playerType = json['player_type'];
    memberRank = json['member_rank'];
    totalPlayedText = json['total_played_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['participant_id'] = participantId;
    data['participant_name'] = participantName;
    data['participant_handicap'] = participantHandicap;
    data['participant_image'] = participantImage;
    data['colour'] = colour;
    data['colour_code'] = colourCode;
    data['total_played'] = totalPlayed;
    data['display_participant_mobile'] = displayParticipantMobile;
    data['player_type'] = playerType;
    data['member_rank'] = memberRank;
    data['total_played_text'] = totalPlayedText;
    return data;
  }
}
