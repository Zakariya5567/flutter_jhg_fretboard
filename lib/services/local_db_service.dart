import 'package:reg_page/reg_page.dart';

class SharedPref {
  static String defaultBpmKey = "defaultBpmKey";
  static String defaultSoundKey = "defaultSoundKey";
  static String defaultTimingKey = "defaultTimingKey";
  static String defaultTimerTypeKey = "defaultTimerTypeKey";
  static String defaultTimerIntervalKey = "defaultTimerIntervalKey";
  static String defaultTimerMinutesKey = "defaultTimerMinutesKey";

  // Store default BPM
  static Future<void> storeDefaultBPM(double value) async {
    // initialized shared preferences
    final pref = await LocalDB.getPref;
    pref!.setDouble(defaultBpmKey, value);
  }

  // Get default BPM
  static Future<double?> get getDefaultBPM async {
    // Initialized shared preferences
    final pref = await LocalDB.getPref;
    double? bpm = pref!.getDouble(defaultBpmKey);
    return bpm;
  }

  // Set default sound
  static Future<void> storeDefaultSound(int value) async {
    // initialized shared preferences
    final pref = await LocalDB.getPref;
    pref!.setInt(defaultSoundKey, value);
  }

  // Get default sound
  static Future<int?> get getDefaultSound async {
    // Initialized shared preferences
    final pref = await LocalDB.getPref;
    int? bpm = pref!.getInt(defaultSoundKey);
    return bpm;
  }

  // Set default timing
  static Future<void> storeDefaultTiming(int value) async {
    // initialized shared preferences
    final pref = await LocalDB.getPref;
    pref!.setInt(defaultTimingKey, value);
  }

  // Get default timing
  static Future<int?> get getDefaultTiming async {
    // Initialized shared preferences
    final pref = await LocalDB.getPref;
    int? bpm = pref!.getInt(defaultTimingKey);
    return bpm;
  }

  static Future<void> storeDefaultTimerTypeValue(String value) async {
    final pref = await LocalDB.getPref;
    pref!.setString(defaultTimerTypeKey, value);
  }

  static Future<String?> getDefaultTimerTypeValue() async {
    final pref = await LocalDB.getPref;
    return await pref!.getString(defaultTimerTypeKey);
  }

  static Future<void> storeDefaultTimerMinutesValue(String value) async {
    final pref = await LocalDB.getPref;
    pref!.setInt(defaultTimerMinutesKey, int.parse(value));
  }

  static Future<int> getDefaultTimerMinutesValue() async {
    final pref = await LocalDB.getPref;
    return await pref!.getInt(defaultTimerMinutesKey) ?? 1;
  }

  static Future<void> storeTimerIntervalValue(String value) async {
    final pref = await LocalDB.getPref;
    pref!.setInt(defaultTimerIntervalKey, int.parse(value));
  }

  static Future<int> getTimerIntervalValue() async {
    final pref = await LocalDB.getPref;

    return await pref!.getInt(defaultTimerIntervalKey) ?? 10;
  }
}
