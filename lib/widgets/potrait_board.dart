import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fretboard/controllers/home_controller.dart';
import 'package:fretboard/widgets/guitar_board.dart';
import 'package:fretboard/screens/setting_screen.dart';
import 'package:fretboard/utils/images.dart';
import 'package:fretboard/widgets/button_icon.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import '../screens/leaderboard_screen.dart';
import '../utils/app_ colors.dart';
import '../utils/app_constant.dart';
import 'add_sub_button.dart';

class PortraitBoard extends StatelessWidget {
  const PortraitBoard({super.key,required this.controller});

  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return
      AnimatedScale(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.linearToEaseOut,
        scale: 1,
        child: Padding(
          padding: EdgeInsets.only(
               top: height*0.072 ,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // TROPHY AND SETTING ICON
              Padding(
                padding:  EdgeInsets.only( left: width * 0.08,
                  right: width * 0.08,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonIcon(
                        icon: Images.iconTropy,
                        width: height*0.026,
                        height: height*0.026,
                        onTap: (){
                          Get.to(() => LeadershipScreen(),
                              transition: Transition.leftToRight);
                        }),
                    ButtonIcon(
                        icon:Images.iconSetting,
                        color: controller.leaderboardMode == true ? AppColors.greySecondary :
                        AppColors.whitePrimary,
                        width: height*0.038,
                        height: height*0.038,
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


              // //SPACER
              SizedBox(
                height: height*0.035,
              ),

              // BOARD WITH NUMBER


                  Padding(
                    padding:  EdgeInsets.only(left: width*0.070),
                    child: Container(
                        //color: Colors.red,
                        height:    controller.isStart == true? height*0.64
                        : height*0.64,
                        child: const GuitarBoard(isPortrait: true,)),
                  ),
                 //SPACER
                 SizedBox(
                 height: height*0.025,
                ),


              // TIMER
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.timerMode == true ?

                  AddAndSubtractButton(
                      onTap: (){
                        controller.decreaseTime();
                      },
                      isAdd: false)
              : const SizedBox(),
                  SizedBox(
                    width: width*0.050,
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
                              fontSize: 36,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                      },
                    ),
                  ),
                  SizedBox(
                    width: width*0.050,
                  ),
                  controller.timerMode == true ?

                  AddAndSubtractButton(
                      onTap: (){
                        controller.increaseTime();
                      },
                      isAdd: true)
               : const SizedBox(),
                ],
              ),
                  //: const SizedBox(),
              // //TIMER , STOPWATCH , ROTATE ICON
              SizedBox(
                height: height*0.010,
              ),
              Padding(
                padding:  EdgeInsets.only(
                  left: width * 0.08,
                  right: width * 0.08,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                   controller.isStart == true ?
                   ButtonIcon(
                       icon: Images.iconReset,
                        width: height*0.033,
                        height: height*0.033,
                        onTap: (){
                           controller.setTimerMode(false);
                           controller.setLeaderMode(false);
                           controller.resetGame(false);
                       }) :

                   controller.timerMode == false && controller.leaderboardMode == false?
                   ButtonIcon(
                       icon: Images.iconStopwatch,
                       width: height*0.035,
                       height: height*0.035,
                       onTap: (){
                         controller.setTimerMode(true);
                         controller.setLeaderMode(false);
                         controller.resetTimer();
                       }):

                   controller.timerMode == true?
                   ButtonIcon(
                       icon: Images.iconTimer,
                       width: height*0.035,
                       height: height*0.035,
                       onTap: (){
                         controller.setTimerMode(false);
                         controller.setLeaderMode(true);
                         controller.resetTimer();
                       }):

                   controller.leaderboardMode == true ?
                    ButtonIcon(
                       icon:
                        Images.iconTropy,
                        width:  height*0.035,
                        height:  height*0.035 ,
                        onTap: (){
                           controller.setLeaderMode(false);
                           controller.setTimerMode(false);
                           controller.resetTimer();
                       }) : SizedBox(),

                    controller.isStart == true?
                    Container(
                      height: height * 0.060,
                      width: width * 0.45,
                      alignment: Alignment.topCenter,
                      //color: Colors.red,
                      child: Text(
                        "    ${controller.highlightNode ?? ""}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppConstant.sansFont,
                          color: AppColors.redPrimary,
                          fontSize: 28,
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
                          height: height * 0.06,
                          width: width * 0.45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.redPrimary,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            AppConstant.start,
                            style: TextStyle(
                              fontFamily: AppConstant.sansFont,
                              color: AppColors.whitePrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),


                    ButtonIcon(
                        icon: Images.iconRotate,
                        width: height*0.05,
                        height: height*0.04,
                        onTap: (){
                          controller.toggleOrientation();
                        })
                  ],
                ),
              ),


              //SCORE

              controller.isStart == true?


              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppConstant.scoreText,
                      style: TextStyle(
                        fontFamily: AppConstant.sansFont,
                        color: AppColors.whitePrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      controller.score.toString(),
                      style: TextStyle(
                        fontFamily: AppConstant.sansFont,
                        color: AppColors.whitePrimary,
                        fontSize: 16,
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
