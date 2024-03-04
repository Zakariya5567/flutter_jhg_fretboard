import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reg_page/reg_page.dart';
import 'package:fretboard/screens/home_screen/home_screen.dart';
import 'package:fretboard/widgets/setting_toggle.dart';
import '../../controllers/home_controller.dart';
import '../../utils/app_ colors.dart';
import '../../utils/app_constant.dart';
import 'package:flutter/services.dart';
import '../../utils/app_subscription.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
    if (Platform.isAndroid) {
      final device = await deviceInfoPlugin.androidInfo;
      deviceName = "${device.manufacturer} ${device.model}";
    } else if (Platform.isIOS) {
      final device = await deviceInfoPlugin.iosInfo;
      deviceName = device.name;
    } else if (Platform.isWindows) {
      print("window");
    } else if (Platform.isMacOS) {
      print("mac");
    }
  }

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _initPackageInfo();
    }
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    packageInfo = info;
    await getDeviceInfo();
  }

  bool toggle = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          //
          // if(kIsWeb){
          //   return settingWeb(
          //               controller: controller, height: height, width: width);
          // }else{
          //   if (controller.isPortrait == false) {
          //           return settingLandscape(
          //               controller: controller, height: height, width: width);
          //         } else {
          //           return settingPotrait(
          //               controller: controller, height:  height, width: width);
          //         }
          // }
          return
            LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth >= 1100) {
              return settingWeb(
                  controller: controller, height: height, width: width);
            } else if (constraints.maxWidth >= 400) {
              return settingWeb(
                  controller: controller, height: height, width: width);
            } else {

              if (controller.isPortrait == false) {
                return settingLandscape(
                    controller: controller, height: height, width: width);
              } else {
                return settingPotrait(
                    controller: controller, height:  height, width: width);
              }
            }
          });
        },
      ),
    );
  }

  Widget settingPotrait(
      {required HomeController controller,
      required double height,
      required double width}) {
    return Container(
      height: height,
      width: width,
      color: AppColors.blackPrimary,
      child: Padding(
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
                  onTap: () {
                    Get.back();
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
                          appName: AppConstant.appName,
                        ),
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
                onChange: () {
                  controller.setString6(0);
                }),
            SettingToggle(
                heading: AppConstant.string5,
                value: controller.string5,
                onChange: () {
                  controller.setString5(1);
                }),
            SettingToggle(
                heading: AppConstant.string4,
                value: controller.string4,
                onChange: () {
                  controller.setString4(2);
                }),
            SettingToggle(
                heading: AppConstant.string3,
                value: controller.string3,
                onChange: () {
                  controller.setString3(3);
                }),
            SettingToggle(
                heading: AppConstant.string2,
                value: controller.string2,
                onChange: () {
                  controller.setString2(4);
                }),
            SettingToggle(
                heading: AppConstant.string1,
                value: controller.string1,
                onChange: () {
                  controller.setString1(5);
                }),
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
                      yearlySubscriptionId: yearlySubscription(),
                      monthlySubscriptionId: monthlySubscription(),
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
      ),
    );
  }

  Widget settingLandscape(
      {required HomeController controller,
      required double height,
      required double width}) {
    return RotatedBox(
      quarterTurns: 1,
      child: Container(
        height: width,
        width: height,
        color: AppColors.blackPrimary,
        child: Padding(
          padding: EdgeInsets.only(
            top: width * 0.05,
            left: height * 0.08,
            right: height * 0.08,
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
                    onTap: () {
                      Get.back();
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
                            appName: AppConstant.appName,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        SizedBox(width: height * 0.02),
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
              SizedBox(height: height * 0.01),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      AppConstant.stringDescriptionLandscape,
                      style: TextStyle(
                        fontFamily: AppConstant.sansFont,
                        color: AppColors.whiteSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                  ],
                ),
              ),

              // SAVE BUTTON

              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.black.withOpacity(0.2),
                  ),
                  height: width * 0.37,
                  width: height * 0.58,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      SettingToggle(
                          heading: AppConstant.string6,
                          value: controller.string6,
                          onChange: () {
                            controller.setString6(0);
                          }),
                      SettingToggle(
                          heading: AppConstant.string5,
                          value: controller.string5,
                          onChange: () {
                            controller.setString5(1);
                          }),
                      SettingToggle(
                          heading: AppConstant.string4,
                          value: controller.string4,
                          onChange: () {
                            controller.setString4(2);
                          }),
                      SettingToggle(
                          heading: AppConstant.string3,
                          value: controller.string3,
                          onChange: () {
                            controller.setString3(3);
                          }),
                      SettingToggle(
                          heading: AppConstant.string2,
                          value: controller.string2,
                          onChange: () {
                            controller.setString2(4);
                          }),
                      SettingToggle(
                          heading: AppConstant.string1,
                          value: controller.string1,
                          onChange: () {
                            controller.setString1(5);
                          }),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.8,
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
              Center(
                child: TextButton(
                  onPressed: () async {
                    await LocalDB.clearLocalDB();
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                      return Welcome(
                        yearlySubscriptionId: yearlySubscription(),
                        monthlySubscriptionId: monthlySubscription(),
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
        ),
      ),
    );
  }

  Widget settingWeb(
      {required HomeController controller,
      required double height,
      required double width}) {
    return Container(
      height: height,
      width: width,
      color: AppColors.blackPrimary,
      child: Wrap(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 40,
              left: 2.w,
              right: 2.w,
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
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.whiteSecondary,
                        size: 2.w,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BugReportPage(
                              device: deviceName,
                              appName: AppConstant.appName,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 3.w),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 1.w), // Add padding to the right
                            child: Icon(
                              Icons.error_outline_rounded,
                              color: AppColors.redPrimary,
                              size: 2.w,
                            ),
                          ),
                          Text(
                            'Report an Issue',
                            style: TextStyle(
                              color: AppColors.redPrimary,
                              fontSize: 1.2.w,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // SPACER
                SizedBox(height: 30),
                //
            Center(
              child: Container(
                width: 40.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Text(
                        AppConstant.strings,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: AppConstant.sansFont,
                            color: AppColors.whiteSecondary,
                            fontSize: 1.6.w,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                      //
                      SizedBox(height: 10),
                      //
                      Text(
                          AppConstant.stringDescriptionWeb,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: AppConstant.sansFont,
                            color: AppColors.whiteSecondary,
                            fontSize: 1.2.w,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                      SizedBox(height: 20),
                    ],
                  ),
                )),


                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.2),
                    ),
                    height: 380,
                    width: 40.w,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        WebSettingToggle(
                            heading: AppConstant.string6,
                            value: controller.string6,
                            onChange: () {
                              controller.setString6(0);
                            }),
                        WebSettingToggle(
                            heading: AppConstant.string5,
                            value: controller.string5,
                            onChange: () {
                              controller.setString5(1);
                            }),
                        WebSettingToggle(
                            heading: AppConstant.string4,
                            value: controller.string4,
                            onChange: () {
                              controller.setString4(2);
                            }),
                        WebSettingToggle(
                            heading: AppConstant.string3,
                            value: controller.string3,
                            onChange: () {
                              controller.setString3(3);
                            }),
                        WebSettingToggle(
                            heading: AppConstant.string2,
                            value: controller.string2,
                            onChange: () {
                              controller.setString2(4);
                            }),
                        WebSettingToggle(
                            heading: AppConstant.string1,
                            value: controller.string1,
                            onChange: () {
                              controller.setString1(5);
                            }),
                      ],
                    ).paddingSymmetric(
                      horizontal: 2.w,
                      vertical: 20,
                    ),
                  ),
                ),
                SizedBox(height: 30),

                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 45,
                      width: 25.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.redPrimary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        AppConstant.save,
                        style: TextStyle(
                          fontFamily: AppConstant.sansFont,
                          color: AppColors.whitePrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
