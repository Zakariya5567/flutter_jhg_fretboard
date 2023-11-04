import 'package:flutter/material.dart';
class ButtonIcon extends StatelessWidget {
  const ButtonIcon({super.key,
    required this.icon,
    required this .width,
    required this.height,
    required this.onTap});

  final String icon;
  final double height;
  final double width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        icon,
        height: height,
        width: width,
      ),
    );
  }
}
