import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rpgl/bases/webservice.dart';

class HomescreenAPI {
  String? processStatus;
  String? leaderboardImage;
  String? leaderboardWeblink;
  String? usernameExistStatus;
  String? enableClick;
  String? liveScoreStatus;
  List<ShowCurrentMatchDetails>? showCurrentMatchDetails;
  String? homeScreenSideImage;

  HomescreenAPI(
      {this.processStatus,
      this.leaderboardImage,
      this.leaderboardWeblink,
      this.usernameExistStatus,
      this.enableClick,
      this.liveScoreStatus,
      this.showCurrentMatchDetails,
      this.homeScreenSideImage});

  HomescreenAPI.fromJson(Map<String, dynamic> json) {
    processStatus = json['process_status'];
    leaderboardImage = json['leaderboard_image'];
    leaderboardWeblink = json['leaderboard_weblink'];
    usernameExistStatus = json['username_exist_status'];
    enableClick = json['enable_click'];
    liveScoreStatus = json['live_score_status'];
    if (json['show_current_match_details'] != null) {
      showCurrentMatchDetails = <ShowCurrentMatchDetails>[];
      json['show_current_match_details'].forEach((v) {
        showCurrentMatchDetails!.add(ShowCurrentMatchDetails.fromJson(v));
      });
    }
    homeScreenSideImage = json['home_screen_side_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['process_status'] = processStatus;
    data['leaderboard_image'] = leaderboardImage;
    data['leaderboard_weblink'] = leaderboardWeblink;
    data['username_exist_status'] = usernameExistStatus;
    data['enable_click'] = enableClick;
    data['live_score_status'] = liveScoreStatus;
    if (showCurrentMatchDetails != null) {
      data['show_current_match_details'] =
          showCurrentMatchDetails!.map((v) => v.toJson()).toList();
    }
    data['home_screen_side_image'] = homeScreenSideImage;
    return data;
  }

  static Future<HomescreenAPI> homescreenlist() async {
    Uri url =
        Uri.parse("${Webservice.rootURL}${Webservice.ws_live_score_status}");
    final request = http.MultipartRequest('POST', url);
    print(url);
    request.fields.addAll({'leagueid': Webservice.appNickname});

    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    print(responseString);
    return HomescreenAPI.fromJson(jsonDecode(responseString));
  }
}

class ShowCurrentMatchDetails {
  String? id;
  String? date;
  String? time;
  String? group;
  String? teams;
  String? team1;
  String? team1Image;
  String? team1ImageUrl;
  String? team2Image;
  String? team2ImageUrl;
  String? team2;
  String? results;
  String? scoreBoard;
  String? winnerName;
  String? text1;
  String? text2;
  String? imageName;
  String? liveScoreText;
  String? matchStatusText;
  ResultData? resultData;

  ShowCurrentMatchDetails(
      {this.id,
      this.date,
      this.time,
      this.group,
      this.teams,
      this.team1,
      this.team1Image,
      this.team1ImageUrl,
      this.team2Image,
      this.team2ImageUrl,
      this.team2,
      this.results,
      this.scoreBoard,
      this.winnerName,
      this.text1,
      this.text2,
      this.imageName,
      this.liveScoreText,
      this.matchStatusText,
      this.resultData});

  ShowCurrentMatchDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    group = json['group'];
    teams = json['teams'];
    team1 = json['team1'];
    team1Image = json['team1_image'];
    team1ImageUrl = json['team1_image_url'];
    team2Image = json['team2_image'];
    team2ImageUrl = json['team2_image_url'];
    team2 = json['team2'];
    results = json['results'];
    scoreBoard = json['score_board'];
    winnerName = json['winner_name'];
    text1 = json['text1'];
    text2 = json['text2'];
    imageName = json['image_name'];
    liveScoreText = json['live_score_text'];
    matchStatusText = json['match_status_text'];
    resultData = json['result_data'] != null
        ? ResultData.fromJson(json['result_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['time'] = time;
    data['group'] = group;
    data['teams'] = teams;
    data['team1'] = team1;
    data['team1_image'] = team1Image;
    data['team1_image_url'] = team1ImageUrl;
    data['team2_image'] = team2Image;
    data['team2_image_url'] = team2ImageUrl;
    data['team2'] = team2;
    // data['results'] = results;
    data['score_board'] = scoreBoard;
    data['winner_name'] = winnerName;
    data['text1'] = text1;
    data['text2'] = text2;
    data['image_name'] = imageName;
    data['live_score_text'] = liveScoreText;
    data['match_status_text'] = matchStatusText;
    if (resultData != null) {
      data['result_data'] = resultData!.toJson();
    }
    return data;
  }
}

class ResultData {
  Map<String, dynamic>? games;

