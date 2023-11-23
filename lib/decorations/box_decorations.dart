import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:fretboard/utils/app_%20colors.dart';

class BoxDecorations {
  static double boderWidth = Adaptive.dp(1);
  static double radius = Adaptive.dp(12);

  static BoxDecoration defaultBoxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: AppColors.greyPrimary,
        shape: BoxShape.rectangle);
  }


  static BoxDecoration redBoxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: AppColors.greyPrimary,
        shape: BoxShape.rectangle,
        border: Border(
          top: BorderSide(color: AppColors.redColor, width: boderWidth),
          left: BorderSide(color: AppColors.redColor, width: boderWidth),
          right: BorderSide(color: AppColors.redColor, width: boderWidth),
          bottom: BorderSide(color: AppColors.redColor, width: boderWidth),
        ));
  }

  static BoxDecoration greenBoxDecoration() {
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: AppColors.greyColor,
        shape: BoxShape.rectangle,
        border: Border(
          top: BorderSide(color: AppColors.greenColor, width: boderWidth),
          left: BorderSide(color: AppColors.greenColor, width: boderWidth),
          right: BorderSide(color: AppColors.greenColor, width: boderWidth),
          bottom: BorderSide(color: AppColors.greenColor, width: boderWidth),
        ));
  }
}
