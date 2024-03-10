import 'package:flutter/material.dart';
import 'package:flutter_jhg_elements/jhg_elements.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';







class ButtonIcon extends StatelessWidget {
  const ButtonIcon({super.key,
    required this.icon,
    required this .width,
    required this.height,
    required this.onTap,this.color,});

  final String icon;
  final double height;
  final double width;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
       SvgPicture.asset(
           height: height,
           width: width,
           icon)
    );
  }
}



class WebButtonIcon extends StatelessWidget {
  const WebButtonIcon({super.key,
    required this.icon,
    required this .width,
    required this.height,
    required this.onTap,this.color,});

  final String icon;
  final double height;
  final double width;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child:
        Container(
          width: 3.5.w,
          height: 3.5.w,
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          decoration:BoxDecoration(
            color: JHGColors.whiteGrey.withOpacity(0.2),
            shape: BoxShape.circle,
          ),

          child: SvgPicture.asset(
              height: height,
              width: width,
              icon),
        )
    );
  }
}