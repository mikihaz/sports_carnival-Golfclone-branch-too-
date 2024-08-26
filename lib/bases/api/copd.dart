import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rpgl/bases/webservice.dart';

class CopdAPI {
  String? processSts;
  String? processMsg;
  String? copdDoc;

  CopdAPI({this.processSts, this.processMsg, this.copdDoc});

  CopdAPI.fromJson(Map<String, dynamic> json) {
    processSts = json['process_sts'];
    processMsg = json['process_msg'];
    copdDoc = json['copd_doc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['process_sts'] = this.processSts;
    data['process_msg'] = this.processMsg;
    data['copd_doc'] = this.copdDoc;
    return data;
  }

  static Future<CopdAPI> pdflist() async {
    Uri url = Uri.parse("${Webservice.rootURL}${Webservice.copd_api}");
    final request = http.MultipartRequest('POST', url);
    print(url);
    request.fields.addAll({'leagueid': Webservice.appNickname});

    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    return CopdAPI.fromJson(jsonDecode(responseString));
  }
}
