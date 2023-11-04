import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reg_page/reg_page.dart';
import 'package:tempo_bpm/screens/setting_screen.dart';
import 'package:tempo_bpm/utils/images.dart';
import 'package:tempo_bpm/widgets/button_icon.dart';
import '../providers/home_provider.dart';
import '../utils/app_ colors.dart';
import '../utils/app_constant.dart';

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
      scale: controller.scale,
      child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height*0.06,
              horizontal: width * 0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // TROPHY AND Timer ICON
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonIcon(
                      icon: Images.iconTimerLandscape,
                      width: height*0.032,
                      height: height*0.032,
                      onTap: (){
                      }),
                  ButtonIcon(
                      icon: Images.iconTrophyLandscape,
                      width: height*0.028,
                      height: height*0.028,
                      onTap: (){}),
                ],
              ),

              //SPACER
              SizedBox(
                height: height*0.025,
              ),

              // BOARD

              Container(
                height: height*0.75,
                width: width,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //SCORE
                    RotatedBox(
                      quarterTurns: 1,
                      child: Row(
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
                            "8",
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

                    //SPACER
                    SizedBox(
                      width: width*0.01,
                    ),

                    //STOP WATCH
                    RotatedBox(
                        quarterTurns: 1,
                        child:
                        Text(
                          "01:34",
                          style: TextStyle(
                            fontFamily: AppConstant.sansFont,
                            color: AppColors.whitePrimary,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        )),

                    //SPACER
                    SizedBox(
                      width: width*0.08,
                    ),

                    //TIMER , STOPWATCH , ROTATE ICON
                    Container(
                      color: Colors.deepPurpleAccent,
                      width: width * 0.52,
                      height: height*0.75,
                      child: Image.asset(
                        Images.imgBoard2,
                        fit: BoxFit.fill,),
                    ),


                  ],
                ),
              ),




              //SPACER
              SizedBox(
                height: height*0.025,
              ),
              Row(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const SettingScreen();
                        }));
                      }),

                ],
              ),

            ],
          ),
        ),
    );
  }
}
