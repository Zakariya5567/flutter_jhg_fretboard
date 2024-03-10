import 'package:flutter/material.dart';
import 'package:flutter_jhg_elements/jhg_elements.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fretboard/controllers/home_controller.dart';
import 'package:fretboard/utils/app_constant.dart';
import 'package:get/get.dart';

import '../../controllers/leaderboard_controller.dart';
import '../../utils/images.dart';
import '../../widgets/leaderboard_widget.dart';

class LeadershipScreen extends StatelessWidget {
  String? intervalType;
  LeadershipScreen({this.intervalType, super.key});
  HomeController hc = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JHGColors.secondryBlack,
      body: GetBuilder<LeaderBoardController>(
          init: LeaderBoardController(),
          builder: (controller) {
            return LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth >= 400) {
                return LeaderWebView(
                  controller: controller,
                );
                ;
              } else {
                if (hc.isPortrait == true) {
                  return LeaderPortraitView(
                    controller: controller,
                  );
                } else {
                  return LeaderLandscapeView(
                    controller: controller,
                  );
                }
              }
            });
          }),
      // bottomNavigationBar: leaderBoardButton(),
    );
  }
}

class LeaderPortraitView extends StatelessWidget {
  const LeaderPortraitView({super.key, required this.controller});
  final LeaderBoardController controller;
  @override
  Widget build(BuildContext context) {
    return JHGBody(
      bodyAppBar: JHGAppBar(
        autoImplyLeading: false,
        centerWidget: SvgPicture.asset(
          Images.svg_trophyIcon,
          height: 8.w,
          width: 8.w,
        ),
        trailingWidget: JHGIconButton(
          size: 30,
          onTap: () => Get.back(),
          svgImg: Images.svg_forward_button,
        ),
        bottom: leaderBoardTitleWidget(),
      ),
      body: Column(
        children: [
          controller.isLoading.value
              ? Padding(
                  padding: EdgeInsets.only(top: 30.0.h),
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: JHGColors.primary,
                  )),
                )
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.dp, left: 10.0.dp, right: 10.0.dp),
                      child: Container(
                        width: 90.w,
                        height: 10.h,
                        padding: EdgeInsets.only(left: 15.dp, right: 15.dp),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          border: Border.all(
                            color: JHGColors.charcolGray,
                          ),
                          color: JHGColors.charcolGray,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            leaderBoardTextWidget('Current Leader',
                                controller.highestUserScore.value),
                            leaderBoardTextWidget(
                                'Score', controller.highScore.value),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.dp, left: 10.0.dp, right: 10.0.dp),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.dp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppConstant.user,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  AppConstant.scoreTemp,
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          populateScoreList(controller.scoreList),
                        ],
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}

class LeaderLandscapeView extends StatelessWidget {
  const LeaderLandscapeView({super.key, required this.controller});
  final LeaderBoardController controller;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return JHGBody(
      padding: EdgeInsets.symmetric(vertical: 24),
      body: RotatedBox(
        quarterTurns: 1,
        child: Column(
          children: [
            JHGAppBar(
              autoImplyLeading: false,
              centerWidget: SvgPicture.asset(
                Images.svg_trophyIcon,
                height: 8.w,
                width: 8.w,
              ),
              trailingWidget: JHGIconButton(
                size: 30,
                onTap: () => Get.back(),
                svgImg: Images.svg_forward_button,
              ),
              bottom: leaderBoardTitleWidget(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    controller.isLoading.value
                        ? Container(
                            height: width,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: JHGColors.primary,
                              ),
                            ))
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20.dp, left: 10.0.dp, right: 10.0.dp),
                                child: Container(
                                  width: 80.w,
                                  height: 10.h,
                                  padding: EdgeInsets.only(
                                      left: 15.dp, right: 15.dp),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    border: Border.all(
                                      color: JHGColors.charcolGray,
                                    ),
                                    color: JHGColors.charcolGray,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      leaderBoardTextWidget('Current Leader',
                                          controller.highestUserScore.value),
                                      leaderBoardTextWidget(
                                          'Score', controller.highScore.value),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20.dp, left: 10.0.dp, right: 10.0.dp),
                                child: Container(
                                  width: 80.w,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.dp),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppConstant.user,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              AppConstant.scoreTemp,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                      populateScoreList(controller.scoreList),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaderWebView extends StatelessWidget {
  const LeaderWebView({super.key, required this.controller});
  final LeaderBoardController controller;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return JHGBody(
      bodyAppBar: Padding(
        padding: EdgeInsets.only(
            left: width * 0.020, right: width * 0.020, top: height * 0.030),
        child: JHGAppBar(
          autoImplyLeading: false,
          centerWidget: SvgPicture.asset(
            Images.svg_trophyIcon,
          ),
          trailingWidget: RotatedBox(
            quarterTurns: 2,
            child: JHGBackButton(
              onTap: () => Get.back(),
            ),
          ),
          bottom: leaderBoardTitleWidget(),
        ),
      ),
      body: Column(
        children: [

          controller.isLoading.value
              ? Padding(
                  padding: EdgeInsets.only(top: 30.0.h),
                  child: const Center(
                      child: CircularProgressIndicator(
                    color: JHGColors.primary,
                  )),
                )
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.dp, left: 10.0.dp, right: 10.0.dp),
                      child: Container(
                        width: 40.w,
                        height: 10.h,
                        padding: EdgeInsets.only(left: 15.dp, right: 15.dp),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                          border: Border.all(
                            color: JHGColors.charcolGray,
                          ),
                          color: JHGColors.charcolGray,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            leaderBoardTextWidget('Current Leader',
                                controller.highestUserScore.value),
                            leaderBoardTextWidget(
                                'Score', controller.highScore.value),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.dp, left: 10.0.dp, right: 10.0.dp),
                      child: Container(
                        width: 40.w,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.dp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppConstant.user,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    AppConstant.scoreTemp,
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            populateScoreList(controller.scoreList),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }
}
