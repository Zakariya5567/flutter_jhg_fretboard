import 'package:flutter/foundation.dart';
import 'package:fretboard/models/leaderboard.dart';
import 'package:get/get.dart';
import 'package:reg_page/reg_page.dart';

import '../repositories/leaderboard_repo.dart';

class LeaderBoardController extends GetxController {
  RxBool isLoading = false.obs;
  RxString gameType = "fretboardtrainer".obs;
  RxString username = "user1".obs;
  Rx<LeaderboardData> leader = LeaderboardData().obs;

  RxList<LeaderboardData> scoreList = <LeaderboardData>[].obs;

  getDataFromApi() async {
    username.value = SplashScreen.session.user?.userName ?? '';
    await getLeaderBoard();
  }

  Future<dynamic> getLeaderBoard() async {
    try {
      scoreList([]);
      isLoading(true);
      var value = await compute(getLeaderBoardApiRequest, gameType.value);
      scoreList.value = value;
      isLoading(false);
      await highestScorer();
      update();
      return scoreList;
    } catch (e) {
      isLoading(false);
    }
  }

  Future<List<LeaderboardData>> getLeaderBoardApiRequest(gameType) async {
    return await LeaderboardRepo().getLeaderboardData();
  }

  Future<String?> highestScorer() async {
    String? highestScorer;
    int highestScore = 0;
    for (var player in scoreList) {
      int score = player.score ?? 0;
      if (score > highestScore) {
        highestScore = score;
        leader(player);
      }
    }
    update();
    return highestScorer;
  }
}
