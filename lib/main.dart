import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jhg_elements/jhg_elements.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fretboard/app_utils/app_strings.dart';
import 'package:fretboard/app_utils/app_subscription.dart';
import 'package:fretboard/views/screens/home/home_screen.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reg_page/reg_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  JHGAdsHelper().init();
  JHGAdsHelper().addATestDevice(""); // place your deviceID for test Ads
  StringsDownloadService();
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarBrightness: Brightness.dark, // Dark text for status bar
    ));

    return FlutterSizer(
      builder: (BuildContext, Orientation, ScreenType) {
        return GetMaterialApp(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(1.0)),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          title: 'JHG Fretboard',
          theme: JHGTheme.themeData,
          // home:  const HomeScreen()
          home: kIsWeb
              ? const HomeScreen()
              : SplashScreen(
                  yearlySubscriptionId: yearlySubscription(),
                  monthlySubscriptionId: monthlySubscription(),
                  appName: AppStrings.appName,
                  appVersion: packageInfo.version,
                  featuresList: getFeaturesList(),
                  nextPage: () => const HomeScreen(),
                ),
        );
      },
    );
  }
}
