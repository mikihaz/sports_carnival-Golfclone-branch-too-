import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rpgl/bases/webservice.dart';

class NotificationAPI {
  String? processSts;
  String? processMsg;
  List<NotificationDetails>? notificationDetails;

  NotificationAPI({this.processSts, this.processMsg, this.notificationDetails});

  NotificationAPI.fromJson(Map<String, dynamic> json) {
    processSts = json['process_sts'];
    processMsg = json['process_msg'];
    if (json['notification_details'] != null) {
      notificationDetails = <NotificationDetails>[];
      json['notification_details'].forEach((v) {
        notificationDetails!.add(new NotificationDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['process_sts'] = this.processSts;
    data['process_msg'] = this.processMsg;
    if (this.notificationDetails != null) {
      data['notification_details'] =
          this.notificationDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Future<NotificationAPI> notificationlist() async {
    Uri url = Uri.parse(
        "${Webservice.rootURL}${Webservice.show_notification_details}");
    final request = http.MultipartRequest('POST', url);
    print(url);
    request.fields.addAll({'leagueid': Webservice.appNickname});

    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    return NotificationAPI.fromJson(jsonDecode(responseString));
  }
}

class NotificationDetails {
  String? id;
  String? title;
  String? dateTimeText;
  String? message;
  String? dateTime;
  String? image;

  NotificationDetails(
      {this.id,
      this.title,
      this.dateTimeText,
      this.message,
      this.dateTime,
      this.image});

  NotificationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    dateTimeText = json['date_time_text'];
    message = json['message'];
    dateTime = json['date_time'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date_time_text'] = this.dateTimeText;
    data['message'] = this.message;
    data['date_time'] = this.dateTime;
    data['image'] = this.image;
    return data;
  }
}
