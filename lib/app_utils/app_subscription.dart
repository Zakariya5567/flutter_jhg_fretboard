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
