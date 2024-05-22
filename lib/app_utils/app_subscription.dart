import 'dart:io';

import 'package:flutter/foundation.dart';
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

String get nativeBannerAdId => kIsWeb
    ? ''
    : Platform.isAndroid
    ? 'ca-app-pub-3940256099942544/2247696110'
    : 'ca-app-pub-3940256099942544/3986624511';

String get interstitialAdId => kIsWeb
    ? ''
    : Platform.isAndroid
    ? 'ca-app-pub-3940256099942544/1033173712'
    : 'ca-app-pub-3940256099942544/4411468910';

List<String> getFeaturesList() {
  var featuresList = <String>[];
  featuresList.add("Access all your Jamie Harrison Guitar courses");
  featuresList.add("Resume from exactly where you left off");
  featuresList.add("View your courses and the courses you don't have yet");
  featuresList.add("Download videos for offline viewing");
  featuresList.add("Loop sections of videos");
  featuresList.add("Mark topics as complete");
  featuresList.add("View tabs for all songs");
  featuresList.add("Features a picture in Picture player");
  return featuresList;
}
