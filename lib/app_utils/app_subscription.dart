import 'dart:io';

import 'package:fretboard/app_utils/app_strings.dart';

String monthlySubscription() {
  return Platform.isAndroid
      ? AppStrings.androidMonthlySubscriptionId
      : AppStrings.iosMonthlySubscriptionId;
}

String yearlySubscription() {
  return Platform.isAndroid
      ? AppStrings.androidYearlySubscriptionId
      : AppStrings.iosYearlySubscriptionId;
}
