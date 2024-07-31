import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rpgl/bases/webservice.dart';

class Committee {
  String? processSts;
  String? processMsg;
  CommitteeDetails? committeeDetails;

  Committee({this.processSts, this.processMsg, this.committeeDetails});

  Committee.fromJson(Map<String, dynamic> json) {
    processSts = json['process_sts'];
    processMsg = json['process_msg'];
    committeeDetails = json['committee_details'] != null
        ? new CommitteeDetails.fromJson(json['committee_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['process_sts'] = processSts;
    data['process_msg'] = processMsg;
    if (committeeDetails != null) {
      data['committee_details'] = committeeDetails!.toJson();
    }
    return data;
  }
}

class CommitteeDetails {
  List<TournamentCommittee>? tournamentCommittee;
  List<ClubCommittee>? clubCommittee;
  List<SportsCommittee>? sportsCommittee;

  CommitteeDetails(
      {this.tournamentCommittee, this.clubCommittee, this.sportsCommittee});

  CommitteeDetails.fromJson(Map<String, dynamic> json) {
    if (json['Tournament Committee'] != null) {
      tournamentCommittee = <TournamentCommittee>[];
      json['Tournament Committee'].forEach((v) {
        tournamentCommittee!.add(new TournamentCommittee.fromJson(v));
      });
    }
    if (json['Club Committee'] != null) {
      clubCommittee = <ClubCommittee>[];
      json['Club Committee'].forEach((v) {
        clubCommittee!.add(new ClubCommittee.fromJson(v));
      });
    }
    if (json['Sports Committee'] != null) {
      sportsCommittee = <SportsCommittee>[];
      json['Sports Committee'].forEach((v) {
        sportsCommittee!.add(new SportsCommittee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tournamentCommittee != null) {
      data['Tournament Committee'] =
          tournamentCommittee!.map((v) => v.toJson()).toList();
    }
    if (clubCommittee != null) {
      data['Club Committee'] = clubCommittee!.map((v) => v.toJson()).toList();
    }
    if (sportsCommittee != null) {
      data['Sports Committee'] =
          sportsCommittee!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Future<Committee> committeeList() async {
    Uri url = Uri.parse("${Webservice.rootURL}${Webservice.committee}");
    final request = http.MultipartRequest('POST', url);
    print(url);
    // if (Webservice.appNickname == 'rpgl') {
    //   request.fields.addAll({'leagueid': 'OPL25'});
    // } else if (Webservice.appNickname == 'pgl') {
    //   request.fields.addAll({'leagueid': 'PGL25'});
    // }
    request.fields.addAll({'leagueid': Webservice.appNickname});

    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    return Committee.fromJson(jsonDecode(responseString));
  }
}

class TournamentCommittee {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? role;

  TournamentCommittee({this.id, this.name, this.phone, this.email, this.role});

  TournamentCommittee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}

class ClubCommittee {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? role;

  ClubCommittee({this.id, this.name, this.phone, this.email, this.role});

  ClubCommittee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}

class SportsCommittee {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? role;

  SportsCommittee({this.id, this.name, this.phone, this.email, this.role});

  SportsCommittee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['role'] = role;
    return data;
  }
}
