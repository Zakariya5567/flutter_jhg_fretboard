import 'package:flutter/material.dart';
import 'package:fretboard/widgets/web_board.dart';
import 'package:get/get.dart';
import 'package:reg_page/reg_page.dart';
import 'package:fretboard/controllers/home_controller.dart';
import 'package:fretboard/widgets/landscape_board.dart';
import 'package:fretboard/widgets/potrait_board.dart';
import '../../utils/app_ colors.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeScreen  extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {

  // Set expiry date when user login to the app
  // we will expire user login after 14 days
  setExpiryDate()async{
    DateTime currentDate = DateTime.now();
    DateTime endDate = currentDate.add(const Duration(days: 14));
    await LocalDB.storeEndDate(endDate.toString());
  }

  @override
    void initState() {
    final homeController = Get.put(HomeController());
    homeController.initializeData();
    setExpiryDate();
    super.initState();
  }
  HomeController? homeController;
  @override
  void didChangeDependencies() {
    homeController = Get.put(HomeController());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
          return LayoutBuilder(
            builder: (context,constraints) {
              if (constraints.maxWidth >= 1100) {
                return  Container(
                  height: height,
                  width: width,
                  color:  AppColors.blackPrimary,
                  child:WebBoard(controller:controller),
                );
              }
              else if (constraints.maxWidth >= 600) {
                return Container(
                    height: height,
                    width: width,
                    color:  AppColors.blackPrimary,
                    child: controller.isPortrait == true ?
                    PortraitBoard(controller: controller):
                    LandscapeBoard(controller: controller),
                );
              } else {
                return Container(
                  height: height,
                  width: width,
                  color:  AppColors.blackPrimary,
                  child: controller.isPortrait == true ?
                         PortraitBoard(controller: controller):
                         LandscapeBoard(controller: controller),
                );
              }


            }
          );
        }
      ),
    );
  }
}

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  const Responsive({
    Key? key,
    required this.desktop,
    required this.mobile,
    required this.tablet,
  }) : super(key: key);

  /// mobile < 650
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  /// tablet >= 650
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 650;

  ///desktop >= 1100
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1100) {
        return desktop;
      } else if (constraints.maxWidth >= 650) {
        return tablet;
      } else {
        return mobile;
      }
    });
  }
}
