import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:reg_page/reg_page.dart';
import '../api/api_triggers.dart';
import '../model/board_model.dart';
import '../utils/app_constant.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  // Instance of the Player
  final player = AudioPlayer();

  // List of sound list
  List<BoardModel> fretList = [];

  Future<void> loadFullList() async {

    fretList.clear();

    //FRET0
    fretList.add(BoardModel(id: 0, string: 6, fret: 0, note: "E", fretSound: AppConstant.str6Fr0));
    fretList.add(BoardModel(id: 1, string: 5, fret: 0, note: "A", fretSound: AppConstant.str5Fr0));
    fretList.add(BoardModel(id: 2, string: 4, fret: 0, note: "D", fretSound: AppConstant.str4Fr0));
    fretList.add(BoardModel(id: 3, string: 3, fret: 0, note: "G", fretSound: AppConstant.str3Fr0));
    fretList.add(BoardModel(id: 4, string: 2, fret: 0, note: "B", fretSound: AppConstant.str2Fr0));
    fretList.add(BoardModel(id: 5, string: 1, fret: 0, note: "E", fretSound: AppConstant.str1Fr0));

    //FRET1
    fretList.add(BoardModel(id: 6, string: 6, fret: 1, note: "F", fretSound: AppConstant.str6Fr1));
    fretList.add(BoardModel(id: 7, string: 5, fret: 1, note: "A#", fretSound: AppConstant.str5Fr1));
    fretList.add(BoardModel(id: 8, string:  4, fret: 1, note: "D#", fretSound: AppConstant.str4Fr1));
    fretList.add(BoardModel(id: 9, string:  3, fret: 1, note: "G#", fretSound: AppConstant.str3Fr1));
    fretList.add(BoardModel(id: 10, string:  2, fret: 1, note:  "C", fretSound: AppConstant.str2Fr1));
    fretList.add(BoardModel(id: 11, string:  1, fret: 1, note:  "F", fretSound: AppConstant.str1Fr1));

    //FRET2
    fretList.add(BoardModel(id: 12, string: 6, fret: 2, note: "F#", fretSound: AppConstant.str6Fr2));
    fretList.add(BoardModel(id: 13, string: 5, fret: 2, note: "B", fretSound: AppConstant.str5Fr2));
    fretList.add(BoardModel(id: 14, string: 4, fret: 2, note: "E", fretSound: AppConstant.str4Fr2));
    fretList.add(BoardModel(id: 15, string: 3, fret: 2, note: "A", fretSound: AppConstant.str3Fr2));
    fretList.add(BoardModel(id: 16, string: 2, fret: 2, note: "C#", fretSound: AppConstant.str2Fr2));
    fretList.add(BoardModel(id: 17, string: 1, fret: 2, note: "F#", fretSound: AppConstant.str1Fr2));

    //FRET3
    fretList.add(BoardModel(id: 18, string: 6, fret: 3, note: "G", fretSound: AppConstant.str6Fr3));
    fretList.add(BoardModel(id: 19, string: 5, fret: 3, note: "C", fretSound: AppConstant.str5Fr3));
    fretList.add(BoardModel(id: 20, string: 4, fret: 3, note: "F", fretSound: AppConstant.str4Fr3));
    fretList.add(BoardModel(id: 21, string: 3, fret: 3, note: "A", fretSound: AppConstant.str3Fr3));
    fretList.add(BoardModel(id: 22, string: 2, fret: 3, note: "D", fretSound: AppConstant.str2Fr3));
    fretList.add(BoardModel(id: 23, string: 1, fret: 3, note: "G", fretSound: AppConstant.str1Fr3));

    //FRET4
    fretList.add(BoardModel(id: 24, string: 6, fret: 4, note: "G#", fretSound: AppConstant.str6Fr4));
    fretList.add(BoardModel(id: 25, string: 5, fret: 4, note: "C#", fretSound: AppConstant.str5Fr4));
    fretList.add(BoardModel(id: 26, string: 4, fret: 4, note: "F#", fretSound: AppConstant.str4Fr4));
    fretList.add(BoardModel(id: 27, string: 3, fret: 4, note: "B", fretSound:  AppConstant.str3Fr4));
    fretList.add(BoardModel(id: 28, string: 2, fret: 4, note: "D#", fretSound: AppConstant.str2Fr4));
    fretList.add(BoardModel(id: 29, string: 1, fret: 4, note: "G#", fretSound: AppConstant.str1Fr4));

    //FRET5
    fretList.add(BoardModel(id: 30, string: 6, fret: 5, note: "A", fretSound: AppConstant.str6Fr5));
    fretList.add(BoardModel(id: 31, string: 5, fret: 5, note: "D", fretSound: AppConstant.str5Fr5));
    fretList.add(BoardModel(id: 32, string: 4, fret: 5, note: "G", fretSound: AppConstant.str4Fr5));
    fretList.add(BoardModel(id: 33, string: 3, fret: 5, note: "C", fretSound:  AppConstant.str3Fr5));
    fretList.add(BoardModel(id: 34, string: 2, fret: 5, note: "E", fretSound: AppConstant.str2Fr5));
    fretList.add(BoardModel(id: 35, string: 1, fret: 5, note: "A", fretSound: AppConstant.str1Fr5));

    //FRET6
    fretList.add(BoardModel(id: 36, string: 6, fret: 6, note: "A#", fretSound: AppConstant.str6Fr6));
    fretList.add(BoardModel(id: 37, string: 5, fret: 6, note: "D#", fretSound: AppConstant.str5Fr6));
    fretList.add(BoardModel(id: 38, string: 4, fret: 6, note: "G#", fretSound: AppConstant.str4Fr6));
    fretList.add(BoardModel(id: 39, string: 3, fret: 6, note: "C#", fretSound: AppConstant.str3Fr6));
    fretList.add(BoardModel(id: 40, string: 2, fret: 6, note: "F", fretSound: AppConstant.str2Fr6));
    fretList.add(BoardModel(id: 41, string: 1, fret: 6, note: "A#", fretSound: AppConstant.str1Fr6));

    //FRET7
    fretList.add(BoardModel(id: 42, string: 6, fret: 7, note: "B", fretSound: AppConstant.str6Fr7));
    fretList.add(BoardModel(id: 43, string: 5, fret: 7, note: "E", fretSound: AppConstant.str5Fr7));
    fretList.add(BoardModel(id: 44, string: 4, fret: 7, note: "A", fretSound: AppConstant.str4Fr7));
    fretList.add(BoardModel(id: 45, string: 3, fret: 7, note: "D", fretSound: AppConstant.str3Fr7));
    fretList.add(BoardModel(id: 46, string: 2, fret: 7, note: "F#", fretSound:  AppConstant.str2Fr7));
    fretList.add(BoardModel(id: 47, string: 1, fret: 7, note: "B", fretSound: AppConstant.str1Fr7));

    //FRET8
    fretList.add(BoardModel(id: 48, string: 6, fret: 8, note: "C", fretSound: AppConstant.str6Fr8));
    fretList.add(BoardModel(id: 49, string: 5, fret: 8, note: "F", fretSound: AppConstant.str5Fr8));
    fretList.add(BoardModel(id: 50, string: 4, fret: 8, note: "A#", fretSound: AppConstant.str4Fr8));
    fretList.add(BoardModel(id: 51, string: 3, fret: 8, note: "D#", fretSound: AppConstant.str3Fr8));
    fretList.add(BoardModel(id: 52, string: 2, fret: 8, note: "G", fretSound:AppConstant.str2Fr8));
    fretList.add(BoardModel(id: 53, string: 1, fret: 8, note: "C", fretSound: AppConstant.str1Fr8));

    //FRET9
    fretList.add(BoardModel(id: 54, string: 6, fret: 9, note: "C#", fretSound:  AppConstant.str6Fr9));
    fretList.add(BoardModel(id: 55, string: 5, fret: 9, note: "F#", fretSound:  AppConstant.str5Fr9));
    fretList.add(BoardModel(id: 56, string: 4, fret: 9, note: "B", fretSound: AppConstant.str4Fr9));
    fretList.add(BoardModel(id: 57, string: 3, fret: 9, note: "E", fretSound: AppConstant.str3Fr9));
    fretList.add(BoardModel(id: 58, string: 2, fret: 9, note: "G#", fretSound:  AppConstant.str2Fr9));
    fretList.add(BoardModel(id: 59, string: 1, fret: 9, note: "C#", fretSound:  AppConstant.str1Fr9));

    //FRET10
    fretList.add(BoardModel(id: 60, string: 6, fret: 10, note: "D", fretSound:  AppConstant.str6Fr10));
    fretList.add(BoardModel(id: 61, string: 5, fret: 10, note: "G", fretSound:  AppConstant.str5Fr10));
    fretList.add(BoardModel(id: 62, string: 4, fret: 10, note: "C", fretSound:   AppConstant.str4Fr10));
    fretList.add(BoardModel(id: 63, string: 3, fret: 10, note: "F", fretSound:   AppConstant.str3Fr10));
    fretList.add(BoardModel(id: 64, string: 2, fret: 10, note: "A", fretSound:  AppConstant.str2Fr10));
    fretList.add(BoardModel(id: 65, string: 1, fret: 10, note: "D", fretSound:  AppConstant.str1Fr10));

    //FRET11
    fretList.add(BoardModel(id: 66, string: 6, fret: 11, note: "D#", fretSound:   AppConstant.str6Fr11));
    fretList.add(BoardModel(id: 67, string: 5, fret: 11, note: "G#", fretSound:   AppConstant.str5Fr11));
    fretList.add(BoardModel(id: 68, string: 4, fret: 11, note: "C#", fretSound:   AppConstant.str4Fr11));
    fretList.add(BoardModel(id: 69, string: 3, fret: 11, note: "F#", fretSound:   AppConstant.str3Fr11));
    fretList.add(BoardModel(id: 70, string: 2, fret: 11, note: "A#", fretSound:   AppConstant.str2Fr11));
    fretList.add(BoardModel(id: 71, string: 1, fret: 11, note: "D#", fretSound:   AppConstant.str1Fr11));

    //FRET12
    fretList.add(BoardModel(id: 72, string: 6, fret: 12, note: "E", fretSound:   AppConstant.str6Fr12));
    fretList.add(BoardModel(id: 73, string: 5, fret: 12, note: "A", fretSound:   AppConstant.str5Fr12));
    fretList.add(BoardModel(id: 74, string: 4, fret: 12, note: "D", fretSound:   AppConstant.str4Fr12));
    fretList.add(BoardModel(id: 75, string: 3, fret: 12, note: "G", fretSound:   AppConstant.str3Fr12));
    fretList.add(BoardModel(id: 76, string: 2, fret: 12, note: "B", fretSound:   AppConstant.str2Fr12));
    fretList.add(BoardModel(id: 77, string: 1, fret: 12, note: "E", fretSound:   AppConstant.str1Fr12));

    //FRET13
    fretList.add(BoardModel(id: 78, string: 6, fret: 13, note: "F", fretSound:    AppConstant.str6Fr13));
    fretList.add(BoardModel(id: 79, string: 5, fret: 13, note: "A#", fretSound:   AppConstant.str5Fr13));
    fretList.add(BoardModel(id: 80, string: 4, fret: 13, note: "D#", fretSound:   AppConstant.str4Fr13));
    fretList.add(BoardModel(id: 81, string: 3, fret: 13, note: "G#", fretSound:   AppConstant.str3Fr13));
    fretList.add(BoardModel(id: 82, string: 2, fret: 13, note: "C", fretSound:    AppConstant.str2Fr13));
    fretList.add(BoardModel(id: 83, string: 1, fret: 13, note: "F", fretSound:    AppConstant.str1Fr13));

    //FRET14
    fretList.add(BoardModel(id: 84, string: 6, fret: 14, note: "F#", fretSound:   AppConstant.str6Fr14));
    fretList.add(BoardModel(id: 85, string: 5, fret: 14, note: "B", fretSound:  AppConstant.str5Fr14));
    fretList.add(BoardModel(id: 86, string: 4, fret: 14, note: "E", fretSound:  AppConstant.str4Fr14));
    fretList.add(BoardModel(id: 87, string: 3, fret: 14, note: "A", fretSound:  AppConstant.str3Fr14));
    fretList.add(BoardModel(id: 88, string: 2, fret: 14, note: "C#", fretSound:   AppConstant.str2Fr14));
    fretList.add(BoardModel(id: 89, string: 1, fret: 14, note: "F#", fretSound:   AppConstant.str1Fr14));

    //FRET15
    fretList.add(BoardModel(id: 90, string: 6, fret: 15, note: "G", fretSound: AppConstant.str6Fr15));
    fretList.add(BoardModel(id: 91, string: 5, fret: 15, note: "C", fretSound:  AppConstant.str5Fr15));
    fretList.add(BoardModel(id: 92, string: 4, fret: 15, note: "F", fretSound:  AppConstant.str4Fr15));
    fretList.add(BoardModel(id: 93, string: 3, fret: 15, note: "A#", fretSound:  AppConstant.str3Fr15));
    fretList.add(BoardModel(id: 94, string: 2, fret: 15, note: "D", fretSound: AppConstant.str2Fr15));
    fretList.add(BoardModel(id: 95, string: 1, fret: 15, note: "G", fretSound: AppConstant.str1Fr15));

  }



  // set sounds to sound list
  setSoundList(){
    fretList.clear();
  }

  int? selectedFret;
  String? selectedNote;
  int? selectedString;

  String? userName;

  getUserName()async {
    var userName  =  await LocalDB.getUserName;
    print("THE USER NAME IS $userName");
  }

  // Initialize  animation controller
  initializeData()async{
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
     timer =  null;
     //isTimerSet = false;
     secondsRemaining.value = 0;
     timerMode = false;
     leaderboardMode  = false;
     await loadFullList();
     await getUserName();
     update();
  }

  // PLAY SOUND ACCORDING TO SELECTED NOTES , STRING AND FRET
  Future playSound(int index,String note,int str)async{

     // STOP SOUND IF PLAYING
       await player.stop();

       // EXECUTE LOOP
      fretList.forEach((element) async {
        // if(element.id == index){
        if(element.id == index){
          // GET ALLOW STRING STATUS
          final stringStatus = getStringStatus(element.string!);

          // CHECK IF THE STATUS IS TRUE AND GAME IS START
          // THEN WE WILL HIGHLIGHT THINGS
          if(stringStatus == true && isStart == true){
            selectedFret = index;
            selectedString = str;
            selectedNote = note;

            print("Highlight note: $highlightNode");
            print("selected note: $selectedNote");

            print("Highlight string: $highlightString");
            print("selected string : $selectedString");

            print("highlight fret : $highlightFret");
            print("selected fret : $selectedFret");

            await player.play(AssetSource(element.fretSound!));
            if(highlightNode == selectedNote  && selectedString == highlightString ){
              previousHighlightFret = highlightFret;
              previousHighlightNode = highlightNode;
              incrementScore();
              highLightTheGame();
            }else{
              decrementScore();
            }
             update();
          }else{
            await player.play(AssetSource(element.fretSound!));
          }
          return;
        }
      });
  }

  // SCALE FOR ORIENTATION ANIMATION
  double scale  = 1 ;
  bool isPortrait = true;

  void toggleOrientation() {

    scale  = 0.5;
    Future.delayed(const Duration(milliseconds: 100),(){
      isPortrait = !isPortrait;
      update();
    });
    Future.delayed(const Duration(milliseconds: 300),(){
      scale  = 1;
      update();
    });

  }

  // SCORE
  // Correct  and Incorrect
  // Correct increment , incorrect decrement
  int score = 0;

  incrementScore(){
    score = score +1;
    update();
  }

  decrementScore(){
    score = score -1;
    update();
  }


 //Modes

  bool timerMode = false;
  bool leaderboardMode = false;


  setTimerMode(bool mode){
    timerMode = mode;
    update();
  }


  setLeaderMode(bool mode){
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
 highLightTheGame(){
  // Get randomly highlight node
  int randomIndex = getRandomIndex();
  highlightFret = randomIndex;
  highlightNode = fretList[randomIndex].note;
  highlightString = fretList[randomIndex].string;
  print("Highlight note ========>>>>: $highlightNode");
  print("Highlight fret ========>>>>: $highlightFret");
  print("Highlight string ========>>>>: $highlightString");
  update();
}

// GET RANDOM INDEX ACCORDING TO  ALLOW STRING
 getRandomIndex() {
    Random random = Random();
    int randomIndex;
    do {
      randomIndex = random.nextInt(fretList.length);
    } while (getStringStatus(fretList[randomIndex].string!) == false );
    return randomIndex;

  }

  // START THE GAME ON START BUTTON
  startTheGame(){
    isStart = true;
    int randomIndex = getRandomIndex();
    highlightFret = randomIndex;
    previousHighlightFret = highlightFret;
    previousHighlightNode = highlightNode;
    highlightNode = fretList[randomIndex].note;
    highlightString = fretList[randomIndex].string;
    print("Highlight note ========>>>>: $highlightNode");
    print("Highlight fret ========>>>>: $highlightFret");
    print("Highlight string ========>>>>: $highlightString");
    update();
  }
// TIMER


 // int secondsRemaining = 0; // Initial countdown time in seconds
  Timer? timer;
 // bool isTimerSet = false;


  increaseTime(){
    if (isStart != true){
      secondsRemaining.value = secondsRemaining.value+10;
      update();
    }

  }
  decreaseTime(){
    if(secondsRemaining.value>10 && isStart != true ){
      secondsRemaining.value = secondsRemaining.value-10;
      update();
    }
  }

  resetGame(bool resetAll){
    if(timer != null){
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
    timer =  null;

    if(resetAll == true){
      if(timerMode == true){
        timerMode = false;
      }else{
        leaderboardMode = false;
      }
    }
    update();
  }

  resetTimer(){
    //isTimerSet = true;
    if(timerMode == true){
      secondsRemaining.value = 60;
    }else if(leaderboardMode == true){
      secondsRemaining.value = 120;
    }else{
      secondsRemaining.value = 0;
    }
    update();
  }

  startTimer(){
    // if(isTimerSet == true){
    //   startCountDownTimer();
    // }else{
    //   startCountUpTimer();
    // }

    if(timerMode == true){
      startCountDownTimer();
    }
    if(leaderboardMode == true){
      offString  = [true,true,true,true,true,true];
      string1 = true;
      string2 = true;
      string3 = true;
      string4 = true;
      string5 = true;
      string6 = true;
      notifyChildrens();
      startLeaderBoardCountDownTimer();
    }
    else{
      startCountUpTimer();
    }

  }


  String formatTime(int seconds) {
    // Format the remaining time as mm:ss
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';

  }

  // GET STRING STATUS WHICH STRING IS ALLOW
bool getStringStatus(int id){

    if(string1 == true && id == 1){
      return true;
    }
    else if(string2 == true && id == 2){
      return true;
    }
    else if(string3 == true && id == 3){
      return true;
    }
    else if(string4 == true && id == 4){
      return true;
    }
    else if(string5 == true && id == 5){
      return true;
    }
    else if(string6 == true && id == 6){
     return true;
    }
    else{
      return false;
    }

  }


  List offString  = [true,true,true,true,true,true];

  //STRING TOGGLES
  // STRING 1
  bool string1 = true;
  setString1(int index){
    string1 = !string1;
    offString[index] = string1;
    if(!offString.contains(true)){
      offString[index] = true;
      string1 = true;
    }
    update();}

  // STRING 2
  bool string2 = true;
  setString2(int index){
    string2 = !string2;
    offString[index] = string2;
    if(!offString.contains(true)){
      offString[index] = true;
      string2 = true;
    }
    update();}

  // STRING 3
  bool string3 = true;
  setString3(int index){
    string3 = !string3;
    offString[index] = string3;
    if(!offString.contains(true)){
      offString[index] = true;
      string3 = true;
    }
    update();}

  // STRING 4
  bool string4 = true;
  setString4(int index){
    string4 = !string4;
    offString[index] = string4;
    if(!offString.contains(true)){
      offString[index] = true;
      string4 = true;
    }
    update();}

  // STRING 5
  bool string5 = true;
  setString5(int index){
    string5 = !string5;
    offString[index] = string5;
    if(!offString.contains(true)){
      offString[index] = true;
      string5 = true;
    }
    update();}

  // STRING 6
  bool string6 = true;
  setString6(int index){

    string6 = !string6;
    offString[index] = string6;
    if(!offString.contains(true)){
      offString[index] = true;
      string6 = true;
    }
    update();}

  // Value Notifier listener

  ValueNotifier<int> secondsRemaining = ValueNotifier(0);



  startLeaderBoardCountDownTimer() {
    if(secondsRemaining.value == 0){
      secondsRemaining.value = 120;
    }
    update();
    if(timer != null){
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

      }
    });
  }

  startCountDownTimer() {
    if(secondsRemaining.value == 0){
      secondsRemaining.value = 60;
    }
    update();
    if(timer != null){
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
    if(timer != null){
      timer!.cancel();
    }
    // Create a timer that runs every second
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Update the UI and decrement the remaining seconds
      secondsRemaining.value++;
    });
  }


  ApiTriggers api = ApiTriggers();
  Future<dynamic> updateScore(score) async {
    var response = await api.updateScore("FretboardTrainer", userName, score);
    print(response);
    return response;
  }


}
