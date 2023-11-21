import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reg_page/reg_page.dart';
import 'package:tempo_bpm/screens/guitar_board.dart';
import 'package:tempo_bpm/screens/setting_screen.dart';
import 'package:tempo_bpm/utils/images.dart';
import 'package:tempo_bpm/widgets/button_icon.dart';
import '../providers/home_provider.dart';
import '../utils/app_ colors.dart';
import '../utils/app_constant.dart';

class PortraitBoard extends StatelessWidget {
  const PortraitBoard({super.key,required this.controller});

  final HomeProvider controller;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return
      AnimatedScale(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.linearToEaseOut,
        scale: controller.scale,
        child: Padding(
          padding: EdgeInsets.only(
               top: height*0.068 ,),
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
                        onTap: (){}),


                    ButtonIcon(
                        icon: Images.iconSetting,
                        width: height*0.038,
                        height: height*0.038,
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return const SettingScreen();
                          }));
                        })
                  ],
                ),
              ),

              // //SPACER
              SizedBox(
                height: height*0.025,
              ),

              // BOARD WITH NUMBER


                  Padding(
                    padding:  EdgeInsets.only(left: width*0.070),
                    child: Container(
                        height: height*0.70,
                        child: GuitarBoard()),
                  ),
              //SPACER
                SizedBox(
                height: height*0.015,
               ),

              // //TIMER , STOPWATCH , ROTATE ICON
              // Padding(
              //   padding:  EdgeInsets.only(
              //     left: width * 0.08,
              //     right: width * 0.08,),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       ButtonIcon(
              //           icon: Images.iconTimer,
              //           width: height*0.03,
              //           height: height*0.03,
              //           onTap: (){}),
              //
              //
              //       Text(
              //         "01:34",
              //         style: TextStyle(
              //           fontFamily: AppConstant.sansFont,
              //           color: AppColors.whitePrimary,
              //           fontSize: 40,
              //           fontWeight: FontWeight.w700,
              //         ),
              //       ),
              //
              //
              //       ButtonIcon(
              //           icon: Images.iconRotate,
              //           width: height*0.05,
              //           height: height*0.04,
              //           onTap: (){
              //             controller.toggleOrientation();
              //           })
              //     ],
              //   ),
              // ),
              //
              //
              // //SCORE
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       AppConstant.score,
              //       style: TextStyle(
              //         fontFamily: AppConstant.sansFont,
              //         color: AppColors.whitePrimary,
              //         fontSize: 16,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
                  Text(
                    controller.highlightNode??"",
                    style: TextStyle(
                      fontFamily: AppConstant.sansFont,
                      color: AppColors.whitePrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
               // ],
             // ),

            // SPACER
              SizedBox(
                height: height*0.02,
              ),

            // START BUTTON
              InkWell(
                onTap: () {
                  controller.startTheGame();
                },
                child: Center(
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.8,
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

            ],
          ),
        ),
      );
  }
}
