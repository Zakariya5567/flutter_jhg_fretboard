import 'package:flutter/cupertino.dart';
import 'package:fretboard/api/req.dart';

class ApiProvider {
  var req = Req();
  String baseURL = "https://www.jamieharrisonguitar.com/wp-json/wp/v2";
  String getLeaderboardApi = "leaderboard/get?game=";
  String updateScoreApi = "leaderboard";

  Future<dynamic> postRequest(endpoint, data) async {
    return await req.post('$baseURL/$endpoint', data);
  }
  Future<dynamic> getRequest(endpoint) async {
    return await req.get('$baseURL/$endpoint');
  }
}
