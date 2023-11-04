import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reg_page/reg_page.dart';
import 'package:tempo_bpm/providers/setting_provider.dart';
import 'package:tempo_bpm/screens/home_screen.dart';
import 'package:tempo_bpm/widgets/setting_toggle.dart';
import '../utils/app_ colors.dart';
import '../utils/app_constant.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>{



  @override
  void initState() {
    super.initState();
    final settingProvider = Provider.of<SettingProvider>(context, listen: false);
    //settingProvider.initializeAnimationController();
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
        child: Consumer<SettingProvider>(builder: (context, controller, child) {
          return Padding(
            padding: EdgeInsets.only(
              top: height * 0.07,
              left: width * 0.08,
              right: width * 0.08,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BACK ICON
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return const HomeScreen();
                    }));
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.greySecondary,
                    size: height * 0.025,
                  ),
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
                      controller.setString6();
                    }
                ),
                SettingToggle(
                    heading: AppConstant.string5,
                    value: controller.string5,
                    onChange: (){
                      controller.setString5();
                    }
                ),
                SettingToggle(
                    heading: AppConstant.string4,
                    value: controller.string4,
                    onChange: (){
                      controller.setString4();
                    }
                ),
                SettingToggle(
                    heading: AppConstant.string3,
                    value: controller.string3,
                    onChange: (){
                      controller.setString3();
                    }
                ),
                SettingToggle(
                    heading: AppConstant.string2,
                    value: controller.string2,
                    onChange: (){
                      controller.setString2();
                    }
                ),
                SettingToggle(
                    heading: AppConstant.string1,
                    value: controller.string1,
                    onChange: (){
                      controller.setString1();
                    }
                ),




                SizedBox(height: height * 0.05),
                InkWell(
                  onTap: () {},
                  child: Center(
                    child: Container(
                      height: height * 0.07,
                      width: width * 1,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.redPrimary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                         AppConstant.returnString,
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
                  height: height * 0.02,
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
