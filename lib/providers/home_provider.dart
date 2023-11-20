import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import '../model/board_model.dart';
import '../utils/app_constant.dart';

class HomeProvider extends ChangeNotifier{

  // Instance of the Player
  final player = AudioPlayer();

  // List of sound list
  List<BoardModel> fretList = [];

  Future<void> loadFullList() async {

    fretList.clear();

    //FRET0
    fretList.add(BoardModel(id: 0, string: 1, fret: 0, note: "E", fretSound: AppConstant.str1Fr0));
    fretList.add(BoardModel(id: 1, string: 2, fret: 0, note: "B", fretSound: AppConstant.str2Fr0));
    fretList.add(BoardModel(id: 2, string: 3, fret: 0, note: "G", fretSound: AppConstant.str3Fr0));
    fretList.add(BoardModel(id: 3, string: 4, fret: 0, note: "D", fretSound: AppConstant.str4Fr0));
    fretList.add(BoardModel(id: 4, string: 5, fret: 0, note: "A", fretSound: AppConstant.str5Fr0));
    fretList.add(BoardModel(id: 5, string: 6, fret: 0, note: "E", fretSound: AppConstant.str6Fr0));

    //FRET1
    fretList.add(BoardModel(id: 6, string: 1, fret: 1, note:  "F", fretSound: AppConstant.str1Fr1));
    fretList.add(BoardModel(id: 7, string: 2, fret: 1, note:  "C", fretSound: AppConstant.str2Fr1));
    fretList.add(BoardModel(id: 8, string: 3, fret: 1, note:  "G#", fretSound: AppConstant.str3Fr1));
    fretList.add(BoardModel(id: 9, string: 4, fret: 1, note:  "D#", fretSound: AppConstant.str4Fr1));
    fretList.add(BoardModel(id: 10, string: 5, fret: 1, note: "A#", fretSound: AppConstant.str5Fr1));
    fretList.add(BoardModel(id: 11, string: 6, fret: 1, note: "F", fretSound: AppConstant.str6Fr1));

    //FRET2
    fretList.add(BoardModel(id: 12, string: 1, fret: 2, note: "F#", fretSound: AppConstant.str1Fr2));
    fretList.add(BoardModel(id: 13, string: 2, fret: 2, note: "C#", fretSound: AppConstant.str2Fr2));
    fretList.add(BoardModel(id: 14, string: 3, fret: 2, note: "A", fretSound: AppConstant.str3Fr2));
    fretList.add(BoardModel(id: 15, string: 4, fret: 2, note: "E", fretSound: AppConstant.str4Fr2));
    fretList.add(BoardModel(id: 16, string: 5, fret: 2, note: "B", fretSound: AppConstant.str5Fr2));
    fretList.add(BoardModel(id: 17, string: 6, fret: 2, note: "F#", fretSound: AppConstant.str6Fr2));

    //FRET3
    fretList.add(BoardModel(id: 18, string: 1, fret: 3, note: "G", fretSound: AppConstant.str1Fr3));
    fretList.add(BoardModel(id: 19, string: 2, fret: 3, note: "D", fretSound: AppConstant.str2Fr3));
    fretList.add(BoardModel(id: 20, string: 3, fret: 3, note: "A", fretSound: AppConstant.str3Fr3));
    fretList.add(BoardModel(id: 21, string: 4, fret: 3, note: "F", fretSound: AppConstant.str4Fr3));
    fretList.add(BoardModel(id: 22, string: 5, fret: 3, note: "C", fretSound: AppConstant.str5Fr3));
    fretList.add(BoardModel(id: 23, string: 6, fret: 3, note: "G", fretSound: AppConstant.str6Fr3));

    //FRET4
    fretList.add(BoardModel(id: 24, string: 1, fret: 4, note: "G#", fretSound: AppConstant.str1Fr4));
    fretList.add(BoardModel(id: 25, string: 2, fret: 4, note: "D#", fretSound: AppConstant.str2Fr4));
    fretList.add(BoardModel(id: 26, string: 3, fret: 4, note: "B", fretSound: AppConstant.str3Fr4));
    fretList.add(BoardModel(id: 27, string: 4, fret: 4, note: "F#", fretSound: AppConstant.str4Fr4));
    fretList.add(BoardModel(id: 28, string: 5, fret: 4, note: "C#", fretSound: AppConstant.str5Fr4));
    fretList.add(BoardModel(id: 29, string: 6, fret: 4, note: "G#", fretSound: AppConstant.str6Fr4));

    //FRET5
    fretList.add(BoardModel(id: 30, string: 1, fret: 5, note: "A", fretSound: AppConstant.str1Fr5));
    fretList.add(BoardModel(id: 31, string: 2, fret: 5, note: "E", fretSound: AppConstant.str2Fr5));
    fretList.add(BoardModel(id: 32, string: 3, fret: 5, note: "C", fretSound:  AppConstant.str3Fr5));
    fretList.add(BoardModel(id: 33, string: 4, fret: 5, note: "G", fretSound: AppConstant.str4Fr5));
    fretList.add(BoardModel(id: 34, string: 5, fret: 5, note: "D", fretSound: AppConstant.str5Fr5));
    fretList.add(BoardModel(id: 35, string: 6, fret: 5, note: "A", fretSound: AppConstant.str6Fr5));

    //FRET6
    fretList.add(BoardModel(id: 36, string: 1, fret: 6, note: "A#", fretSound: AppConstant.str1Fr6));
    fretList.add(BoardModel(id: 37, string: 2, fret: 6, note: "F", fretSound: AppConstant.str2Fr6));
    fretList.add(BoardModel(id: 38, string: 3, fret: 6, note: "C#", fretSound: AppConstant.str3Fr6));
    fretList.add(BoardModel(id: 39, string: 4, fret: 6, note: "G#", fretSound: AppConstant.str4Fr6));
    fretList.add(BoardModel(id: 40, string: 5, fret: 6, note: "D#", fretSound: AppConstant.str5Fr6));
    fretList.add(BoardModel(id: 41, string: 6, fret: 6, note: "A#", fretSound: AppConstant.str6Fr6));

    //FRET7
    fretList.add(BoardModel(id: 42, string: 1, fret: 7, note: "B", fretSound: AppConstant.str1Fr7));
    fretList.add(BoardModel(id: 43, string: 2, fret: 7, note: "F#", fretSound:  AppConstant.str2Fr7));
    fretList.add(BoardModel(id: 44, string: 3, fret: 7, note: "D", fretSound: AppConstant.str3Fr7));
    fretList.add(BoardModel(id: 45, string: 4, fret: 7, note: "A", fretSound: AppConstant.str4Fr7));
    fretList.add(BoardModel(id: 46, string: 5, fret: 7, note: "E", fretSound: AppConstant.str5Fr7));
    fretList.add(BoardModel(id: 47, string: 6, fret: 7, note: "B", fretSound: AppConstant.str6Fr7));

    //FRET8
    fretList.add(BoardModel(id: 48, string: 1, fret: 8, note: "C", fretSound: AppConstant.str1Fr8));
    fretList.add(BoardModel(id: 49, string: 2, fret: 8, note: "G", fretSound:AppConstant.str2Fr8));
    fretList.add(BoardModel(id: 50, string: 3, fret: 8, note: "D#", fretSound: AppConstant.str3Fr8));
    fretList.add(BoardModel(id: 51, string: 4, fret: 8, note: "A#", fretSound: AppConstant.str4Fr8));
    fretList.add(BoardModel(id: 52, string: 5, fret: 8, note: "F", fretSound: AppConstant.str5Fr8));
    fretList.add(BoardModel(id: 53, string: 6, fret: 8, note: "C", fretSound: AppConstant.str6Fr8));

    //FRET9
    fretList.add(BoardModel(id: 54, string: 1, fret: 9, note: "C#", fretSound:  AppConstant.str1Fr9));
    fretList.add(BoardModel(id: 55, string: 2, fret: 9, note: "G#", fretSound:  AppConstant.str2Fr9));
    fretList.add(BoardModel(id: 56, string: 3, fret: 9, note: "E", fretSound: AppConstant.str3Fr9));
    fretList.add(BoardModel(id: 57, string: 4, fret: 9, note: "B", fretSound: AppConstant.str4Fr9));
    fretList.add(BoardModel(id: 58, string: 5, fret: 9, note: "F#", fretSound:  AppConstant.str5Fr9));
    fretList.add(BoardModel(id: 59, string: 6, fret: 9, note: "C#", fretSound:  AppConstant.str6Fr9));

    //FRET10
    fretList.add(BoardModel(id: 60, string: 1, fret: 10, note: "D", fretSound:  AppConstant.str1Fr10));
    fretList.add(BoardModel(id: 61, string: 2, fret: 10, note: "A", fretSound:  AppConstant.str2Fr10));
    fretList.add(BoardModel(id: 62, string: 3, fret: 10, note: "F", fretSound:   AppConstant.str3Fr10));
    fretList.add(BoardModel(id: 63, string: 4, fret: 10, note: "C", fretSound:   AppConstant.str4Fr10));
    fretList.add(BoardModel(id: 64, string: 5, fret: 10, note: "G", fretSound:  AppConstant.str5Fr10));
    fretList.add(BoardModel(id: 65, string: 6, fret: 10, note: "D", fretSound:  AppConstant.str6Fr10));

    //FRET11
    fretList.add(BoardModel(id: 66, string: 1, fret: 11, note: "D#", fretSound:   AppConstant.str1Fr11));
    fretList.add(BoardModel(id: 67, string: 2, fret: 11, note: "A#", fretSound:   AppConstant.str2Fr11));
    fretList.add(BoardModel(id: 68, string: 3, fret: 11, note: "F#", fretSound:   AppConstant.str3Fr11));
    fretList.add(BoardModel(id: 69, string: 4, fret: 11, note: "C#", fretSound:   AppConstant.str4Fr11));
    fretList.add(BoardModel(id: 70, string: 5, fret: 11, note: "G#", fretSound:   AppConstant.str5Fr11));
    fretList.add(BoardModel(id: 71, string: 6, fret: 11, note: "D#", fretSound:   AppConstant.str6Fr11));

    //FRET12
    fretList.add(BoardModel(id: 72, string: 1, fret: 12, note: "E", fretSound:   AppConstant.str1Fr12));
    fretList.add(BoardModel(id: 73, string: 2, fret: 12, note: "B", fretSound:   AppConstant.str2Fr12));
    fretList.add(BoardModel(id: 74, string: 3, fret: 12, note: "G", fretSound:   AppConstant.str3Fr12));
    fretList.add(BoardModel(id: 75, string: 4, fret: 12, note: "D", fretSound:   AppConstant.str4Fr12));
    fretList.add(BoardModel(id: 76, string: 5, fret: 12, note: "A", fretSound:   AppConstant.str5Fr12));
    fretList.add(BoardModel(id: 77, string: 6, fret: 12, note: "E", fretSound:   AppConstant.str6Fr12));

    //FRET13
    fretList.add(BoardModel(id: 78, string: 1, fret: 13, note: "F", fretSound:    AppConstant.str1Fr13));
    fretList.add(BoardModel(id: 79, string: 2, fret: 13, note: "C", fretSound:    AppConstant.str2Fr13));
    fretList.add(BoardModel(id: 80, string: 3, fret: 13, note: "G#", fretSound:   AppConstant.str3Fr13));
    fretList.add(BoardModel(id: 81, string: 4, fret: 13, note: "D#", fretSound:   AppConstant.str4Fr13));
    fretList.add(BoardModel(id: 82, string: 5, fret: 13, note: "A#", fretSound:   AppConstant.str5Fr13));
    fretList.add(BoardModel(id: 83, string: 6, fret: 13, note: "F", fretSound:    AppConstant.str6Fr13));

    //FRET14
    fretList.add(BoardModel(id: 84, string: 1, fret: 14, note: "F#", fretSound:   AppConstant.str1Fr14));
    fretList.add(BoardModel(id: 85, string: 2, fret: 14, note: "C#", fretSound:   AppConstant.str2Fr14));
    fretList.add(BoardModel(id: 86, string: 3, fret: 14, note: "A", fretSound:  AppConstant.str3Fr14));
    fretList.add(BoardModel(id: 87, string: 4, fret: 14, note: "E", fretSound:  AppConstant.str4Fr14));
    fretList.add(BoardModel(id: 88, string: 5, fret: 14, note: "B", fretSound:  AppConstant.str5Fr14));
    fretList.add(BoardModel(id: 89, string: 6, fret: 14, note: "F#", fretSound:   AppConstant.str6Fr14));

    //FRET15
    fretList.add(BoardModel(id: 90, string: 1, fret: 15, note: "G", fretSound: AppConstant.str1Fr15));
    fretList.add(BoardModel(id: 91, string: 2, fret: 15, note: "D", fretSound: AppConstant.str2Fr15));
    fretList.add(BoardModel(id: 92, string: 3, fret: 15, note: "A#", fretSound:  AppConstant.str3Fr15));
    fretList.add(BoardModel(id: 93, string: 4, fret: 15, note: "F", fretSound:  AppConstant.str4Fr15));
    fretList.add(BoardModel(id: 94, string: 5, fret: 15, note: "C", fretSound:  AppConstant.str5Fr15));
    fretList.add(BoardModel(id: 95, string: 6, fret: 15, note: "G", fretSound: AppConstant.str6Fr15));

  }


