import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fretboard/app_utils/app_%20colors.dart';
import 'package:fretboard/app_utils/app_strings.dart';
import 'package:fretboard/views/widgets/custom_switch.dart';

class SettingToggle extends StatelessWidget {
  const SettingToggle({super.key,
    required this.heading,
    required this.value,required this.onChange});

  final String heading;
  final  bool value;
  final  VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding:  EdgeInsets.symmetric(vertical:height*0.015 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            heading,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppStrings.sansFont,
              color: AppColors.whiteSecondary,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
          CustomSwitch(value: value, onChange: onChange,
          )
        ],
      ),
    );
  }
}


class WebSettingToggle extends StatelessWidget {
  const WebSettingToggle({super.key,
    required this.heading,
    required this.value,required this.onChange});

  final String heading;
  final  bool value;
  final  VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical:10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(
            heading,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: AppStrings.sansFont,
                color: AppColors.whiteSecondary,
                fontSize: 1.2.w,
                fontWeight: FontWeight.bold
            ),
          ),
          WebCustomSwitch(value: value, onChange: onChange,)

        ],
      ),
    );
  }
}
