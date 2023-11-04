import 'package:flutter/material.dart';
import '../utils/app_ colors.dart';
import '../utils/app_constant.dart';
import 'custom_switch.dart';


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
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding:  EdgeInsets.symmetric(vertical:height*0.015 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            heading,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppConstant.sansFont,
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