  // set sounds to sound list
  setSoundList(){
    fretList.clear();
  }

  int? selectedFret;

  // Initialize  animation controller
  initializeData()async{
     isStart = false;
     selectedFret = null;
     highlightFret = null;
     highlightString = null;
     highlightNode = null;
     previousHighlightFret = null;
    await loadFullList();
    notifyListeners();
  }

  // PLAY SOUND ACCORDING TO SELECTED NOTES , STRING AND FRET
  Future playSound(int index)async{

    // STOP SOUND IF PLAYING
       await player.stop();

       // EXECUTE LOOP
      fretList.forEach((element) async {
        if(element.id == index){
          // GET ALLOW STRING STATUS
          final stringStatus = getStringStatus(element.string!);

          // CHECK IF THE STATUS IS TRUE AND GAME IS START
          // THEN WE WILL HIGHLIGHT THINGS
          if(stringStatus == true && isStart == true){
            selectedFret = index;
            print("selected fret : $selectedFret");
            notifyListeners();
            await player.play(AssetSource(element.fretSound!));
            if(highlightFret == selectedFret){
              previousHighlightFret = highlightFret;
              restartTheGame();
            }
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
         notifyListeners();
       });
       Future.delayed(const Duration(milliseconds: 300),(){
         scale  = 1;
         notifyListeners();
      });

  }


  // START THE GAME
  // SELECT AND HIGHLIGHT STRING, FRET AND NOTE
  bool isStart = false;
  int? highlightFret;
  int? highlightString;
  String? highlightNode;
  int? previousHighlightFret;

  // WHEN PRESS CORRECT NOTE THEN HIGHLIGHT ANOTHER ONE TO SELECT
restartTheGame(){
  int randomIndex = getRandomIndex();
  highlightFret = randomIndex;
  print("Highlight fret: $highlightFret");
  highlightNode = fretList[randomIndex].note;
  highlightString = fretList[randomIndex].string;
  notifyListeners();
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
    print("Highlight fret: $highlightFret");
    highlightNode = fretList[randomIndex].note;
    highlightString = fretList[randomIndex].string;
    notifyListeners();
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

  //STRING TOGGLES
  // STRING 1
  bool string1 = true;
  setString1(){
    string1 = !string1;
    notifyListeners();}

  // STRING 2
  bool string2 = true;
  setString2(){
    string2 = !string2;
    notifyListeners();}

  // STRING 3
  bool string3 = true;
  setString3(){
    string3 = !string3;
    notifyListeners();}

  // STRING 4
  bool string4 = true;
  setString4(){
    string4 = !string4;
    notifyListeners();}

  // STRING 5
  bool string5 = true;
  setString5(){
    string5 = !string5;
    notifyListeners();}

  // STRING 6
  bool string6 = true;
  setString6(){
    string6 = !string6;
    notifyListeners();}

}

