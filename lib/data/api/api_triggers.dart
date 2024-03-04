// import 'package:flutter/cupertino.dart';
//
// import 'api_provider.dart';
// class ApiTriggers {
// ApiProvider api = ApiProvider();
// List scoreList =[];
//  Future<dynamic> getLearderBoard(gameType) async {
//     scoreList =[];
//      debugPrint("URL: ${api.getLeaderboardApi}${gameType} ");
//     var response =  await api.getRequest("${api.getLeaderboardApi}${gameType}");
//     for (var scores in response['leaderboard']) {
//       scoreList.add(scores);
//     }
//     return scoreList;
//   }
//  Future<dynamic> updateScore(gameType,username,score) async {
//     var response = await api.postRequest("${api.updateScoreApi}/$gameType/$username", {'score': score});
//     return response;
//   }
// }
