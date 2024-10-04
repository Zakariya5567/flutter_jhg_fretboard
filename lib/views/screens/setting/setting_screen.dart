import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_jhg_elements/jhg_elements.dart';
import 'package:fretboard/app_utils/app_strings.dart';
import 'package:fretboard/app_utils/app_subscription.dart';
import 'package:fretboard/controllers/home_controller.dart';
import 'package:fretboard/main.dart';
import 'package:get/get.dart';
import 'package:reg_page/reg_page.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
    await getDeviceInfo();
  }

  bool toggle = true;
  ValueNotifier<bool> isExpanded = ValueNotifier(false);
  StreamController<bool> expansionStream = StreamController<bool>.broadcast();

  @override
  void dispose() {
    expansionStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return controller.isPortrait
            ? JHGSettings(
                androidAppIdentifier: AppStrings.androidBuildId,
                iosAppIdentifier: AppStrings.iOSBuildId,
                appStoreId: AppStrings.appStoreId,
                appName: AppStrings.appName,
                bodyAppBar: JHGAppBar(
                  isResponsive: true,
                  title: Text(
                    'Settings',
                    style: JHGTextStyles.smlabelStyle,
                  ),
                  trailingWidget: kIsWeb
                      ? null
                      : JHGReportAnIssueBtn(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BugReportScreen(),
                              ),
                            );
                          },
                        ),
                ),
                trailing: isFreePlan
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: JHGNativeBanner(
                          adID: nativeBannerAdId,
                        ),
                      )
                    : const SizedBox(),
                body: settingPortrait(
                    controller: controller, height: height, width: width),
                onTapSave: () => controller.onClickSave(context),
                onTapLogout: () async {
                  await LocalDB.clearLocalDB();
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return WelcomeScreen();
                  }), (route) => false);
                },
              )
            : JHGSettingsLandscape(
                androidAppIdentifier: AppStrings.androidBuildId,
                iosAppIdentifier: AppStrings.iOSBuildId,
                appStoreId: AppStrings.appStoreId,
                appName: AppStrings.appName,
                isExpanded: expansionStream.stream,
                bodyAppBar: JHGAppBar(
                  isResponsive: true,
                  title: Text(
                    'Settings',
                    style: JHGTextStyles.smlabelStyle,
                  ),
                  trailingWidget: kIsWeb
                      ? null
                      : JHGReportAnIssueBtn(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BugReportScreen(),
                              ),
                            );
                          },
                        ),
                ),
                trailing: isFreePlan
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: JHGNativeBanner(
                          adID: nativeBannerAdId,
                        ),
                      )
                    : const SizedBox(),
                body: settingLandscape(
                    controller: controller, height: height, width: width),
                onTapSave: () => controller.onClickSave(context),
                onTapLogout: () async {
                  await LocalDB.clearLocalDB();
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) {
                    return WelcomeScreen();
                  }), (route) => false);
                },
              );
      },
    );
  }

  Widget settingPortrait(
      {required HomeController controller,
      required double height,
      required double width}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSettingsUi(controller),
      ],
    );
  }

  Widget settingLandscape(
      {required HomeController controller,
      required double height,
      required double width}) {
    return Container(
        // height: isExpanded ? width : width * 0.45,
        width: height,
        color: JHGColors.secondryBlack,
        //color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kIsWeb
                ? buildLandWebSettingsUi(height, controller)
                : buildSettingsUi(controller),
            SizedBox(
              height: width * 0.04,
            ),
          ],
        ));
  }

  Widget buildSettingsUi(HomeController controller) {
    return StreamBuilder<bool>(
      stream: expansionStream.stream,
      initialData: false,
      builder: (context, snapshot) {
        bool val = snapshot.data ?? false;
        return Column(
          children: [
            JHGHeadWithActions(
              AppStrings.strings,
              subLabel: AppStrings.stringDescriptionLandscape,
              onTapTitle: () {
                expansionStream.sink.add(!val);
              },
              onArrowDownTap: () {
                expansionStream.sink.add(!val);
              },
              arrowIcon: val
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black.withOpacity(0.2),
              ),
              child: JHGExpandableSection(
                expand: val,
                child: Column(
                  children: [
                    JHGSwitchTile(
                        title: AppStrings.string6,
                        initialValue: controller.string6,
                        onChanged: (val) {
                          controller.setString6(0);
                        }),
                    JHGSwitchTile(
                        title: AppStrings.string5,
                        initialValue: controller.string5,
                        onChanged: (val) {
                          controller.setString5(1);
                        }),
                    JHGSwitchTile(
                        title: AppStrings.string4,
                        initialValue: controller.string4,
                        onChanged: (val) {
                          controller.setString4(2);
                        }),
                    JHGSwitchTile(
                        title: AppStrings.string3,
                        initialValue: controller.string3,
                        onChanged: (val) {
                          controller.setString3(3);
                        }),
                    JHGSwitchTile(
                        title: AppStrings.string2,
                        initialValue: controller.string2,
                        onChanged: (val) {
                          controller.setString2(4);
                        }),
                    JHGSwitchTile(
                        title: AppStrings.string1,
                        initialValue: controller.string1,
                        onChanged: (val) {
                          controller.setString1(5);
                        }),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.sizeOf(context).height * 0.85,
              child: JHGSettingsDefaultTimer(
                  selectedValue: controller.defaultTimerSelectedValue.value,
                  onChanged: (String? value) {
                    if (value != null) {
                      controller.defaultTimerSelectedValue.value = value;
                    }
                  },
                  paddingTop: EdgeInsets.zero,
                  minutesController: controller.minutesEditingController,
                  secondsController: controller.timerIntervalEditingController),
            ),
          ],
        );
      },
    );
  }

  VsScrollbar buildLandWebSettingsUi(double height, HomeController controller) {
    return VsScrollbar(
      controller: ScrollController(),
      showTrackOnHover: true,
      isAlwaysShown: true,
      scrollbarFadeDuration: Duration(milliseconds: 500),
      scrollbarTimeToFade: Duration(milliseconds: 800),
      style: VsScrollbarStyle(
        hoverThickness: 10.0, // default 12.0
        radius: Radius.circular(10), // default Radius.circular(8.0)
        thickness: 10.0, // [ default 8.0 ]
        color: Colors.white, // default ColorScheme Theme
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildSettingsUi(controller),
            SizedBox(height: height * 0.02),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  JHGPrimaryBtn(
                    label: AppStrings.save,
                    width: height * 0.58,
                    onPressed: () {
                      controller.onClickSave(context);
                    },
                  ),
                  JHGSecondaryBtn(
                    label: AppStrings.logout,
                    width: height * 0.58,
                    onPressed: () async {
                      await LocalDB.clearLocalDB();
                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return WelcomeScreen();
                      }), (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
