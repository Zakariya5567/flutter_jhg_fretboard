import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fretboard/utils/app_constant.dart';
import 'package:get/get.dart';
import 'package:fretboard/screens/home_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reg_page/reg_page.dart';


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight
  ]);

  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  PackageInfo packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
    installerStore: '',
  );

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
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return FlutterSizer(
      builder: (BuildContext , Orientation , ScreenType ) {
        return GetMaterialApp(
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );},
            debugShowCheckedModeBanner: false,
            title: 'JHG fretboard',

            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),

            //home:  const HomeScreen()
          home: SplashScreen(
          yearlySubscriptionId: AppConstant.yearlySubscriptionId,
          monthlySubscriptionId: AppConstant.monthlySubscriptionId,
          appName: AppConstant.appName,
          appVersion: packageInfo.version,
          nextPage: () => const HomeScreen(),
        ),
        );
      },

    );
  }
}


