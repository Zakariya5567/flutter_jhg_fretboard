import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fretboard/utils/app_constant.dart';
import 'package:get/get.dart';

import '../../controllers/leaderboard_controller.dart';
import '../../utils/app_ colors.dart';
import '../../utils/images.dart';
import '../../widgets/leaderboard_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LeadershipScreen extends StatelessWidget {
  String? intervalType;
  LeadershipScreen({this.intervalType, super.key});
  LeaderBoardController lc = Get.put(LeaderBoardController());
  //Global g = Global();

  @override
  Widget build(BuildContext context) {
    lc.getLearderBoard();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: GetBuilder<LeaderBoardController>(builder: (controller) {


      return  LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth >= 1100) {
            return LeaderWebView(controller: controller,);
          } else if (constraints.maxWidth >= 600) {
            return  LeaderWebView(controller: controller,);
          } else {
            return  LeaderMobileView(controller: controller,);
          }
        });
      }),
      // bottomNavigationBar: leaderBoardButton(),
    );
  }
}

class LeaderMobileView extends StatelessWidget {
  const LeaderMobileView({super.key,required this.controller});
  final LeaderBoardController controller;
  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 20.dp, left: 10.0.dp, right: 10.0.dp),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 150.dp, top: 0.dp),
                    child: SvgPicture.asset(Images.svg_trophyIcon)),
                Padding(
                  padding:
                  EdgeInsets.only(left: 0.dp, top: 0.dp, right: 25.dp),
                  child: GestureDetector(
                      onTap: () => Get.back(),
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: SvgPicture.asset(
                            Images.svg_forward_button),
                      )),
                ),
              ],
            ),
            leaderBoardTitleWidget(),
            controller.isLoading.value
                ? Padding(
              padding: EdgeInsets.only(top: 30.0.h),
              child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.redlight,
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
                    padding:
                    EdgeInsets.only(left: 15.dp, right: 15.dp),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      border: Border.all(
                        color: AppColors.greyColor,
                      ),
                      color: AppColors.greyColor,
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
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
                        padding:
                        EdgeInsets.symmetric(horizontal: 30.dp),
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
                )
              ],
            ),
          ],
        ),
      ),
    );

  }
}

class LeaderWebView extends StatelessWidget {
  const LeaderWebView({super.key,required this.controller});
  final LeaderBoardController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, left: 5.w, right: 5.w),
      child: SingleChildScrollView(

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                  SvgPicture.asset(Images.svg_trophyIcon,height: 3.w,width: 3.w,),

                  GestureDetector(
                      onTap: () => Get.back(),
                      child: SizedBox(
                        width: 2.w,
                        height: 2.w,
                        child: SvgPicture.asset(
                            Images.svg_forward_button,   width: 2.w,
                          height: 2.w,),
                      )),

              ],
            ),
            leaderBoardTitleWidget(),

            controller.isLoading.value
                ? Padding(
              padding: EdgeInsets.only(top: 40.h),
              child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.redlight,
                  )),
            )
                : Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 20.dp, left: 10.0.dp, right: 10.0.dp),
                  child: Container(
                    width: 60.w,
                    height: 10.h,
                    padding:
                    EdgeInsets.only(left: 15.dp, right: 15.dp),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      border: Border.all(
                        color: AppColors.greyColor,
                      ),
                      color: AppColors.greyColor,
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
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
                    width: 60.w,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 30.dp),
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
    );
  }
}


