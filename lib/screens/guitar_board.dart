import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:tempo_bpm/model/board_model.dart';
import 'package:tempo_bpm/providers/home_provider.dart';
import 'package:tempo_bpm/utils/app_%20colors.dart';
import 'package:tempo_bpm/utils/app_constant.dart';

class GuitarBoard extends StatefulWidget {
  const GuitarBoard({super.key,required this.isPortrait});
  final bool  isPortrait ;
  @override
  State<GuitarBoard> createState() => _GuitarBoardAltState();
}

class _GuitarBoardAltState extends State<GuitarBoard> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<HomeProvider>(builder: (context, controller, child) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.0),
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FRETBOARD
              Container(
                width: width * 0.48,
                constraints: BoxConstraints(maxHeight: height * 1.2),
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    // BOARD SIZE WITH COLOR
                    Column(
                      children: [
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Expanded(
                          child: Container(
                            width: width * 0.8,
                            color: AppColors.creamColor,
                          ),
                        ),
                      ],
                    ),

                    // BLACK CIRCE
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: height * 0.002),
                          child: Container(
                            height: height * 0.077,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                blackCircle(
                                  height: height,
                                  isColor: index == 11 ? true : false,
                                ),
                                SizedBox(
                                  width: index == 11 ? width * 0.073:

                                  width * 0.089,
                                ),
                                blackCircle(
                                    height: height,
                                    isColor: index == 2 ||
                                            index == 4 ||
                                            index == 6 ||
                                            index == 8 || index == 14
                                        ? true
                                        : false),
                                SizedBox(
                                    width: index == 11 ? width * 0.070:  width * 0.089,
                                ),
                                blackCircle(
                                    height: height,
                                    isColor: index == 11 ? true : false),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: 15,
                    ),

                    // ROW
                    ListView.builder(
                      itemCount: 15,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, pos) {
                        return rowDivider(height, pos);
                      },
                    ),

                    // COLUMN

                    RotatedBox(
                      quarterTurns: 2,
                      child: ListView.builder(
                        itemCount: 6,
                        shrinkWrap: false,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return colDivider(width, index, controller.highlightString);
                        },
                      ),
                    ),

                    /// red green  With Grid
                    ///===========================================================

                    Align(
                      alignment: Alignment.topCenter,
                      child: AlignedGridView.count(
                        itemCount: 96,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 6,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 4,
                        itemBuilder: (context, index) {
                          return redGreenCircle(
                              isColor: controller.selectedFret == index
                                  ? true
                                  : false,
                              color: controller.selectedFret == controller.previousHighlightFret
                                  ? AppColors.greenPrimary
                                  : AppColors.redPrimary,
                              //controller.getSelectedFret(index),
                              index: index,
                              height: height);
                        },
                      ),
                    ),

                    /// Fret press With Grid
                    ///===========================================================

                    Align(
                      alignment: Alignment.topCenter,
                      child: AlignedGridView.count(
                        itemCount: 96,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 6,
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 4,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                             // controller.setSelectedFret(index);
                              controller.playSound(index);
                            },
                            child: stringPress(
                                index: index, height: height, width: width),
                          );
                        },
                      ),
                    ),

                    ///===========================================================
                  ],
                ),
              ),
              //SPACER
              SizedBox(
                width: width * 0.05,
              ),
              // NUMBERS

              widget.isPortrait == false ? const SizedBox():
              SizedBox(
                width: width * 0.06,
                child: ListView.builder(
                  itemCount: 16,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: index == 0
                              ? height * 0.025
                              : index == 1
                                  ? height * 0.05
                                  : index == 2
                                      ? height * 0.055
                                      : index == 3
                                          ? height * 0.060
                                          : index == 4
                                              ? height * 0.056
                                              : index == 5
                                                  ? height * 0.062
                                                  : index == 6
                                                      ? height * 0.062
                                                      : index == 7
                                                          ? height * 0.062
                                                          : index == 8
                                                              ? height * 0.060
                                                              : index == 9
                                                                  ? height *
                                                                      0.060
                                                                  : index == 10
                                                                      ? height *
                                                                          0.060
                                                                      : index ==
                                                                              11
                                                                          ? height *
                                                                              0.060
                                                                          : index == 12
                                                                              ? height * 0.060
                                                                              : index == 13
                                                                                  ? height * 0.060
                                                                                   : index == 14
                                                                                      ? height * 0.060
                                                                                      : height * 0.05),
                      child: Text(
                        index.toString(),
                        style: TextStyle(
                          color: AppColors.whitePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          height: 1.2,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget rowDivider(double height, int index) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.076),
      child: Container(
        height: height * 0.0038,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
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

  Widget colDivider(double width, int index, int? selectedString) {
    return Padding(
      padding:
          EdgeInsets.only(left: index == 0 ? width * 0.033 : width * 0.074),
      child: Container(
        width:      index == 6 ? width * 0.011
            : index == 5 ? width * 0.010
            : index == 4 ? width * 0.009
            : index == 3 ? width * 0.008
            : index == 2 ? width * 0.007
            : width * 0.006,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: selectedString == index+1
                  ? [AppColors.redPrimary, AppColors.redPrimary]
                  : [ AppColors.whiteLight,
                      AppColors.whiteLight,
                      AppColors.greyPrimary,
                      AppColors.blackPrimary
                    ]),
        ),
      ),
    );
  }

  Widget blackCircle({bool? isColor, required double height}) => Container(
        width: height * 0.024,
        height: height * 0.024,
        decoration: BoxDecoration(
          color: isColor == true ? AppColors.blackPrimary : Colors.transparent,
          shape: BoxShape.circle,
        ),
      );

  Widget redGreenCircle(
          {bool? isColor,
          required color,
          required int index,
          required double height}) =>
      Padding(
        padding:
            EdgeInsets.only(bottom: getHighLightBasedOnIndex(index, height)),
        child: Container(
          width: height * 0.035,
          height: height * 0.035,
          decoration: BoxDecoration(
            color: isColor == true ? color : Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
      );

  Widget stringPress({
    required int index,
    required double height,
    required double width,

  }) =>
      Container(
        width: width * 0.040,
        height: getFretPressBasedOnIndex(index, height),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
      );

  double getHighLightBasedOnIndex(int index, double height) {
    if (index >= 0 && index <= 5) {
      return height * 0.002;
    } else if (index >= 6 && index <= 11) {
      return height * 0.032;
    } else if (index >= 12 && index <= 17) {
      return height * 0.042;
    } else if (index >= 18 && index <= 23) {
      return height * 0.045;
    } else if (index >= 24 && index <= 29) {
      return height * 0.045;
    } else if (index >= 30 && index <= 35) {
      return height * 0.045;
    } else if (index >= 36 && index <= 41) {
      return height * 0.045;
    } else if (index >= 42 && index <= 47) {
      return height * 0.045;
    } else if (index >= 48 && index <= 53) {
      return height * 0.045;
    } else if (index >= 54 && index <= 59) {
      return height * 0.045;
    } else if (index >= 60 && index <= 65) {
      return height * 0.045;
    } else if (index >= 66 && index <= 71) {
      return height * 0.045;
    } else if (index >= 72 && index <= 77) {
      return height * 0.045;
    } else if (index >= 78 && index <= 83) {
      return height * 0.045;
    } else if (index >= 84 && index <= 89) {
      return height * 0.045;
    } else {
      return height * 0.045;
    }
  }

  double getFretPressBasedOnIndex(int index, double height) {
    if (index >= 0 && index <= 5) {
      return height * 0.013;
    } else if (index >= 6 && index <= 11) {
      return height * 0.062;
    } else if (index >= 12 && index <= 17) {
      return height * 0.075;
    } else if (index >= 18 && index <= 23) {
      return height * 0.076;
    } else if (index >= 24 && index <= 29) {
      return height * 0.076;
    } else if (index >= 30 && index <= 35) {
      return height * 0.076;
    } else if (index >= 36 && index <= 41) {
      return height * 0.076;
    } else if (index >= 42 && index <= 47) {
      return height * 0.075;
    } else if (index >= 48 && index <= 53) {
      return height * 0.076;
    } else if (index >= 54 && index <= 59) {
      return height * 0.076;
    } else if (index >= 60 && index <= 65) {
      return height * 0.075;
    } else if (index >= 66 && index <= 71) {
      return height * 0.076;
    } else if (index >= 72 && index <= 77) {
      return height * 0.076;
    } else if (index >= 78 && index <= 83) {
      return height * 0.076;
    } else if (index >= 84 && index <= 89) {
      return height * 0.076;
    } else {
      return height * 0.076;
    }
  }
}
