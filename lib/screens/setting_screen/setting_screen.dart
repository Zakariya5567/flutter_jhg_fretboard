import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jhg_elements/jhg_elements.dart';
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
          return LayoutBuilder(builder: (context, constraints) {
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
                    controller: controller, height: height, width: width);
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
    return JHGBody(
      bgColor: AppColors.blackPrimary,
      bodyAppBar: JHGAppBar(
        trailingWidget: JHGReportAnIssueBtn(
          onPressed: () {
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
        ),
      ),
      body: Container(
        //color: Colors.blue,
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12,
            ),
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
            JHGSwitchTile(
                title: AppConstant.string6,
                initialValue: controller.string6,
                onChanged: (bool value) {
                  controller.setString6(0);
                }),
            JHGSwitchTile(
                title: AppConstant.string5,
                initialValue: controller.string5,
                onChanged: (bool value) {
                  controller.setString5(1);
                }),
            JHGSwitchTile(
                title: AppConstant.string4,
                initialValue: controller.string4,
                onChanged: (bool value) {
                  controller.setString4(2);
                }),
            JHGSwitchTile(
                title: AppConstant.string3,
                initialValue: controller.string3,
                onChanged: (bool value) {
                  controller.setString3(3);
                }),
            JHGSwitchTile(
                title: AppConstant.string2,
                initialValue: controller.string2,
                onChanged: (bool value) {
                  controller.setString2(4);
                }),
            JHGSwitchTile(
                title: AppConstant.string1,
                initialValue: controller.string1,
                onChanged: (bool value) {
                  controller.setString1(5);
                }),
            Spacer(),
            JHGPrimaryBtn(
              label: AppConstant.save,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            JHGSecondaryBtn(
              label: AppConstant.logout,
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
            ),
            // SPACER
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget settingLandscape(
      {required HomeController controller,
      required double height,
      required double width}) {
    return JHGBody(
      padding: EdgeInsets.symmetric(vertical: 24),
      bgColor: AppColors.blackPrimary,
      body: RotatedBox(
        quarterTurns: 1,
        child: Container(
          height: width,
          width: height,
          color: AppColors.blackPrimary,
          //color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JHGAppBar(
                trailingWidget: JHGReportAnIssueBtn(
                  onPressed: () {
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
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: height * 0.58,
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
                          //height: width * 0.37,
                          width: height * 0.58,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              // padding: EdgeInsets.zero,
                              // shrinkWrap: true,
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
                      ),
                      SizedBox(height: height * 0.02),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            JHGPrimaryBtn(
                              label: AppConstant.save,
                              width: height * 0.58,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            JHGSecondaryBtn(
                              label: AppConstant.logout,
                              width: height * 0.58,
                              onPressed: () async {
                                await LocalDB.clearLocalDB();
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Welcome(
                                    yearlySubscriptionId: yearlySubscription(),
                                    monthlySubscriptionId:
                                        monthlySubscription(),
                                    appVersion: packageInfo.version,
                                    appName: AppConstant.appName,
                                    nextPage: () => const HomeScreen(),
                                  );
                                }), (route) => false);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
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
    return JHGBody(
      bgColor: AppColors.blackPrimary,
      bodyAppBar: Padding(
        padding: EdgeInsets.only(
            left: width * 0.020, right: width * 0.020, top: height * 0.030),
        child: JHGAppBar(
          trailingWidget: JHGReportAnIssueBtn(
            onPressed: () {
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
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        color: AppColors.blackPrimary,
        child: Padding(
          padding: EdgeInsets.only(
            //top: 40,
            left: 2.w,
            right: 2.w,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SPACER
                    SizedBox(height: 20),
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
                    // LIST SWITCH BUTTON
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black.withOpacity(0.2),
                        ),
                        width: 40.w,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: [
                            JHGSwitchTile(
                                title: AppConstant.string6,
                                initialValue: controller.string6,
                                onChanged: (value) {
                                  controller.setString6(0);
                                }),
                            JHGSwitchTile(
                                title: AppConstant.string5,
                                initialValue: controller.string5,
                                onChanged: (value) {
                                  controller.setString5(1);
                                }),
                            JHGSwitchTile(
                                title: AppConstant.string4,
                                initialValue: controller.string4,
                                onChanged: (value) {
                                  controller.setString4(2);
                                }),
                            JHGSwitchTile(
                                title: AppConstant.string3,
                                initialValue: controller.string3,
                                onChanged: (value) {
                                  controller.setString3(3);
                                }),
                            JHGSwitchTile(
                                title: AppConstant.string2,
                                initialValue: controller.string2,
                                onChanged: (value) {
                                  controller.setString2(4);
                                }),
                            JHGSwitchTile(
                                title: AppConstant.string1,
                                initialValue: controller.string1,
                                onChanged: (value) {
                                  controller.setString1(5);
                                }),
                          ],
                        ).paddingSymmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),

              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                color: AppColors.blackPrimary,
                child: Center(
                  child: JHGPrimaryBtn(
                    label: AppConstant.save,
                    width: 25.w,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SizedBox(height:  height * 0.030,),
            ],
          ),
        ),
      ),
    );
  }
}
