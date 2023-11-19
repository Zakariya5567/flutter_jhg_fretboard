import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tempo_bpm/providers/home_provider.dart';
import 'package:tempo_bpm/screens/home_screen.dart';


Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create: (context)=> HomeProvider()),
      ],
      child:
      MaterialApp(

        builder: (context, child) {
          return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );},

        debugShowCheckedModeBanner: false,

        title: 'JHG Fretboard',

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        home:  const HomeScreen()
        //   home: SplashScreen(
        //   yearlySubscriptionId: AppConstant.yearlySubscriptionId,
        //   monthlySubscriptionId: AppConstant.monthlySubscriptionId,
        //   appVersion: "1.0.0",
        //   appName: "JHG Frethboard",
        //   nextPage: ()=> const HomeScreen(),),
      ),
    );
  }
}


