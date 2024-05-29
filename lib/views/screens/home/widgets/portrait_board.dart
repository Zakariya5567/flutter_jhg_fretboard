import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jhg_elements/jhg_elements.dart';
import 'package:fretboard/app_utils/app_assets.dart';
import 'package:fretboard/app_utils/app_strings.dart';
import 'package:fretboard/controllers/home_controller.dart';
import 'package:fretboard/views/screens/home/widgets/guitar_board.dart';
import 'package:fretboard/views/screens/leader_board/leaderboard_screen.dart';
import 'package:fretboard/views/screens/setting/setting_screen.dart';
import 'package:fretboard/views/widgets/add_sub_button.dart';
import 'package:get/get.dart';

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
            isResponsive: true,
            leadingWidget: JHGIconButton(
              childPadding: EdgeInsets.all(3),
              size: 30,
              svgImg: AppAssets.iconTropy,
              onTap: () {
                controller.interstitialAd?.showInterstitial();
                Get.to(() => LeadershipScreen(),
                    transition: Transition.leftToRight);
              },
            ),
            trailingWidget: JHGSettingsOptBtn(
              btnEnabled: !controller.leaderboardMode,
              onTap: () {
                controller.resetGame(false);
                controller.interstitialAd?.showInterstitial();
                Get.to(() => SettingScreen(),
                    transition: Transition.rightToLeft);
              },
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),

          // BOARD WITH NUMBER
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: width * 0.070),
              child: Container(
                  //color: Colors.red,
                  child: const GuitarBoard(
                isPortrait: true,
              )),
            ),
          ),
          //SPACER
          SizedBox(
            height: height * 0.02,
          ),

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
                      style: JHGTextStyles.lrlabelStyle.copyWith(
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
            isBottom: true,
            isResponsive: true,
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
                        svgImg: AppAssets.iconStopwatch,
                        onTap: () {
                          controller.setTimerMode(true);
                          controller.setLeaderMode(false);
                          controller.resetTimer();
                        })
                    : controller.timerMode == true
                        ? JHGIconButton(
                            size: 30,
                            svgImg: AppAssets.iconTimer,
                            onTap: () {
                              controller.setTimerMode(false);
                              controller.setLeaderMode(true);
                              controller.resetTimer();
                            })
                        : controller.leaderboardMode == true
                            ? JHGIconButton(
                                childPadding: EdgeInsets.all(3),
                                size: 30,
                                svgImg: AppAssets.iconTropy,
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
                      style: JHGTextStyles.mdlabelStyle.copyWith(
                        color: JHGColors.primary,
                      ),
                    ),
                  )
                : JHGPrimaryBtn(
                    label: AppStrings.start,
                    height: 50,
                    width: width * 0.45,
                    onPressed: () {
                      controller.startTimer();
                      controller.startTheGame();
                    },
                  ),
            trailingWidget: JHGIconButton(
                svgImg: AppAssets.iconRotate,
                onTap: () {
                  controller.toggleOrientation();
                }),
          ),

          //SCORE

          if (controller.isStart)
            // == true
            //     ?
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.scoreText,
                    style: JHGTextStyles.labelStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    controller.score.toString(),
                    style: JHGTextStyles.subLabelStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          // : const SizedBox(
          //     height: 23,
          //   ),
        ],
      ),
    );
  }
}
