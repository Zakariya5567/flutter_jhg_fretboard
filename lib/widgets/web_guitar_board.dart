import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //NUMBERS
              Container(
                width: width * 0.74,
                height: 35,
                child: ListView.builder(
                  itemCount: 16,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: getSpace(index, width)),
                      child: Text(
                        index.toString(),
                        style: TextStyle(
                          color: AppColors.whitePrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: width * 0.012,
                        ),
                      ),
                    );
                  },
                ),
              ),

              //fretboard
              Container(
                height: 255,
                width: width * 0.70,
                // alignment: Alignment.,
                child: Stack(
                  children: [
                    //  BOARD SIZE WITH COLOR
                    Row(
                      children: [
                        Container(
                          width: width * 0.012,
                        ),
                        Expanded(
                          child: Container(
                            width: width * 0.80,
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
                              left: getBlackSpace(index,width),
                          ),
                          child: Container(
                            // height: 7.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                blackCircle(
                                    isColor:
                                    index == 11 ?
                                    true
                                        : false,
                                    width: width),
                                SizedBox(
                                  height: index == 11 ? 7.h : 5.h,
                                ),
                                blackCircle(
                                    width: width,
                                    isColor:
                                    index == 2 ||
                                            index == 4 ||
                                            index == 6 ||
                                            index == 8 ||
                                            index == 14
                                        ?
                                     true
                                        :
                                    false
                                ),
                                SizedBox(
                                  height: index == 11 ? 7.h : 5.h,
                                ),
                                blackCircle(
                                    width: width,
                                    isColor:
                                    index == 11 ?
                                    true
                                        : false
                                ),
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
                        return rowDivider(pos, width);
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
                        return colDivider(
                            index, controller.highlightString, width);
                      },
                    ),

                    /// red green  With Grid
                    ///===========================================================

                    Transform.flip(
                      flipY: true,
                      child: AlignedGridView.count(
                        itemCount: 96,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 6,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 5,
                        itemBuilder: (context, index) {
                          return redGreenCircle(
                            width: width,
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
                    ),

                    /// Fret press With Grid
                    ///===========================================================

                    Transform.flip(
                      flipY: true,
                      child: Transform.flip(
                        flipX: true,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: AlignedGridView.count(
                            itemCount: 96,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 6,
                            mainAxisSpacing: width * 0.0035,
                            crossAxisSpacing: 4,
                            itemBuilder: (context, index) {
                              final noteIndex = fretList[index];
                              return GestureDetector(
                                onTap: () {
                                  controller.playSound(index, noteIndex.note!,
                                      noteIndex.string!);
                                },
                                child: stringPress(index: index, width: width),
                              );
                            },
                          ),
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

  Widget rowDivider(int index, double width) {
    return Padding(
      padding: EdgeInsets.only(left: getFrethSpace(index, width)),
      child: Container(
        width: width * 0.0025,
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
        // child: Text("r$index",style: TextStyle(color:Colors.white ),),
      ),
    );
  }

  Widget colDivider(int index, int? selectedString, double width) {
    return Padding(
      padding: EdgeInsets.only(top: index == 0 ? 18 : 40),
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
        //  child: Text("S$index",style: TextStyle(color:Colors.teal ),),
      ),
    );
  }


  Widget blackCircle({
    bool? isColor,
    required double width,
  }) =>
      Container(
        width: width * 0.020,
        height: width * 0.020,
        decoration: BoxDecoration(
          color: isColor == true ? AppColors.blackPrimary : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.all(width * 0.003),
          child: Container(
            width: width * 0.020,
            height: width * 0.020,
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
    required double width,
  }) =>
      Padding(
        padding: EdgeInsets.only(left: getHighLightBasedOnIndex(index, width)),
        child: Container(
          width: width * 0.020,
          height: width * 0.020,  
          decoration: BoxDecoration(
             color: isColor == true ? color : Colors.transparent,
            //color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),  
      );

  Widget stringPress({
    required int index,
    required double width,
  }) =>
      Container(
        // width: 10,
        height: getFretPressBasedOnIndex(index, width),
        decoration: BoxDecoration(
             color: Colors.transparent
            //color: Colors.green.withOpacity(0.5)
        ),
       // child: Text("$index",style: TextStyle(color: Colors.red),),
      );



  double getFrethSpace(
      int index,
      double width,
      ) {
    if (index == 0 ) {
      return width*0.060;
    } else if (index == 1) {
      return width * 0.057;
    } else if (index == 2) {
      return width * 0.055;
    } else if (index == 3) {
      return width * 0.053;
    } else if (index == 4) {
      return width * 0.051;
    } else if (index == 5) {
      return width * 0.049;
    } else if (index == 6) {
      return width * 0.047;
    } else if (index == 7) {
      return width * 0.044;
    } else if (index == 8) {
      return width * 0.041;
    } else if (index == 9) {
      return width * 0.039;
    } else if (index == 10) {
      return width * 0.037;
    } else if (index == 11) {
      return width * 0.035;
    } else if (index == 12) {
      return width * 0.033;
    } else if (index == 13) {
      return width * 0.031;
    } else if (index == 14) {
      return width * 0.029;
    } else {
      return width * 0.028;
    }
  }


  double getBlackSpace(
      int index,
      double width,
      ) {
    if (index == 0 ) {
      return width*0.034;
    } else if (index == 1) {
      return width * 0.034;
    } else if (index == 2) {
      return width * 0.034;
    } else if (index == 3) {
      return width * 0.034;
    } else if (index == 4) {
      return width * 0.034;
    } else if (index == 5) {
      return width * 0.034;
    } else if (index == 6) {
      return width * 0.030;
    } else if (index == 7) {
      return width * 0.030;
    } else if (index == 8) {
      return width * 0.025;
    } else if (index == 9) {
      return width * 0.020;
    } else if (index == 10) {
      return width * 0.020;
    } else if (index == 11) {
      return width * 0.020;
    } else if (index == 12) {
      return width * 0.015;
    } else if (index == 13) {
      return width * 0.015;
    } else if (index == 14) {
      return width * 0.015;
    } else {
      return width * 0.015;
    }
  }


  double getHighLightBasedOnIndex(
    int index,
    double width,
  ) {
    if (index >= 0 && index <= 5) {
      return 0;
    } else if (index >= 6 && index <= 11) {
      return width * 0.013;
    } else if (index >= 12 && index <= 17) {
      return width * 0.029;
    } else if (index >= 18 && index <= 23) {
      return width * 0.040;
    } else if (index >= 24 && index <= 29) {
      return width * 0.035;
    } else if (index >= 30 && index <= 35) {
      return width * 0.033;
    } else if (index >= 36 && index <= 41) {
      return width * 0.035;
    } else if (index >= 42 && index <= 47) {
      return width * 0.030;
    } else if (index >= 48 && index <= 53) {
      return width * 0.028;
    } else if (index >= 54 && index <= 59) {
      return width * 0.028;
    } else if (index >= 60 && index <= 65) {
      return width * 0.020;
    } else if (index >= 66 && index <= 71) {
      return width * 0.018;
    } else if (index >= 72 && index <= 77) {
      return width * 0.018;
    } else if (index >= 78 && index <= 83) {
      return width * 0.015;
    } else if (index >= 84 && index <= 89) {
      return width * 0.018;
    } else {
      return width * 0.010;
    }
  }

  double getFretPressBasedOnIndex(
    int index,
    double width,
  ) {
    if (index >= 0 && index <= 5) {
      return width * 0.017;
    } else if (index >= 6 && index <= 11) {
      return width * 0.039;
    } else if (index >= 12 && index <= 17) {
      return width * 0.055;
    } else if (index >= 18 && index <= 23) {
      return width * 0.055;
    } else if (index >= 24 && index <= 29) {
      return width * 0.052;
    } else if (index >= 30 && index <= 35) {
      return width * 0.050;
    } else if (index >= 36 && index <= 41) {
      return width * 0.048;
    } else if (index >= 42 && index <= 47) {
      return width * 0.045;
    } else if (index >= 48 && index <= 53) {
      return width * 0.043;
    } else if (index >= 54 && index <= 59) {
      return width * 0.040;
    } else if (index >= 60 && index <= 65) {
      return width * 0.038;
    } else if (index >= 66 && index <= 71) {
      return width * 0.037;
    } else if (index >= 72 && index <= 77) {
      return width * 0.033;
    } else if (index >= 78 && index <= 83) {
      return width * 0.033;
    } else if (index >= 84 && index <= 89) {
      return width * 0.030;
    } else {
      return width * 0.030;
    }
  }

  double getSpace(
    int index,
    double width,
  ) {
    switch (index) {
      case 0:
        return width * 0.021;
      case 1:
        return width * 0.048;
      case 2:
        return width * 0.050;
      case 3:
        return width * 0.052;
      case 4:
        return width * 0.047;
      case 5:
        return width * 0.047;
      case 6:
        return width * 0.047;
      case 7:
        return width * 0.040;
      case 8:
        return width * 0.040;
      case 9:
        return width * 0.030;
      case 10:
        return width * 0.025;
      case 11:
        return width * 0.023;
      case 12:
        return width * 0.020;
      case 13:
        return width * 0.024;
      case 14:
        return width * 0.020;
      case 15:
        return width * 0.015;
      default:
        return width * 0.015;
    }
  }
}

class WebPortraitGuitarBoard extends StatefulWidget {
  const WebPortraitGuitarBoard({super.key});

  @override
  State<WebPortraitGuitarBoard> createState() => _WebPortraitGuitarBoardState();
}

class _WebPortraitGuitarBoardState extends State<WebPortraitGuitarBoard> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //fretboard
                Container(
                  height: height*1.280,
                  width: width*0.14,
                  alignment: Alignment.center,
                  child:
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [

                      // BOARD SIZE WITH COLOR
                      Column(
                        children: [
                          SizedBox(
                            height: height * 0.022,
                          ),
                          Expanded(
                            child: Container(
                              width: width*0.14,
                              color: AppColors.creamColor,
                            ),
                          ),
                        ],
                      ),

                      // BLACK CIRCE
                      Align(
                        alignment: Alignment.topCenter,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              height: height*0.085,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  blackCircle(
                                    height: height,
                                    isColor: index == 11 ? true : false,
                                  ),
                                  SizedBox(
                                    width: index == 11
                                        ? width * 0.0252
                                        : width * 0.0089,
                                  ),
                                  blackCircle(
                                      height: height,
                                      isColor: index == 2 ||
                                              index == 4 ||
                                              index == 6 ||
                                              index == 8 ||
                                              index == 14
                                          ? true
                                          : false),
                                  SizedBox(
                                    width: index == 11
                                        ? width * 0.0252
                                        : width * 0.0089,
                                  ),
                                  blackCircle(
                                      height: height,
                                      isColor: index == 11 ? true : false),
                                ],
                              ),
                            );
                          },
                          itemCount: 15,
                        ),
                      ),

                     // ROW
                      Align(
                        alignment: Alignment.topCenter,
                        child: ListView.builder(
                          itemCount: 15,
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, pos) {
                            return rowDivider(height, pos);
                          },
                        ),
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
                            return colDivider(
                                width, index, controller.highlightString);
                          },
                        ),
                      ),

                      // /// red green  With Grid
                      // ///===========================================================
                      //

                      Align(
                        alignment: Alignment.topCenter,
                        child: AlignedGridView.count(
                          itemCount: 96,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 6,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 2,
                          itemBuilder: (context, index) {
                            return redGreenCircle(
                                isColor: controller.selectedFret == index
                                    ? true
                                    : false,
                                color: controller.selectedNote ==
                                        controller.previousHighlightNode
                                    ? AppColors.greenPrimary
                                    : AppColors.redPrimary,
                                index: index,
                                height: height);
                          },
                        )
                      ),
                      //
                      // /// Fret press With Grid
                      // ///===========================================================
                      //
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
                            final noteIndex = fretList[index];
                            return GestureDetector(
                              onTap: () {
                                controller.playSound(
                                    index, noteIndex.note!, noteIndex.string!);
                              },
                              child: stringPress(
                                  index: index, height: height, width: width),
                            );
                          },
                        ),
                      ),

                      // ///===========================================================
                    ],
                  ),
                ),
                //SPACER
                SizedBox(
                  width: width * 0.004,
                ),
                // NUMBERS
                Container(
                  // color: Colors.red,
                  width: width * 0.016,
                  child: ListView.builder(
                    itemCount: 16,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: getPotraitHeight(index, height),
                        ),
                        child: RotatedBox(
                          quarterTurns: 0,
                          child: Text(
                            index.toString(),
                            style: TextStyle(
                              color: AppColors.whitePrimary,
                              fontWeight: FontWeight.w500,
                              fontSize: height*0.020
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget rowDivider(double height, int index) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.0815),
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
          EdgeInsets.only(left: index == 0 ? width * 0.010 : width * 0.0205),
      child: Container(
        width: index == 6
            ? width * 0.0045
            : index == 5
                ? width * 0.0040
                : index == 4
                    ? width * 0.0035
                    : index == 3
                        ? width * 0.0030
                        : index == 2
                            ? width * 0.0025
                            : width * 0.002,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
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
      Padding( padding: EdgeInsets.only(bottom: getHighLightBasedOnIndex(index, height)),
        child: Container(
          width: height * 0.030,
          height: height * 0.030,
          decoration: BoxDecoration(
            color: isColor == true ? color : Colors.transparent,
            //color: Colors.red,
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
        decoration:  BoxDecoration(
          color: Colors.transparent,
        ),
      );



  double getHighLightBasedOnIndex(
      int index, double height) {
    if (index >= 0 && index <= 5) {
      return height * 0.002;
    } else if (index >= 6 && index <= 11) {
      return height * 0.052;
    } else if (index >= 12 && index <= 17) {
      return height * 0.052;
    } else if (index >= 18 && index <= 23) {
      return height * 0.060;
    } else if (index >= 24 && index <= 29) {
      return height * 0.055;
    } else if (index >= 30 && index <= 35) {
      return height * 0.055;
    } else if (index >= 36 && index <= 41) {
      return height * 0.055;
    } else if (index >= 42 && index <= 47) {
      return height * 0.055;
    } else if (index >= 48 && index <= 53) {
      return height * 0.055;
    } else if (index >= 54 && index <= 59) {
      return height * 0.055;
    } else if (index >= 60 && index <= 65) {
      return height * 0.055;
    } else if (index >= 66 && index <= 71) {
      return height * 0.055;
    } else if (index >= 72 && index <= 77) {
      return height * 0.055;
    } else if (index >= 78 && index <= 83) {
      return height * 0.055;
    } else if (index >= 84 && index <= 89) {
      return height * 0.055;
    } else {
      return height * 0.055;
    }
  }


  double getFretPressBasedOnIndex(int index, double height) {
    if (index >= 0 && index <= 5) {
      return height * 0.017;
    } else if (index >= 6 && index <= 11) {
      return height * 0.062;
    } else if (index >= 12 && index <= 17) {
      return height * 0.083;
    } else if (index >= 18 && index <= 23) {
      return height * 0.080;
    } else if (index >= 24 && index <= 29) {
      return height * 0.080;
    } else if (index >= 30 && index <= 35) {
      return height * 0.082;
    } else if (index >= 36 && index <= 41) {
      return height * 0.082;
    } else if (index >= 42 && index <= 47) {
      return height * 0.082;
    } else if (index >= 48 && index <= 53) {
      return height * 0.082;
    } else if (index >= 54 && index <= 59) {
      return height * 0.082;
    } else if (index >= 60 && index <= 65) {
      return height * 0.082;
    } else if (index >= 66 && index <= 71) {
      return height * 0.082;
    } else if (index >= 72 && index <= 77) {
      return height * 0.082;
    } else if (index >= 78 && index <= 83) {
      return height * 0.082;
    } else if (index >= 84 && index <= 89) {
      return height * 0.082;
    } else {
      return height * 0.080;
    }
  }

  double getPotraitHeight(int index, double height) {
    switch (index) {
      case 0:
        return height * 0.010;
      case 1:
        return height * 0.042;
      case 2:
        return height * 0.058;
      case 3:
        return height * 0.055;
      case 4:
        return height * 0.056;
      case 5:
      case 6:
      case 7:
        return height * 0.058;
      case 8:
      case 9:
      case 10:
      case 11:
      case 12:
      case 13:
      case 14:
        return height * 0.056;
      default:
        return height * 0.05;
    }
  }
}
