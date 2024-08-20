import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rpgl/bases/webservice.dart';

class ShowMyTeamAPI {
  String? processSts;
  String? processMsg;
  List<MemberData>? memberData;

  ShowMyTeamAPI({this.processSts, this.processMsg, this.memberData});

  ShowMyTeamAPI.fromJson(Map<String, dynamic> json) {
    processSts = json['process_sts'];
    processMsg = json['process_msg'];
    if (json['member_data'] != null) {
      memberData = <MemberData>[];
      json['member_data'].forEach((v) {
        memberData!.add(new MemberData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['process_sts'] = this.processSts;
    data['process_msg'] = this.processMsg;
    if (this.memberData != null) {
      data['member_data'] = this.memberData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Future<ShowMyTeamAPI> showmyteamlist(String teamid) async {
    Uri url = Uri.parse(
        "${Webservice.rootURL}${Webservice.sql_show_my_team_members_for_owner}");
    final request = http.MultipartRequest('POST', url);
    print(url);
    request.fields
        .addAll({'leagueid': Webservice.appNickname, 'team_id': teamid});

    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    return ShowMyTeamAPI.fromJson(jsonDecode(responseString));
  }
}

class MemberData {
  String? memberId;
  String? memberName;
  String? handicap;
  String? colour;
  String? colourCode;
  String? displayParticipantMobile;
  String? participantImage;
  String? teamName;
  String? teamImage;
  String? groupName;
  String? memberType;
  String? playing;
  String? adminStatus;

  MemberData(
      {this.memberId,
      this.memberName,
      this.handicap,
      this.colour,
      this.colourCode,
      this.displayParticipantMobile,
      this.participantImage,
      this.teamName,
      this.teamImage,
      this.groupName,
      this.memberType,
      this.playing,
      this.adminStatus});

  MemberData.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    memberName = json['member_name'];
    handicap = json['handicap'];
    colour = json['colour'];
    colourCode = json['colour_code'];
    displayParticipantMobile = json['display_participant_mobile'];
    participantImage = json['participant_image'];
    teamName = json['team_name'];
    teamImage = json['team_image'];
    groupName = json['group_name'];
    memberType = json['member_type'];
    playing = json['playing'];
    adminStatus = json['admin_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['member_id'] = this.memberId;
    data['member_name'] = this.memberName;
    data['handicap'] = this.handicap;
    data['colour'] = this.colour;
    data['colour_code'] = this.colourCode;
    data['display_participant_mobile'] = this.displayParticipantMobile;
    data['participant_image'] = this.participantImage;
    data['team_name'] = this.teamName;
    data['team_image'] = this.teamImage;
    data['group_name'] = this.groupName;
    data['member_type'] = this.memberType;
    data['playing'] = this.playing;
    data['admin_status'] = this.adminStatus;
    return data;
  }
}
