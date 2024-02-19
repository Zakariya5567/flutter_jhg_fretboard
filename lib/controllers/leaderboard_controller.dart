import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:reg_page/reg_page.dart';
import '../api/api_provider.dart';
import '../api/api_triggers.dart';

class LeaderBoardController extends GetxController {
  RxBool isLoading = false.obs;
  RxString gameType = "fretboardtrainer".obs;
  RxString username = "user1".obs;
  RxString highestUserScore = "".obs;
  RxString highScore = "0".obs;

  RxList scoreList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getUserName();
    getLearderBoard();
  }

  getUserName()async {
    var usernames  =  await LocalDB.getUserName;

    username.value = usernames!;

    print("THE USER NAME IS $usernames");
  }

  // Future<dynamic> getLearderBoard() async {
  //   scoreList([]);
  //   isLoading(true);
  //   scoreList.value = await api.getLearderBoard(gameType);
  //   isLoading(false);
  //   await highestScorer(scoreList);
  //   update();
  //   return scoreList;
  // }


  Future<dynamic> getLearderBoard() async {
    scoreList([]);
    isLoading(true);
   var  value = await compute(getLearderBoardApiRequest,gameType);
    scoreList.value = value;
    isLoading(false);
    await highestScorer(scoreList);
    update();
    return scoreList;
  }


  static Future<dynamic> getLearderBoardApiRequest(gameType) async {
    List scoredList =[];
    debugPrint("URL: ${ApiProvider().getLeaderboardApi}${gameType} ");
    var response =  await ApiProvider().getRequest("${ApiProvider().getLeaderboardApi}${gameType}");
    for (var scores in response['leaderboard']) {
      scoredList.add(scores);
    }
    return scoredList;
  }

  Future<dynamic> highestScorer(leaderboard) async {
    String? highestScorer;
    int highestScore = 0; // Initialize to the lowest possible value

    for (var player in leaderboard) {
      String username = player['username'];
      int score = player['score'];

      if (score > highestScore) {
        highestScore = score;
        highestScorer = username;
      }
    }

    if (highestScorer != null) {
      highestUserScore.value = highestScorer.toString();
      highScore.value = highestScore.toString();
      print(
          "The user with the highest score is $highestScorer with a score of $highestScore");
    } else {
      print("No user with a positive score found in the leaderboard.");
    }
    update();
    return highestScorer;
  }


}