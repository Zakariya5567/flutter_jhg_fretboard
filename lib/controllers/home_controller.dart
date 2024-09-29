import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show compute, kIsWeb;
import 'package:flutter_jhg_elements/jhg_elements.dart';
import 'package:fretboard/models/freth_list.dart';
import 'package:fretboard/repositories/fretboard_repository.dart';
import 'package:fretboard/services/local_db_service.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:reg_page/reg_page.dart';
import 'package:universal_html/html.dart';

import 'leaderboard_controller.dart';

class HomeController extends GetxController {
  // disable the web active status is true
  var userNameWeb = 'DefaultUserName';
  var isActive = true;

  // Instance of the Player
  final player = AudioPlayer();
  int? selectedFret;
  String? selectedNote;
  int? selectedString;
  String? userName;
  TextEditingController timerIntervalEditingController =
      new TextEditingController();
  TextEditingController minutesEditingController = new TextEditingController();
  RxString defaultTimerSelectedValue = "Stopwatch".obs;
  // JHGInterstitialAd? interstitialAd;
  JHGInterstitialAd? interstitialAds;
  RxBool isExpanded = RxBool(false);

  getUserName() async {
    userName = await LocalDB.getUserName;
  }

  void updateIsExpanded() {
    isExpanded.value = !isExpanded.value;
  }

  // Initialize  animation controller
  initializeData() async {
    isStart = false;
    selectedFret = null;
    selectedString = null;
    selectedNote = null;
    highlightFret = null;
    highlightString = null;
    highlightNode = null;
    previousHighlightFret = null;
    previousHighlightNode = null;
    score = 0;
    timer = null;
    //isTimerSet = false;
    secondsRemaining.value = 0;
    timerMode = false;
    leaderboardMode = false;
    int seconds = await SharedPref.getTimerIntervalValue();
    int minutes = await SharedPref.getDefaultTimerMinutesValue();
    String? defaultTimerType = await SharedPref.getDefaultTimerTypeValue();
    if (defaultTimerType != null) {
      defaultTimerSelectedValue.value = defaultTimerType;
    }
    minutesEditingController.text = minutes.toString();
    timerIntervalEditingController.text = seconds.toString();
    await getUserName();
    update();
  }

  // PLAY SOUND ACCORDING TO SELECTED NOTES , STRING AND FRET

  bool isPlayed = false;

  Future playSound(int index, String note, int str) async {
    isPlayed = false;
    await player.stop();
    // EXECUTE LOOP
    fretList.forEach((element) async {
      // if(element.id == index){
      if (element.note == note && element.string == str && isPlayed == false) {
        // GET ALLOW STRING STATUS
        final stringStatus = getStringStatus(element.string!);

        // CHECK IF THE STATUS IS TRUE AND GAME IS START
        // THEN WE WILL HIGHLIGHT THINGS
        if (stringStatus == true && isStart == true) {
          selectedFret = index;
          selectedString = str;
          selectedNote = note;
          player.setVolume(1.0);
          if (kIsWeb) {
            player.setAsset("web/${element.fretSound!}");
          } else {
            player.setFilePath(Utils.getAsset(element.fretSound!).path);
          }
          player.play();
          if (highlightNode == selectedNote &&
              selectedString == highlightString) {
            previousHighlightFret = highlightFret;
            previousHighlightNode = highlightNode;
            incrementScore();
            highLightTheGame();
            Future.delayed(Duration(milliseconds: 300), () {
              selectedFret = null;
              update();
            });
          } else {
            decrementScore();
          }
          update();
        } else {
          player.setVolume(1.0);
          if (kIsWeb) {
            player.setAsset("web/${element.fretSound!}");
          } else {
            player.setFilePath(Utils.getAsset(element.fretSound!).path);
          }
          player.play();
        }
        return;
      }
    });
  }

  double scale = 1;

  bool isPortrait = true;

  void toggleOrientation() {
    scale = 0.5;
    Future.delayed(const Duration(milliseconds: 100), () {
      isPortrait = !isPortrait;
      update();
    });
    Future.delayed(const Duration(milliseconds: 300), () {
      scale = 1;
      update();
    });
  }

  // SCORE
  // Correct  and Incorrect
  // Correct increment , incorrect decrement
  int score = 0;

  incrementScore() {
    score = score + 1;
    isPlayed = true;
    update();
  }

  decrementScore() {
    score = score - 1;
    isPlayed = true;
    update();
  }

