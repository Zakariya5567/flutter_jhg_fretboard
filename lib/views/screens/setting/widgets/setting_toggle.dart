import 'package:flutter/material.dart';
import 'package:flutter_jhg_elements/jhg_elements.dart';
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
            style: JHGTextStyles.labelStyle.copyWith(
              color: AppColors.whiteSecondary,
              fontSize: 16,
            ),
          ),
          CustomSwitch(value: value, onChange: onChange,
          )
        ],
      ),
    );
  }
}
