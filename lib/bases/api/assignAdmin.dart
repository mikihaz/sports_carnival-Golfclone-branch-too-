import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rpgl/bases/webservice.dart';

class AssignAdminAPI {
  String? processStatus;
  String? processMessage;

  AssignAdminAPI({this.processStatus, this.processMessage});

  AssignAdminAPI.fromJson(Map<String, dynamic> json) {
    processStatus = json['process_status'];
    processMessage = json['process_message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['process_status'] = this.processStatus;
    data['process_message'] = this.processMessage;
    return data;
  }

  static Future<AssignAdminAPI> assignadmin(String member_id) async {
    Uri url = Uri.parse(
        "${Webservice.rootURL}${Webservice.ws_assign_as_admin_by_owner}");
    final request = http.MultipartRequest('POST', url);
    print(url);
    print(member_id);
    request.fields.addAll(
        {'leagueid': Webservice.appNickname, 'the_member_id': member_id});
    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    print(responseString);
    return AssignAdminAPI.fromJson(jsonDecode(responseString));
  }
}