  //Modes

  bool timerMode = false;
  bool leaderboardMode = false;

  setTimerMode(bool mode) {
    timerMode = mode;
    update();
  }

  setLeaderMode(bool mode) {
    leaderboardMode = mode;
    update();
  }

  // START THE GAME
  // SELECT AND HIGHLIGHT STRING, FRET AND NOTE

  bool isStart = false;
  int? highlightFret;
  int? highlightString;
  String? highlightNode;
  String? previousHighlightNode;
  int? previousHighlightFret;

  // WHEN PRESS CORRECT NOTE THEN HIGHLIGHT ANOTHER ONE TO SELECT
  highLightTheGame() {
    // Get randomly highlight node
    int randomIndex = getRandomIndex();
    highlightFret = randomIndex;
    highlightNode = fretList[randomIndex].note;
    highlightString = fretList[randomIndex].string;
    update();
  }

// GET RANDOM INDEX ACCORDING TO  ALLOW STRING
  getRandomIndex() {
    Random random = Random();
    int randomIndex;
    do {
      randomIndex = random.nextInt(fretList.length);
    } while (getStringStatus(fretList[randomIndex].string!) == false);
    return randomIndex;
  }

  // START THE GAME ON START BUTTON
  startTheGame() {
    isStart = true;
    int randomIndex = getRandomIndex();
    highlightFret = randomIndex;
    previousHighlightFret = highlightFret;
    previousHighlightNode = highlightNode;
    highlightNode = fretList[randomIndex].note;
    highlightString = fretList[randomIndex].string;
    update();
  }

// TIMER

  // int secondsRemaining = 0; // Initial countdown time in seconds
  Timer? timer;

  // bool isTimerSet = false;

  increaseTime() {
    if (isStart != true) {
      secondsRemaining.value = secondsRemaining.value +
          int.parse(timerIntervalEditingController.text);
      update();
    }
  }

  decreaseTime() {
    if (secondsRemaining.value > 10 && isStart != true) {
      secondsRemaining.value = secondsRemaining.value -
          int.parse(timerIntervalEditingController.text);
      update();
    }
  }

  resetGame(bool resetAll) {
    if (timer != null) {
      timer!.cancel();
    }
    isStart = false;
    selectedFret = null;
    selectedString = null;
    selectedNote = null;
    highlightFret = null;
    highlightString = null;
    highlightNode = null;
    previousHighlightFret = null;
    previousHighlightNode = null;
    score = 0;
    secondsRemaining.value = 0;
    // isTimerSet = false;
    timer = null;

    if (resetAll == true) {
      if (timerMode == true) {
        timerMode = false;
      } else {
        leaderboardMode = false;
      }
    }
    update();

    resetTimer();
  }

  resetTimer() {
    //isTimerSet = true;
    if (timerMode == true) {
      secondsRemaining.value = 60 * int.parse(minutesEditingController.text);
    } else if (leaderboardMode == true) {
      secondsRemaining.value = 120;
    } else {
      secondsRemaining.value = 0;
    }
    update();
  }

  startTimer() {
    if (timerMode == true) {
      startCountDownTimer();
    } else if (leaderboardMode == true) {
      offString = [true, true, true, true, true, true];
      string1 = true;
      string2 = true;
      string3 = true;
      string4 = true;
      string5 = true;
      string6 = true;
      notifyChildrens();
      startLeaderBoardCountDownTimer();
    } else {
      startCountUpTimer();
    }
  }

