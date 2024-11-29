// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final leaderboard = leaderboardFromMap(jsonString);

import 'dart:convert';

Leaderboard leaderboardFromMap(String str) =>
    Leaderboard.fromMap(json.decode(str));

String leaderboardToMap(Leaderboard data) => json.encode(data.toMap());

class Leaderboard {
  bool? success;
  String? game;
  List<LeaderboardData>? leaderboard;

  Leaderboard({
    this.game,
    this.success,
    this.leaderboard,
  });

  factory Leaderboard.fromMap(Map<String, dynamic> json) => Leaderboard(
        success: json["success"],
        game: json["game"],
        leaderboard: json["leaderboard"] == null
            ? []
            : List<LeaderboardData>.from(
                json["leaderboard"]!.map((x) => LeaderboardData.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "leaderboard": leaderboard == null
            ? []
            : List<dynamic>.from(leaderboard!.map((x) => x.toMap())),
      };
}

class LeaderboardData {
  String? username;
  int? score;

  LeaderboardData({
    this.username,
    this.score,
  });

  factory LeaderboardData.fromMap(Map<String, dynamic> json) => LeaderboardData(
        username: json["username"],
        score: json["score"],
      );

  Map<String, dynamic> toMap() => {
        "username": username,
        "score": score,
      };

  @override
  String toString() => 'LeaderboardData(username: $username, score: $score)';
}