  ResultData({this.games});

  ResultData.fromJson(Map<String, dynamic> json) {
    games = {};
    json.forEach((key, value) {
      if (key.startsWith('Game')) {
        games![key] = Game.fromJson(value);
      }
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (games != null) {
      games!.forEach((key, value) {
        data[key] = value.toJson();
      });
    }
    return data;
  }
}

class Game {
  String? title;
  String? time;
  String? tee;
  String? team1Participents;
  String? team1Participent1;
  String? team1Participent1Rank;
  String? team1Participent2;
  String? team1Participent2Rank;
  String? team1Score;
  String? team1Point;
  String? team1ByeScore;
  String? team1ByePoint;
  String? team2Participents;
  String? team2Participent1;
  String? team2Participent1Rank;
  String? team2Participent2;
  String? team2Participent2Rank;
  String? team2Score;
  String? team2Point;
  String? team2ByeScore;
  String? team2ByePoint;
  String? gameIsBye;
  String? gameByeStartAfterHoleNo;
  String? gameByeStartAfterTotalHolePlayed;
  String? historyWebLink;

  Game(
      {this.title,
      this.time,
      this.tee,
      this.team1Participents,
      this.team1Participent1,
      this.team1Participent1Rank,
      this.team1Participent2,
      this.team1Participent2Rank,
      this.team1Score,
      this.team1Point,
      this.team1ByeScore,
      this.team1ByePoint,
      this.team2Participents,
      this.team2Participent1,
      this.team2Participent1Rank,
      this.team2Participent2,
      this.team2Participent2Rank,
      this.team2Score,
      this.team2Point,
      this.team2ByeScore,
      this.team2ByePoint,
      this.gameIsBye,
      this.gameByeStartAfterHoleNo,
      this.gameByeStartAfterTotalHolePlayed,
      this.historyWebLink});

  Game.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    time = json['time'];
    tee = json['tee'];
    team1Participents = json['team_1_participents'];
    team1Participent1 = json['team_1_participent_1'];
    team1Participent1Rank = json['team_1_participent_1_rank'];
    team1Participent2 = json['team_1_participent_2'];
    team1Participent2Rank = json['team_1_participent_2_rank'];
    team1Score = json['team_1_score'];
    team1Point = json['team_1_point'];
    team1ByeScore = json['team_1_bye_score'];
    team1ByePoint = json['team_1_bye_point'];
    team2Participents = json['team_2_participents'];
    team2Participent1 = json['team_2_participent_1'];
    team2Participent1Rank = json['team_2_participent_1_rank'];
    team2Participent2 = json['team_2_participent_2'];
    team2Participent2Rank = json['team_2_participent_2_rank'];
    team2Score = json['team_2_score'];
    team2Point = json['team_2_point'];
    team2ByeScore = json['team_2_bye_score'];
    team2ByePoint = json['team_2_bye_point'];
    gameIsBye = json['game_is_bye'];
    gameByeStartAfterHoleNo = json['game_bye_start_after_hole_no'];
    gameByeStartAfterTotalHolePlayed =
        json['game_bye_start_after_total_hole_played'];
    historyWebLink = json['history_web_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['time'] = time;
    data['tee'] = tee;
    data['team_1_participents'] = team1Participents;
    data['team_1_participent_1'] = team1Participent1;
    data['team_1_participent_1_rank'] = team1Participent1Rank;
    data['team_1_participent_2'] = team1Participent2;
    data['team_1_participent_2_rank'] = team1Participent2Rank;
    data['team_1_score'] = team1Score;
    data['team_1_point'] = team1Point;
    data['team_1_bye_score'] = team1ByeScore;
    data['team_1_bye_point'] = team1ByePoint;
    data['team_2_participents'] = team2Participents;
    data['team_2_participent_1'] = team2Participent1;
    data['team_2_participent_1_rank'] = team2Participent1Rank;
    data['team_2_participent_2'] = team2Participent2;
    data['team_2_participent_2_rank'] = team2Participent2Rank;
    data['team_2_score'] = team2Score;
    data['team_2_point'] = team2Point;
    data['team_2_bye_score'] = team2ByeScore;
    data['team_2_bye_point'] = team2ByePoint;
    data['game_is_bye'] = gameIsBye;
    data['game_bye_start_after_hole_no'] = gameByeStartAfterHoleNo;
    data['game_bye_start_after_total_hole_played'] =
        gameByeStartAfterTotalHolePlayed;
    data['history_web_link'] = historyWebLink;
    return data;
  }
}
