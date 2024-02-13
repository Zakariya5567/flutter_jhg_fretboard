import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:fretboard/utils/app_%20colors.dart';

import '../controllers/home_controller.dart';
import '../model/freth_list.dart';

class WebGuitarBoard extends StatefulWidget {
  const WebGuitarBoard({super.key});

  @override
  State<WebGuitarBoard> createState() => _WebGuitarBoardState();
}

class _WebGuitarBoardState extends State<WebGuitarBoard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //NUMBERS
              Container(
                width: 80.w,
                height: 35,
                child: ListView.builder(
                  itemCount: 16,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: getSpace(index)),
                      child: Text(
                        index.toString(),
                        style: TextStyle(
                          color: AppColors.whitePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 1.3.w,
                        ),
                      ),
                    );
                  },
                ),
              ),

              //fretboard
              Container(
                height: 275,
                width: 80.w,
                // alignment: Alignment.,
                child: Stack(
                  children: [
                    //BOARD SIZE WITH COLOR
                    Row(
                      children: [
                        Container(
                          width: 1.5.w,
                        ),
                        Expanded(
                          child: Container(
                            //width: width * 0.8,
                            color: AppColors.creamColor,
                          ),
                        ),
                      ],
                    ),

                    ///============================================================
                    /// BLACK CIRCLE
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: index == 2
                                  ? 2.0.w
                                  : index == 4
                                      ? 3.2.w
                                      : index == 6
                                          ? 3.4.w
                                          : index == 8
                                              ? 3.5.w
                                              : index == 11
                                                  ? 3.5.w
                                                  : index == 14
                                                      ? 3.6.w
                                                      : 3.2.w),
                          child: Container(
                            // height: 7.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                blackCircle(
                                  isColor: index == 11 ? true : false,
                                ),
                                SizedBox(
                                  height: index == 11 ? 15 : 5,
                                ),
                                blackCircle(
                                    isColor: index == 2 ||
                                             index == 4 ||
                                             index == 6 ||
                                              index == 8 ||
                                            index == 14
                                        ? true
                                        : false),
                                SizedBox(
                                  height: index == 11 ? 15 : 5,
                                ),
                                blackCircle(
                                    isColor: index == 11 ? true : false),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: 15,
                    ),

                    ///====================================
                    /// ROW
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 15,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, pos) {
                        return rowDivider(pos);
                      },
                    ),

                    ///=========================================
                    /// COLUMN
                    ListView.builder(
                      itemCount: 6,
                      shrinkWrap: false,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return colDivider(index, controller.highlightString);
                      },
                    ),

                    /// red green  With Grid
                    ///===========================================================

                    AlignedGridView.count(
                      itemCount: 96,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 6,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 2.3,
                      itemBuilder: (context, index) {
                        return redGreenCircle(
                          isColor:
                              controller.selectedFret == index ? true : false,
                          color: controller.selectedNote ==
                                  controller.previousHighlightNode
                              ? AppColors.greenPrimary
                              : AppColors.redPrimary,
                          index: index,
                        );
                      },
                    ),

                    /// Fret press With Grid
                    ///===========================================================

                    Transform.flip(
                      flipX: true,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: AlignedGridView.count(
                          itemCount: 96,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 6,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 4,
                          itemBuilder: (context, index) {
                            final noteIndex = fretList[index];
                            return GestureDetector(
                              onTap: () {
                                controller.playSound(index, noteIndex.note!,
                                    noteIndex.string!);
                              },
                              child: stringPress(index: index),
                            );
                          },
                        ),
                      ),
                    ),

                    ///===========================================================
                  ],
                ),
              ),

              //SPACER
              SizedBox(
                height: 10,
              ),

            ],
          );
        });
  }

  Widget rowDivider(int index) {
    return Padding(
      padding: EdgeInsets.only(left: 5.07.w),
      child: Container(
        width: 0.25.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                AppColors.whiteLight,
                AppColors.whiteLight,
                AppColors.greyPrimary,
                AppColors.blackPrimary
              ]),
        ),
      ),
    );
  }

  Widget colDivider(int index, int? selectedString) {
    return Padding(
      padding: EdgeInsets.only(top: index == 0 ? 21 : 42),
      child: Container(
        height: index == 6
            ? 5.5
            : index == 5
                ? 5
                : index == 4
                    ? 4.5
                    : index == 3
                        ? 4
                        : index == 2
                            ? 3.5
                            : 3,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: selectedString == index + 1
                  ? [AppColors.redPrimary, AppColors.redPrimary]
                  : [
                      AppColors.whiteLight,
                      AppColors.whiteLight,
                      AppColors.greyPrimary,
                      AppColors.blackPrimary
                    ]),
        ),
      ),
    );
  }


  Widget blackCircle({
    bool? isColor,
  }) =>
      Container(
        width: 2.0.w,
        height: 2.0.w,
        decoration: BoxDecoration(
          color: isColor == true ? AppColors.blackPrimary : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.all(0.3.w),
          child: Container(
            width: 2.0.w,
            height: 2.0.w,
            decoration: BoxDecoration(
              color: isColor == true
                  ? AppColors.blackPrimary.withOpacity(0.5)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );

  Widget redGreenCircle({
    bool? isColor,
    required color,
    required int index,
  }) =>
      Padding(
        padding: EdgeInsets.only(left: getHighLightBasedOnIndex(index)),
        child: Container(
          width: 2.0.w,
          height: 2.0.w,
          decoration: BoxDecoration(
            color: isColor == true ? color : Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
      );

  Widget stringPress({
    required int index,
  }) =>
      Container(
       // width: 10,
        height: getFretPressBasedOnIndex(index),
        decoration: BoxDecoration(
          color: Colors.transparent
        ),
        //child: Text("$index"),
      );

  double getHighLightBasedOnIndex(
    int index,
  ) {
    if (index >= 0 && index <= 5) {
      return 0.w;
    } else if (index >= 6 && index <= 11) {
      return 0.1.w;
    } else if (index >= 12 && index <= 17) {
      return 2.7.w;
    } else if (index >= 18 && index <= 23) {
      return 3.4.w;
    } else if (index >= 24 && index <= 29) {
      return 3.2.w;
    } else if (index >= 30 && index <= 35) {
      return 3.4.w;
    } else if (index >= 36 && index <= 41) {
      return 3.3.w;
    } else if (index >= 42 && index <= 47) {
      return 3.3.w;
    } else if (index >= 48 && index <= 53) {
      return 3.3.w;
    } else if (index >= 54 && index <= 59) {
      return 3.2.w;
    } else if (index >= 60 && index <= 65) {
      return 3.5.w;
    } else if (index >= 66 && index <= 71) {
      return 3.2.w;
    } else if (index >= 72 && index <= 77) {
      return 3.2.w;
    } else if (index >= 78 && index <= 83) {
      return 3.2.w;
    } else if (index >= 84 && index <= 89) {
      return 3.8.w;
    } else {
      return 3.5.w;
    }
  }

  double getFretPressBasedOnIndex(
    int index,
  ) {
    if (index >= 0 && index <= 5) {
      return 2.w;
    } else if (index >= 6 && index <= 11) {
      return 3.0.w;
    } else if (index >= 12 && index <= 17) {
      return 4.3.w;
    } else if (index >= 18 && index <= 23) {
      return 5.w;
    } else if (index >= 24 && index <= 29) {
      return 5.w;
    } else if (index >= 30 && index <= 35) {
      return 5.w;
    } else if (index >= 36 && index <= 41) {
      return 4.9.w;
    } else if (index >= 42 && index <= 47) {
      return 5.w;
    } else if (index >= 48 && index <= 53) {
      return 5.w;
    } else if (index >= 54 && index <= 59) {
      return 5.w;
    } else if (index >= 60 && index <= 65) {
      return 4.9.w;
    } else if (index >= 66 && index <= 71) {
      return 5.w;
    } else if (index >= 72 && index <= 77) {
      return 5.w;
    } else if (index >= 78 && index <= 83) {
      return 5.w;
    } else if (index >= 84 && index <= 89) {
      return 5.w;
    } else {
      return 5.w;
    }
  }

  double getSpace(
    int index,
  ) {
    switch (index) {
      case 0:
        return 2.1.w;
      case 1:
        return 4.0.w;
      case 2:
        return 4.0.w;
      case 3:
        return 4.5.w;
      case 4:
        return 4.7.w;
      case 5:
      case 6:
      case 7:
        return 4.7.w;
      case 8:
      case 9:
      case 10:
      case 11:
        return 4.0.w;
      case 12:
      case 13:
      case 14:
        return 4.0.w;
      default:
        return 4.0.w;
    }
  }
}
