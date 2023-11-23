import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tempo_bpm/screens/setting_screen.dart';
import 'package:tempo_bpm/utils/images.dart';
import 'package:tempo_bpm/widgets/button_icon.dart';
import '../providers/home_provider.dart';
import '../utils/app_ colors.dart';
import '../utils/app_constant.dart';
import 'guitar_board.dart';

class LandscapeBoard extends StatelessWidget {
  const LandscapeBoard({super.key,required this.controller});

  final HomeProvider controller;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return   AnimatedScale(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.linearToEaseOut,
      scale: 1,
      child: Padding(
          padding: EdgeInsets.only(
              top: height*0.068
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // TROPHY AND Timer ICON
              Padding(
                padding:  EdgeInsets.only( left: width * 0.08,
                  right: width * 0.1,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonIcon(
                        icon:
                        controller.isStart ?
                        Images.iconReset : Images.iconTimerLandscape,
                        width:  controller.isStart ? height*0.030 : height*0.034,
                        height: controller.isStart ? height*0.030 : height*0.034,
                        onTap: (){
                          if(controller.isStart){
                            controller.resetGame();
                          }else{
                            controller.resetTimer();
                          }

                        }),


                    ButtonIcon(
                        icon: Images.iconTrophyLandscape,
                        width: height*0.028,
                        height: height*0.028,
                        onTap: (){}),
                  ],
                ),
              ),

              //SPACER
              SizedBox(
                height: height*0.025,
              ),

              // BOARD

              Padding(
                padding:  EdgeInsets.only( left: width*0.04,),
                child: Container(
                  height: height*0.75,
                  width: width,
                  child: Row(
                    children: [

                         // START BUTTON
                        controller.isStart == true ? const SizedBox():
                        RotatedBox(
                            quarterTurns: 1,
                            child: InkWell(
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
                          ),

                      controller.isStart == false ?
                      SizedBox(width: width*0.01,)
                          :
                        const  SizedBox(),
                          // SCORE AND NOTE
                          controller.isStart == false ? const SizedBox():
                          Row(
                         children: [
                          RotatedBox(
                            quarterTurns: 1,
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppConstant.score,
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
                            ) ,
                          ),
                          RotatedBox(
                              quarterTurns: 1,
                              child:
                                  Text(
                                    controller.highlightNode ?? "",
                                    style: TextStyle(
                                      fontFamily: AppConstant.sansFont,
                                      color: AppColors.redPrimary,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),


                        ],
                      ),

                        // TIMER WITH INCREASE AND DECREASE BUTTON
                        RotatedBox(
                          quarterTurns: 1,
                          child:
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

                              ValueListenableBuilder<int>(
                                valueListenable: controller.secondsRemaining,
                                //widget.model.seconds,
                                builder: (context, value, child) {
                                  return
                                  Text(
                                    controller.formatTime(value),
                                    style: TextStyle(
                                      fontFamily: AppConstant.sansFont,
                                      color: AppColors.whitePrimary,
                                      fontSize: 36,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  );
                                },
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
                          )),


                       controller.isStart ?
                        SizedBox(width: width*0.04,)
                         :
                        SizedBox(width: width*0.06,),

                       // BOARD
                       Container(
                        //color: Colors.red,
                          height: height*0.74,
                          child: const GuitarBoard(isPortrait: false,)),


                    ],
                  ),
                ),
              ),




              //SPACER
              SizedBox(
                height: height*0.036,
              ),

              Padding(
                padding:  EdgeInsets.only( left: width * 0.1,
                  right: width * 0.08,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    ButtonIcon(
                        icon: Images.iconRotateLandscape,
                        width: height*0.04,
                        height: height*0.04,
                        onTap: (){
                          controller.toggleOrientation();
                        }),

                    ButtonIcon(
                        icon: Images.iconSettingLandscape,
                        width: height*0.035,
                        height: height*0.035,
                        onTap: (){
                          controller.resetGame();
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return const SettingScreen();
                          }));
                        }),

                  ],
                ),
              ),

            ],
          ),
        ),
    );
  }
}
