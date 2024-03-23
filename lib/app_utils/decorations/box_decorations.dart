import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_jhg_elements/jhg_elements.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fretboard/app_utils/app_%20colors.dart';

class BoxDecorations {
  static double borderWidth = Adaptive.dp(1);
  static double radius = Adaptive.dp(12);

  static BoxDecoration defaultBoxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: JHGColors.charcolGray,
        shape: BoxShape.rectangle);
  }


  static BoxDecoration redBoxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: JHGColors.charcolGray,
        shape: BoxShape.rectangle,
        border: Border(
          top: BorderSide(color: AppColors.redColor, width: borderWidth),
          left: BorderSide(color: AppColors.redColor, width: borderWidth),
          right: BorderSide(color: AppColors.redColor, width: borderWidth),
          bottom: BorderSide(color: AppColors.redColor, width: borderWidth),
        ));
  }

  static BoxDecoration greenBoxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: JHGColors.charcolGray,
        shape: BoxShape.rectangle,
        border: Border(
          top: BorderSide(color: AppColors.greenColor, width: borderWidth),
          left: BorderSide(color: AppColors.greenColor, width: borderWidth),
          right: BorderSide(color: AppColors.greenColor, width: borderWidth),
          bottom: BorderSide(color: AppColors.greenColor, width: borderWidth),
        ));
  }
}
