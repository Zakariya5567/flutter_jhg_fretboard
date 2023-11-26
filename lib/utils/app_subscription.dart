import 'dart:io';
import 'package:fretboard/utils/app_constant.dart';

String monthlySubscription(){
  return  Platform.isAndroid ? AppConstant.androidMonthlySubscriptionId  :  AppConstant.iosMonthlySubscriptionId;
}

String yearlySubscription(){
  return  Platform.isAndroid ? AppConstant.androidYearlySubscriptionId  :  AppConstant.iosYearlySubscriptionId;
}
