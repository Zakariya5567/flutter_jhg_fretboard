import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fretboard/utils/app_strings.dart';

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
    ? 'ca-app-pub-8243857750402094/2199455522'
    : 'ca-app-pub-8243857750402094/6682261445';




String get bannerAdId => kIsWeb
    ? ''
    : Platform.isAndroid
    ? 'ca-app-pub-8243857750402094/7568946017'
    : 'ca-app-pub-8243857750402094/2891334408';

String get interstitialAdId => kIsWeb
    ? ''
    : Platform.isAndroid
    ? 'ca-app-pub-8243857750402094/3512537192'
    : 'ca-app-pub-8243857750402094/7038683778';

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
