import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reg_page/reg_page.dart';
import 'package:fretboard/controllers/home_controller.dart';
import 'package:fretboard/widgets/landscape_board.dart';
import 'package:fretboard/widgets/potrait_board.dart';
import '../utils/app_ colors.dart';


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
      body: Container(
      height: height,
      width: width,
      color:  AppColors.blackPrimary,
      child: GetBuilder<HomeController>(
           init: HomeController(),
           builder: (controller) {
            return
            //   OrientationBuilder(builder: (context,orientation){
            //   if (orientation == Orientation.portrait) {
            //     print(orientation.index);
            //     controller.toggleOrientation(true);
            //     return PortraitBoard(controller: controller);
            //   } else {
            //     print(orientation.index);
            //     controller.toggleOrientation(false);
            //     return LandscapeBoard(controller: controller);
            //   }
            //
            // });
                 controller.isPortrait == true ?
                 PortraitBoard(controller: controller):
                 LandscapeBoard(controller: controller);
          }),
          ),
    );
  }
}