  String formatTime(int seconds) {
    // Format the remaining time as mm:ss
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  //GET STRING STATUS WHICH STRING IS ALLOW
  bool getStringStatus(int id) {
    if (string1 == true && id == 1) {
      return true;
    } else if (string2 == true && id == 2) {
      return true;
    } else if (string3 == true && id == 3) {
      return true;
    } else if (string4 == true && id == 4) {
      return true;
    } else if (string5 == true && id == 5) {
      return true;
    } else if (string6 == true && id == 6) {
      return true;
    } else {
      return false;
    }
  }

  List offString = [true, true, true, true, true, true];

  //STRING TOGGLES
  // STRING 1
  bool string1 = true;

  setString1(int index) {
    string1 = !string1;
    offString[index] = string1;
    if (!offString.contains(true)) {
      offString[index] = true;
      string1 = true;
    }
    update();
  }

  // STRING 2
  bool string2 = true;

  setString2(int index) {
    string2 = !string2;
    offString[index] = string2;
    if (!offString.contains(true)) {
      offString[index] = true;
      string2 = true;
    }
    update();
  }

  // STRING 3
  bool string3 = true;

  setString3(int index) {
    string3 = !string3;
    offString[index] = string3;
    if (!offString.contains(true)) {
      offString[index] = true;
      string3 = true;
    }
    update();
  }

  // STRING 4
  bool string4 = true;

  setString4(int index) {
    string4 = !string4;
    offString[index] = string4;
    if (!offString.contains(true)) {
      offString[index] = true;
      string4 = true;
    }
    update();
  }

  // STRING 5
  bool string5 = true;

  setString5(int index) {
    string5 = !string5;
    offString[index] = string5;
    if (!offString.contains(true)) {
      offString[index] = true;
      string5 = true;
    }
    update();
  }

  // STRING 6
  bool string6 = true;

  setString6(int index) {
    string6 = !string6;
    offString[index] = string6;
    if (!offString.contains(true)) {
      offString[index] = true;
      string6 = true;
    }
    update();
  }

  // Value Notifier listener

  ValueNotifier<int> secondsRemaining = ValueNotifier(0);

  startLeaderBoardCountDownTimer() {
    if (secondsRemaining.value == 0) {
      secondsRemaining.value = 10;
    }
    update();
    if (timer != null) {
      timer!.cancel();
    }
    // Create a timer that runs every second
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      // Update the UI and decrement the remaining seconds
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
        await updateScore(score);
        update();
        LeaderBoardController lc = Get.put(LeaderBoardController());
        lc.getDataFromApi();
      }
    });
  }

  startCountDownTimer() {
    if (secondsRemaining.value == 0) {
      secondsRemaining.value = 60 * int.parse(minutesEditingController.text);
    }
    update();
    if (timer != null) {
      timer!.cancel();
    }
    // Create a timer that runs every second
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Update the UI and decrement the remaining seconds
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        // Timer expired, you can handle this case here
        timer.cancel();
        // Cancel the timer when the countdown reaches 0
        update();
      }
    });
  }

  startCountUpTimer() {
    secondsRemaining.value = 0;
    update();
    if (timer != null) {
      timer!.cancel();
    }
    // Create a timer that runs every second
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Update the UI and decrement the remaining seconds
      secondsRemaining.value++;
    });
  }

  Future<dynamic> updateScore(score) async {
    var response = await compute(updateScoreApiRequest, "FretboardTrainer");
    return response;
  }

  Future<dynamic> updateScoreApiRequest(gameType) async {
    var response = await FretBoardRepository().postRequest(
        "${FretBoardRepository().updateScoreApi}/$gameType/$userName",
        {'score': score});
    return response;
  }

  void onClickSave(BuildContext context) async {
    String seconds = timerIntervalEditingController.text;
    String minutes = minutesEditingController.text;
    if (defaultTimerSelectedValue == "Countdown") {
      if (seconds.isNotEmpty && minutes.isNotEmpty) {
        if (int.parse(seconds) < 1) {
          showToast(
              context: context,
              message:
                  "Timer interval seconds should be greater then or equal to 1",
              isError: true);
        } else if (int.parse(minutes) < 1) {
          showToast(
              context: context,
              message: "Minutes should be greater then or equal to 1",
              isError: true);
        } else {
          SharedPref.storeDefaultTimerTypeValue(
              defaultTimerSelectedValue.value);
          SharedPref.storeTimerIntervalValue(seconds);
          SharedPref.storeDefaultTimerMinutesValue(minutes);
          popup(context);
        }
      } else if (seconds.isEmpty) {
        showToast(
            context: context,
            message:
                "Timer interval seconds should be greater then or equal to 1",
            isError: true);
      } else if (minutes.isEmpty) {
        showToast(
            context: context,
            message: "Minutes should be greater then or equal to 1",
            isError: true);
      }
    } else {
      SharedPref.storeDefaultTimerTypeValue(defaultTimerSelectedValue.value);
      popup(context);
    }
  }

  void popup(BuildContext context) {
    resetTimer();
    Get.back();
  }

  void getUserNameFromRL() async {
    try {
      var uri = Uri.parse(window.location.href);
      userNameWeb = uri.queryParameters['username'].toString();
      isActive = bool.parse(uri.queryParameters['active'].toString());
      update();
    } on Exception {}
  }
}
