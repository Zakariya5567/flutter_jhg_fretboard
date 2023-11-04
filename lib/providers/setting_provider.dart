import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:tempo_bpm/db/local_db.dart';
import 'package:tempo_bpm/model/sound_model.dart';
import 'package:tempo_bpm/utils/app_constant.dart';


//The MetroProvider class is responsible for managing the metronome functionality,
// controlling BPM, animation, and sound playback.

class SettingProvider extends ChangeNotifier{


  bool string1 = true;
  setString1(){
    string1 = !string1;
    notifyListeners();
  }

  bool string2 = true;
  setString2(){
    string2 = !string2;
    notifyListeners();
  }


  bool string3 = true;
  setString3(){
    string3 = !string3;
    notifyListeners();
  }


  bool string4 = true;
  setString4(){
    string4 = !string4;
    notifyListeners();
  }


  bool string5 = true;
  setString5(){
    string5 = !string5;
    notifyListeners();
  }


  bool string6 = true;
  setString6(){
    string6 = !string6;
    notifyListeners();
  }

}

