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
                        icon: Images.iconSetting,
                        width: height*0.038,
                        height: height*0.038,
                        onTap: (){
                          controller.resetGame();
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return const SettingScreen();
                          }));
                        })
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
                  GestureDetector(
                    onTap: (){
                      controller.decreaseTime();
                    },
                    child: Container(
                      height:height * 0.030,
                      width: height * 0.030,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:  AppColors.redPrimary,
                      ),
                      child: Center(
                          child:
                          Icon(Icons.remove,color: AppColors.whitePrimary,
                            size: height*0.025,)
                      ),
                    ),
                  ),
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
                  GestureDetector(
                    onTap: (){
                      controller.increaseTime();
                    },
                    child: Container(
                      height:height * 0.030,
                      width: height * 0.030,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:  AppColors.redPrimary,
                      ),
                      child: Center(
                          child:
                          Icon(Icons.add,color: AppColors.whitePrimary,
                          size: height*0.025,
                          )
                      ),
                    ),
                  ),
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

                    ButtonIcon(
                        icon:

                        controller.isStart ?
                        Images.iconReset : Images.iconTimer,
                        width:  controller.isStart ? height*0.030 : height*0.033,
                        height: controller.isStart ? height*0.030 : height*0.033,
                        onTap: (){
                          if(controller.isStart){
                            controller.resetGame();
                          }else{
                            controller.resetTimer();
                          }

                        }),

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
