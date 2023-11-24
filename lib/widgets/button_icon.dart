import 'package:flutter/material.dart';
class ButtonIcon extends StatelessWidget {
  const ButtonIcon({super.key,
    required this.icon,
    required this .width,
    required this.height,
    required this.onTap,this.color , this.iconData});

  final String icon;
  final IconData? iconData;
  final double height;
  final double width;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:  iconData != null
          ? Icon(iconData,color: color,size: height,):
      Image.asset(
        icon,
        height: height,
        width: width,
      ),
    );
  }
}
