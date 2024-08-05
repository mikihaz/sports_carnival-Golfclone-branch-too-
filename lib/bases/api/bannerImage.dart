import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rpgl/bases/webservice.dart';

class BannerImageAPI {
  String? processSts;
  String? processMsg;
  String? bannerImage;

  BannerImageAPI({this.processSts, this.processMsg, this.bannerImage});

  BannerImageAPI.fromJson(Map<String, dynamic> json) {
    processSts = json['process_sts'];
    processMsg = json['process_msg'];
    bannerImage = json['banner_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['process_sts'] = this.processSts;
    data['process_msg'] = this.processMsg;
    data['banner_image'] = this.bannerImage;
    return data;
  }

  static Future<BannerImageAPI> leaderboardlist() async {
    Uri url = Uri.parse("${Webservice.rootURL}${Webservice.bannerImage}");
    final request = http.MultipartRequest('POST', url);
    print(url);
    request.fields.addAll({'leagueid': Webservice.appNickname});

    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    return BannerImageAPI.fromJson(jsonDecode(responseString));
  }
}
