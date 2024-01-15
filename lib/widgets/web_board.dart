import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fretboard/controllers/home_controller.dart';
import 'package:fretboard/widgets/guitar_board.dart';
import 'package:fretboard/screens/setting_screen/setting_screen.dart';
import 'package:fretboard/utils/images.dart';
import 'package:fretboard/widgets/button_icon.dart';
import 'package:fretboard/widgets/web_guitar_board.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import '../screens/leader_board_screen/leaderboard_screen.dart';
import '../utils/app_ colors.dart';
import '../utils/app_constant.dart';
import 'add_sub_button.dart';


class WebBoard extends StatelessWidget {
  const WebBoard({super.key,required this.controller});

  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return
      Padding(
        padding: EdgeInsets.only(top: 5.h ,),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TROPHY AND SETTING ICON
              Padding(
                padding:  EdgeInsets.only(
                  left: 3.w, right: 3.w,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonIcon(
                        icon: Images.iconTropy,
                        width: 2.5.w,
                        height: 2.5.w,
                        onTap: (){
                          Get.to(() => LeadershipScreen(),
                              transition: Transition.leftToRight);
                        }),
                    ButtonIcon(
                      icon:Images.iconSetting,
                      color: controller.leaderboardMode == true ? AppColors.greySecondary :
                      AppColors.whitePrimary,
                      width: 3.w,
                      height: 3.w,
                      onTap: (){

                        if(controller.leaderboardMode == true){
                          return ;
                        }else{
                          controller.resetGame(false);
                          Get.to(() => SettingScreen(),
                              transition: Transition.rightToLeft);
                        }

                      },)
                  ],
                ),
              ),
              //SPACER
              SizedBox(
                height:50,
              ),
              // BOARD WITH NUMBER
              Container(
                  height: 465,
                  width: 80.w,
                  child: const WebGuitarBoard()),
              //SPACER
              SizedBox(
                height:20,
              ),
              // TIMER  WITH ADD AND SUBTRACT BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.timerMode == true ?
                  WebAddAndSubtractButton(
                      onTap: (){
                        controller.decreaseTime();
                      },
                      isAdd: false)
                      : const SizedBox(),
                  SizedBox(
                    width: 5.w,
                  ),
                  Center(
                    child:
                    ValueListenableBuilder<int>(
                      valueListenable: controller.secondsRemaining,
                      //widget.model.seconds,
                      builder: (context, value, child) {
                        return
                          Text(
                            controller.formatTime(value),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: AppConstant.sansFont,
                              color: AppColors.whitePrimary,
                              fontSize: 2.5.w,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  controller.timerMode == true ?

                  WebAddAndSubtractButton(
                      onTap: (){
                        controller.increaseTime();
                      },
                      isAdd: true)
                      : const SizedBox(),
                ],
              ),
              // //TIMER , STOPWATCH , ROTATE ICON
              SizedBox(
                height:7,
              ),


              Padding(
                padding:  EdgeInsets.only(
                  left: 3.w,
                  right: 3.w,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    controller.isStart == true ?
                    ButtonIcon(
                        icon: Images.iconReset,
                        width: 2.7.w,
                        height: 2.7.w,
                        onTap: (){
                          controller.setTimerMode(false);
                          controller.setLeaderMode(false);
                          controller.resetGame(false);
                        }) :

                  // ICON STOP WATCH
                    controller.timerMode == false && controller.leaderboardMode == false?
                    ButtonIcon(
                        icon: Images.iconStopwatch,
                        width: 2.7.w,
                        height: 2.7.w,
                        onTap: (){
                          controller.setTimerMode(true);
                          controller.setLeaderMode(false);
                          controller.resetTimer();
                        }):

                        // ICON TIMER
                    controller.timerMode == true?
                    ButtonIcon(
                        icon: Images.iconTimer,
                        width: 2.7.w,
                        height: 2.7.w,
                        onTap: (){
                          controller.setTimerMode(false);
                          controller.setLeaderMode(true);
                          controller.resetTimer();
                        }):

                        // ICON LEADERBOARD
                    controller.leaderboardMode == true ?
                    ButtonIcon(
                        icon:
                        Images.iconTropy,
                        width: 2.7.w,
                        height: 2.7.w,
                        onTap: (){
                          controller.setLeaderMode(false);
                          controller.setTimerMode(false);
                          controller.resetTimer();
                        }) : SizedBox(),

                    // HIGILITED NOTE
                    controller.isStart == true?
                    Container(
                      height:45,
                      width: 25.w,
                      alignment: Alignment.topCenter,
                      //color: Colors.red,
                      child: Text(
                        "    ${controller.highlightNode ?? ""}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppConstant.sansFont,
                          color: AppColors.redPrimary,
                          fontSize: 2.2.w,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ):

                    // START BUTTON
                    InkWell(
                      onTap: () {
                        controller.startTimer();
                        controller.startTheGame();
                      },
                      child: Center(
                        child:
                        Container(
                          width: 20.w,
                          height: 55,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.redPrimary,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            AppConstant.start,
                            style: TextStyle(
                              fontFamily: AppConstant.sansFont,
                              color: AppColors.whitePrimary,
                              fontSize: 1.8.w,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ROTATE ICON
                    ButtonIcon(
                        icon: Images.iconRotate,
                        width: 2.7.w,
                        height: 2.7.w,
                        onTap: (){
                          controller.toggleOrientation();
                        })
                  ],
                ),
              ),


              //SPACER
              SizedBox(height: 5),
              controller.isStart == true?

              // SCORE TEXT
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppConstant.scoreText,
                      style: TextStyle(
                        fontFamily: AppConstant.sansFont,
                        color: AppColors.whitePrimary,
                        fontSize: 1.8.w,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      controller.score.toString(),
                      style: TextStyle(
                        fontFamily: AppConstant.sansFont,
                        color: AppColors.whitePrimary,
                        fontSize: 1.8.w,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ) : const  SizedBox(),
            ],
          ),
        ),
      );
  }
}


