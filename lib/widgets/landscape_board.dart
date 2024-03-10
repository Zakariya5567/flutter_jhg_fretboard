import 'package:flutter/material.dart';
import 'package:flutter_jhg_elements/jhg_elements.dart';
import 'package:fretboard/controllers/home_controller.dart';
import 'package:fretboard/screens/setting_screen/setting_screen.dart';
import 'package:fretboard/utils/images.dart';
import 'package:fretboard/widgets/add_sub_button.dart';
import 'package:get/get.dart';
import '../screens/leader_board_screen/leaderboard_screen.dart';
import '../utils/app_constant.dart';
import 'guitar_board.dart';

class LandscapeBoard extends StatelessWidget {
  const LandscapeBoard({super.key, required this.controller});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TROPHY AND Timer ICON
          Container(
            height: 30,
            //color: Colors.amber,
            child: Padding(
              padding: EdgeInsets.only(
                left: width * 0.08,
                right: width * 0.1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  controller.isStart == true
                      ? JHGResetBtn(onTap: () {
                          controller.setTimerMode(false);
                          controller.setLeaderMode(false);
                          controller.resetGame(false);
                        })
                      : controller.timerMode == false &&
                              controller.leaderboardMode == false
                          ? RotatedBox(
                              quarterTurns:
                                  controller.isPortrait == true ? 0 : 1,
                              child: JHGIconButton(
                                  size: 30,
                                  //childPadding: EdgeInsets.all(3),
                                  svgImg: Images.iconStopwatchLandscape,
                                  onTap: () {
                                    controller.setTimerMode(true);
                                    controller.resetTimer();
                                  }),
                            )
                          : controller.timerMode == true
                              ? JHGIconButton(
                                  svgImg: Images.iconTimerLandscape,
                                  onTap: () {
                                    controller.setTimerMode(false);
                                    controller.setLeaderMode(true);
                                    controller.resetTimer();
                                  })
                              : controller.leaderboardMode == true
                                  ? JHGIconButton(
                                      svgImg: Images.iconTrophyLandscape,
                                      onTap: () {
                                        controller.setLeaderMode(false);
                                        controller.setTimerMode(false);
                                        controller.resetTimer();
                                      })
                                  : SizedBox(),
                  JHGIconButton(
                      svgImg: Images.iconTrophyLandscape,
                      onTap: () {
                        Get.to(() => LeadershipScreen(),
                            transition: Transition.leftToRight);
                      }),
                ],
              ),
            ),
          ),

          //SPACER
          SizedBox(
            height: height * 0.025,
          ),

          // BOARD

          Container(
            //color: Colors.blueGrey,
            height: height * 0.75,
            width: width,
            child: Row(
              children: [
                Spacer(),
                // START BUTTON
                controller.isStart == true
                    ? const SizedBox()
                    : RotatedBox(
                        quarterTurns: 1,
                        child: JHGPrimaryBtn(
                          label: AppConstant.start,
                          width: width * 0.45,
                          onPressed: () {
                            controller.startTimer();
                            controller.startTheGame();
                          },
                        ),
                      ),

                controller.isStart == false
                    ? SizedBox(
                        width: width * 0.01,
                      )
                    : const SizedBox(),
                // SCORE AND NOTE
                controller.isStart == false
                    ? const SizedBox()
                    : Row(
                        children: [
                          RotatedBox(
                            quarterTurns: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppConstant.scoreText,
                                  style: TextStyle(
                                    fontFamily: AppConstant.sansFont,
                                    color: JHGColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  controller.score.toString(),
                                  style: TextStyle(
                                    fontFamily: AppConstant.sansFont,
                                    color: JHGColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RotatedBox(
                              quarterTurns: 1,
                              child: Text(
                                controller.highlightNode ?? "",
                                style: TextStyle(
                                  fontFamily: AppConstant.sansFont,
                                  color: JHGColors.primary,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      ),
                Spacer(),
                // TIMER WITH INCREASE AND DECREASE BUTTON
                Container(
                  //color: Colors.yellow,
                  child: RotatedBox(
                      quarterTurns: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          controller.timerMode == true
                              ? AddAndSubtractButton(
                                  onTap: () {
                                    controller.decreaseTime();
                                  },
                                  isAdd: false)
                              : SizedBox(),
                          SizedBox(
                            width: width * 0.050,
                          ),
                          ValueListenableBuilder<int>(
                            valueListenable: controller.secondsRemaining,
                            //widget.model.seconds,
                            builder: (context, value, child) {
                              return Text(
                                controller.formatTime(value),
                                style: TextStyle(
                                  fontFamily: AppConstant.sansFont,
                                  color: JHGColors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                ),
                              );
                            },
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
                              : SizedBox(),
                        ],
                      )),
                ),

                Spacer(),
                // controller.isStart ?
                //  SizedBox(width: width*0.04,)
                //   :
                //  SizedBox(width: width*0.06,),

                // BOARD
                Container(
                    //color: Colors.blue,
                    height: height * 0.74,
                    child: const GuitarBoard(
                      isPortrait: false,
                    )),
                Spacer(),
              ],
            ),
          ),

          //SPACER
          SizedBox(
            height: height * 0.036,
          ),

          Container(
            //color: Colors.green,
            height: 30,
            child: Padding(
              padding: EdgeInsets.only(
                left: width * 0.1,
                right: width * 0.08,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  JHGIconButton(
                      svgImg: Images.iconRotateLandscape,
                      onTap: () {
                        controller.toggleOrientation();
                      }),
                  JHGIconButton(
                    svgImg: Images.iconSetting,
                    iconColor: controller.leaderboardMode == true
                        ? JHGColors.whiteGrey
                        : JHGColors.white,
                    onTap: () {
                      if (controller.leaderboardMode == true) {
                        return;
                      } else {
                        controller.resetGame(false);

                        Get.to(() => SettingScreen(),
                            transition: Transition.rightToLeft);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
