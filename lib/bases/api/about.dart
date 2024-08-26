import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rpgl/bases/webservice.dart';

class AboutAPI {
  String? processSts;
  String? processMsg;
  List<AboutData>? aboutData;

  AboutAPI({this.processSts, this.processMsg, this.aboutData});

  AboutAPI.fromJson(Map<String, dynamic> json) {
    processSts = json['process_sts'];
    processMsg = json['process_msg'];
    if (json['about_data'] != null) {
      aboutData = <AboutData>[];
      json['about_data'].forEach((v) {
        aboutData!.add(new AboutData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['process_sts'] = this.processSts;
    data['process_msg'] = this.processMsg;
    if (this.aboutData != null) {
      data['about_data'] = this.aboutData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Future<AboutAPI> leaderboardlist() async {
    Uri url = Uri.parse("${Webservice.rootURL}${Webservice.about_api}");
    final request = http.MultipartRequest('POST', url);
    print(url);
    request.fields.addAll({'leagueid': Webservice.appNickname});

    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    return AboutAPI.fromJson(jsonDecode(responseString));
  }
}

class AboutData {
  String? id;
  String? title;
  String? description;
  String? leagueid;

  AboutData({this.id, this.title, this.description, this.leagueid});

  AboutData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    leagueid = json['leagueid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['leagueid'] = this.leagueid;
    return data;
  }
}
