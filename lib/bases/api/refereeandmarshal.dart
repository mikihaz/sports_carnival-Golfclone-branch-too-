import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rpgl/bases/webservice.dart';

class RefereeAndMarshalAPI {
  String? processSts;
  String? processMsg;
  MarshalDetails? marshalDetails;

  RefereeAndMarshalAPI({this.processSts, this.processMsg, this.marshalDetails});

  RefereeAndMarshalAPI.fromJson(Map<String, dynamic> json) {
    processSts = json['process_sts'];
    processMsg = json['process_msg'];
    marshalDetails = json['marshal_details'] != null
        ? new MarshalDetails.fromJson(json['marshal_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['process_sts'] = this.processSts;
    data['process_msg'] = this.processMsg;
    if (this.marshalDetails != null) {
      data['marshal_details'] = this.marshalDetails!.toJson();
    }
    return data;
  }

  static Future<RefereeAndMarshalAPI> refreelist() async {
    Uri url =
        Uri.parse("${Webservice.rootURL}${Webservice.show_marshal_details}");
    final request = http.MultipartRequest('POST', url);
    print(url);
    request.fields.addAll({'leagueid': Webservice.appNickname});

    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    return RefereeAndMarshalAPI.fromJson(jsonDecode(responseString));
  }
}

class MarshalDetails {
  List<Referees>? referees;

  MarshalDetails({this.referees});

  MarshalDetails.fromJson(Map<String, dynamic> json) {
    if (json['Referees'] != null) {
      referees = <Referees>[];
      json['Referees'].forEach((v) {
        referees!.add(new Referees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.referees != null) {
      data['Referees'] = this.referees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Referees {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? role;
  String? image;

  Referees({this.id, this.name, this.phone, this.email, this.role, this.image});

  Referees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['role'] = this.role;
    data['image'] = this.image;
    return data;
  }
}
