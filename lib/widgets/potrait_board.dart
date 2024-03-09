import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jhg_elements/jhg_elements.dart';
import 'package:fretboard/controllers/home_controller.dart';
import 'package:fretboard/widgets/guitar_board.dart';
import 'package:fretboard/screens/setting_screen/setting_screen.dart';
import 'package:fretboard/utils/images.dart';
import 'package:fretboard/widgets/button_icon.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import '../controllers/leaderboard_controller.dart';
import '../screens/leader_board_screen/leaderboard_screen.dart';
import '../utils/app_ colors.dart';
import '../utils/app_constant.dart';
import 'add_sub_button.dart';

class PortraitBoard extends StatelessWidget {
  const PortraitBoard({super.key, required this.controller});

  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AnimatedScale(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.linearToEaseOut,
      scale: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // TROPHY AND SETTING ICON
          JHGAppBar(
            leadingWidget: JHGIconButton(
              childPadding: EdgeInsets.all(3),
              size: 30,
              svgImg: Images.iconTropy,
              onTap: () {
                Get.to(() => LeadershipScreen(),
                    transition: Transition.leftToRight);
              },
            ),
            trailingWidget: JHGSettingsButton(
              onTap: () {
                if (controller.leaderboardMode == true) {
                  return;
                } else {
                  controller.resetGame(false);
                  Get.to(() => SettingScreen(),
                      transition: Transition.rightToLeft);
                }
              },
            ),
          ),
          Spacer(),

          // BOARD WITH NUMBER
          Padding(
            padding: EdgeInsets.only(left: width * 0.070),
            child: Container(
                //color: Colors.red,
                height:
                    controller.isStart == true ? height * 0.64 : height * 0.64,
                child: const GuitarBoard(
                  isPortrait: true,
                )),
          ),
          //SPACER
          Spacer(),

          // TIMER
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              controller.timerMode == true
                  ? AddAndSubtractButton(
                      onTap: () {
                        controller.decreaseTime();
                      },
                      isAdd: false)
                  : const SizedBox(),
              SizedBox(
                width: width * 0.050,
              ),
              Center(
                child: ValueListenableBuilder<int>(
                  valueListenable: controller.secondsRemaining,
                  //widget.model.seconds,
                  builder: (context, value, child) {
                    return Text(
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
                width: width * 0.050,
              ),
              controller.timerMode == true
                  ? AddAndSubtractButton(
                      onTap: () {
                        controller.increaseTime();
                      },
                      isAdd: true)
                  : const SizedBox(),
            ],
          ),
          //: const SizedBox(),
          // //TIMER , STOPWATCH , ROTATE ICON
          SizedBox(
            height: height * 0.010,
          ),
          JHGAppBar(
            crossAxisAlignment: CrossAxisAlignment.center,
            leadingWidget: controller.isStart == true
                ? JHGResetBtn(onTap: () {
                    controller.setTimerMode(false);
                    controller.setLeaderMode(false);
                    controller.resetGame(false);
                  })
                : controller.timerMode == false &&
                        controller.leaderboardMode == false
                    ? JHGIconButton(
                        size: 30,
                        svgImg: Images.iconStopwatch,
                        onTap: () {
                          controller.setTimerMode(true);
                          controller.setLeaderMode(false);
                          controller.resetTimer();
                        })
                    : controller.timerMode == true
                        ? JHGIconButton(
                            size: 30,
                            svgImg: Images.iconTimer,
                            onTap: () {
                              controller.setTimerMode(false);
                              controller.setLeaderMode(true);
                              controller.resetTimer();
                            })
                        : controller.leaderboardMode == true
                            ? JHGIconButton(
                                childPadding: EdgeInsets.all(3),
                                size: 30,
                                svgImg: Images.iconTropy,
                                onTap: () {
                                  controller.setLeaderMode(false);
                                  controller.setTimerMode(false);
                                  controller.resetTimer();
                                })
                            : SizedBox(),
            centerWidget: controller.isStart == true
                ? Container(
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
                  )
                : JHGPrimaryBtn(
                    label: AppConstant.start,
                    onPressed: () {
                      controller.startTimer();
                      controller.startTheGame();
                    },
                  ),
            trailingWidget: JHGIconButton(
                svgImg: Images.iconRotate,
                onTap: () {
                  controller.toggleOrientation();
                }),
          ),

          //SCORE

          controller.isStart == true
              ? Center(
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
                )
              : const SizedBox(
                  height: 23,
                ),
        ],
      ),
    );
  }
}
