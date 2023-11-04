import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tempo_bpm/model/sound_model.dart';

class HomeProvider extends ChangeNotifier{


  // Instance of the Player
  final player = AudioPlayer();


  // List of sound list
  List <SoundModel> soundList = [];

  int selectedIndex = 0;

  // set sounds to sound list
  setSoundList(){
    soundList.clear();

   // soundList.add(SoundModel(id: 0, name: AppConstant.logic, beat1: AppConstant.logic1Sound, beat2: AppConstant.logic2Sound));

  }

  // Initialize  animation controller
  initializeAnimationController()async{
    setSoundList();
  }



  // Play sound
  Future playSound()async{
      // await player.setAsset(firstBeat);
      // await player.play();
  }

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

}

