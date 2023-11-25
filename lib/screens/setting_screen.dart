import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reg_page/reg_page.dart';
import 'package:fretboard/screens/home_screen.dart';
import 'package:fretboard/widgets/setting_toggle.dart';
import '../controllers/home_controller.dart';
import '../utils/app_ colors.dart';
import '../utils/app_constant.dart';
import 'package:flutter/services.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>{

  PackageInfo packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
    installerStore: '',
  );

  String deviceName = 'Unknown';
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Future<void> getDeviceInfo() async {
     if(Platform.isAndroid){
      final device = await deviceInfoPlugin.androidInfo;
      deviceName = "${device.manufacturer} ${device.model}";
     }else if(Platform.isIOS){
       final device = await deviceInfoPlugin.iosInfo;
       deviceName = device.name;
     }
   }


  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
    await getDeviceInfo();
  }


  bool toggle = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: AppColors.blackPrimary,
        child: GetBuilder<HomeController>(
            init: HomeController(),
            builder: (controller) {
          return Padding(
            padding: EdgeInsets.only(
              top: height * 0.08,
              left: width * 0.08,
              right: width * 0.08,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BACK ICON  WITH REPORT AN ISSUE TEXT BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const HomeScreen();
                        }));
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.whiteSecondary,
                        size: height * 0.030,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BugReportPage(
                              device: deviceName,
                              appName: AppConstant.appName,),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 4.0), // Add padding to the right
                            child: Icon(
                              Icons.error_outline_rounded,
                              color: AppColors.redPrimary,
                              size: 16,
                            ),
                          ),
                          Text(
                            'Report an Issue',
                            style: TextStyle(
                              color: AppColors.redPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // SPACER
                SizedBox(height: height * 0.06),


                Text(
                  AppConstant.strings,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppConstant.sansFont,
                    color: AppColors.whiteSecondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: height * 0.01),

                Text(
                  AppConstant.stringDescription,
                  style: TextStyle(
                    fontFamily: AppConstant.sansFont,
                    color: AppColors.whiteSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: height * 0.04),
                // SAVE BUTTON



                SettingToggle(
                    heading: AppConstant.string6,
                    value: controller.string6,
                    onChange: (){
                      controller.setString6(0);
                    }
                ),
                SettingToggle(
                    heading: AppConstant.string5,
                    value: controller.string5,
                    onChange: (){
                      controller.setString5(1);
                    }
                ),
                SettingToggle(
                    heading: AppConstant.string4,
                    value: controller.string4,
                    onChange: (){
                      controller.setString4(2);
                    }
                ),
                SettingToggle(
                    heading: AppConstant.string3,
                    value: controller.string3,
                    onChange: (){
                      controller.setString3(3);
                    }
                ),
                SettingToggle(
                    heading: AppConstant.string2,
                    value: controller.string2,
                    onChange: (){
                      controller.setString2(4);
                    }
                ),
                SettingToggle(
                    heading: AppConstant.string1,
                    value: controller.string1,
                    onChange: (){
                      controller.setString1(5);
                    }
                ),


                SizedBox(height: height * 0.09),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: height * 0.07,
                      width: width * 1,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.redPrimary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                         AppConstant.save,
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

                // SPACER
                SizedBox(
                  height: height * 0.005,
                ),

                Center(
                  child: TextButton(
                    onPressed: () async {
                      await LocalDB.clearLocalDB();
                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return Welcome(
                          yearlySubscriptionId:
                              AppConstant.yearlySubscriptionId,
                          monthlySubscriptionId:
                              AppConstant.monthlySubscriptionId,
                          appVersion: packageInfo.version,
                          appName: AppConstant.appName,
                          nextPage: () => const HomeScreen(),
                        );
                      }), (route) => false);
                    },
                    child: Text(
                      AppConstant.logout,
                      style: TextStyle(
                        fontFamily: AppConstant.sansFont,
                        color: AppColors.redPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
