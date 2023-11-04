import 'package:flutter/material.dart';
import '../utils/app_ colors.dart';


class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key,required this.value,required this.onChange});

  final  bool value;
  final  VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  InkWell(
      onTap: onChange,
      child: Container(
        height: height*0.038,
        width: width*0.15,
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: value == true ?
          AppColors.greenPrimary : AppColors.greyPrimary,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Padding(
          padding:  EdgeInsets.all(height*0.0050),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height*0.028,
                width: height*0.028,
                decoration: BoxDecoration(
                    color:  value == true ? Colors.transparent:
                    AppColors.blackPrimary,
                    shape: BoxShape.circle
                ),),
              Container(
                height: height*0.028,
                width: height*0.028,
                decoration: BoxDecoration(
                    color:  value == true?
                    AppColors.blackPrimary: Colors.transparent,
                    shape: BoxShape.circle
                ),)
            ],
          ),
        ),
      ),
    );
  }
}
