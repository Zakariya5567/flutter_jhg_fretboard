import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fretboard/utils/app_constant.dart';
import 'package:fretboard/utils/app_subscription.dart';
import 'package:get/get.dart';
import 'package:fretboard/screens/home_screen/home_screen.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:reg_page/reg_page.dart';


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
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
      packageInfo = info;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (BuildContext , Orientation , ScreenType ) {
        return AnnotatedRegion<SystemUiOverlayStyle>(

          value : SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Colors.white,
              systemNavigationBarIconBrightness: Brightness.dark,
              systemNavigationBarDividerColor: Colors.white),

          child: GetMaterialApp(
              builder: (context, child){
                return  MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: child!,);
                },
              debugShowCheckedModeBanner: false,
              title: 'JHG fretboard',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
             // home:  const HomeScreen()
              home:
              kIsWeb ?  const HomeScreen() :

              SplashScreen(
              yearlySubscriptionId: yearlySubscription(),
              monthlySubscriptionId: monthlySubscription(),
              appName: AppConstant.appName,
              appVersion: packageInfo.version,
              nextPage: () => const HomeScreen(),
            ),
          ),
        );
      },
    );
  }
}


