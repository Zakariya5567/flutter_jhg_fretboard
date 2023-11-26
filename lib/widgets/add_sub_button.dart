
import 'package:flutter/material.dart';

import '../utils/app_ colors.dart';

class AddAndSubtractButton extends StatelessWidget {
  const AddAndSubtractButton({super.key,
    required this.onTap,
    required this.isAdd
  });

  final VoidCallback onTap;
  final bool isAdd;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (onTap),
      child: Container(
        height:height * 0.030,
        width: height * 0.030,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color:  AppColors.redPrimary,
        ),
        child: Center(
            child:
                isAdd == true?
            Icon(Icons.add,color: AppColors.whitePrimary,
              size: height*0.025,
            ) :    Icon(Icons.remove,color: AppColors.whitePrimary,
                  size: height*0.025,)
        ),
      ),
    );
  }
  }