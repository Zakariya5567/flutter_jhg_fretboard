import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reg_page/reg_page.dart';
import 'package:tempo_bpm/screens/landscape_board.dart';
import 'package:tempo_bpm/screens/potrait_board.dart';
import '../providers/home_provider.dart';
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
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.initializeData();
    setExpiryDate();
    super.initState();
  }

  HomeProvider? homeProvider;


  @override
  void didChangeDependencies() {
    homeProvider = Provider.of<HomeProvider>(context,listen: false);
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
      child: Consumer<HomeProvider>(
          builder: (context, controller, child) {
            return
                 controller.isPortrait == true ?
                 PortraitBoard(controller: controller):
                 LandscapeBoard(controller: controller);
          }),
          ),
    );
  }
}
