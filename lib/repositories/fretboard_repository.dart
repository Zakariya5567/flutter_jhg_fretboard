import 'package:fretboard/services/base_api_service.dart';

class FretBoardRepository {
  var baseApiService = BaseApiService();
  String baseURL = "https://www.jamieharrisonguitar.com/wp-json/wp/v2";
  String getLeaderboardApi = "leaderboard/get?game=";
  String updateScoreApi = "leaderboard";

  Future<dynamic> postRequest(endpoint, data) async {
    return await baseApiService.post('$baseURL/$endpoint', data);
  }
  Future<dynamic> getRequest(endpoint) async {
    return await baseApiService.get('$baseURL/$endpoint');
  }
}
