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
                width: width*0.80,
                height: 35,
                child: ListView.builder(
                  itemCount: 16,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: getSpace(index,width)),
                      child: Text(
                        index.toString(),
                        style: TextStyle(
                          color: AppColors.whitePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: width*0.013,
                        ),
                      ),
                    );
                  },
                ),
              ),

              //fretboard
              Container(
                height: 255,
                width: width*0.80,
                // alignment: Alignment.,
                child: Stack(
                  children: [

                    //  BOARD SIZE WITH COLOR
                    Row(
                      children: [
                        Container(
                          width: width*0.012,
                        ),
                        Expanded(
                          child: Container(
                            width: width*0.80,
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
                                  ? width*0.020
                                  : index == 4
                                      ? width*0.032
                                      : index == 6
                                          ? width*0.034
                                          : index == 8
                                              ? width*0.035
                                              : index == 11
                                                  ? width*0.032
                                                  : index == 14
                                                      ? width*0.036
                                                      : width*0.032),
                          child: Container(
                            // height: 7.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                blackCircle(
                                  isColor: index == 11 ? true : false,
                                  width: width
                                ),
                                SizedBox(
                                  height: index == 11 ? 7.h : 5.h,
                                ),
                                blackCircle(
                                    width: width,
                                    isColor: index == 2 ||
                                             index == 4 ||
                                             index == 6 ||
                                              index == 8 ||
                                             index == 14
                                        ? true
                                        : false),
                                SizedBox(
                                  height: index == 11 ? 7.h : 5.h,
                                ),
                                blackCircle(
                                    width: width,
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
                        return rowDivider(pos,width);
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
                        return colDivider(index, controller.highlightString,width);
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
                            isColor: controller.selectedFret == index ? true : false,
                            color: controller.selectedNote == controller.previousHighlightNode
                                ? AppColors.greenPrimary : AppColors.redPrimary,
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
                        child:
                        RotatedBox(
                          quarterTurns: 1,
                          child:
                          AlignedGridView.count(
                            itemCount: 96,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 6,
                            mainAxisSpacing: width*0.0035,
                            crossAxisSpacing: 4,
                            itemBuilder: (context, index) {
                              final noteIndex = fretList[index];
                              return GestureDetector(
                                onTap: () {
                                  controller.playSound(index, noteIndex.note!,
                                      noteIndex.string!);
                                },
                                child: stringPress(index: index,width: width),
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

  Widget rowDivider(int index,double width) {
    return Padding(
      padding: EdgeInsets.only(left:    width*0.0507),
      child: Container(
        width:   width*0.0025,
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

  Widget colDivider(int index, int? selectedString,double width) {
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
        width: width*0.020,
        height:width*0.020,
        decoration: BoxDecoration(
          color: isColor == true ? AppColors.blackPrimary : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.all(width*0.003),
          child: Container(
            width: width*0.020,
            height:width*0.020,
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
        padding: EdgeInsets.only(left: getHighLightBasedOnIndex(index,width)),
        child: Container(
          width: width*0.020,
          height: width*0.020,
          decoration: BoxDecoration( 
            color: isColor == true ? color : Colors.transparent,
            shape: BoxShape.circle,
          ),
        //  child: Text("$index",style: TextStyle(color:Colors.blue ),),
        ),
      );

  Widget stringPress({
    required int index,
    required double width,
  }) =>
      Container(
       // width: 10,
        height: getFretPressBasedOnIndex(index,width),
        decoration: BoxDecoration(
           color: Colors.transparent
        ),
      );

  double getHighLightBasedOnIndex(
    int index,
    double width,
  ) {
    if (index >= 0 && index <= 5) {
      return 0;
    } else if (index >= 6 && index <= 11) {
      return width*0.003;
    } else if (index >= 12 && index <= 17) {
      return width*0.025;
    } else if (index >= 18 && index <= 23) {
      return width*0.034;
    } else if (index >= 24 && index <= 29) {
      return width*0.032;
    } else if (index >= 30 && index <= 35) {
      return width*0.033;
    } else if (index >= 36 && index <= 41) {
      return width*0.033;
    } else if (index >= 42 && index <= 47) {
      return width*0.033;
    } else if (index >= 48 && index <= 53) {
      return width*0.033;
    } else if (index >= 54 && index <= 59) {
      return width*0.032;
    } else if (index >= 60 && index <= 65) {
      return width*0.034;
    } else if (index >= 66 && index <= 71) {
      return width*0.032;
    } else if (index >= 72 && index <= 77) {
      return width*0.032;
    } else if (index >= 78 && index <= 83) {
      return width*0.032;
    } else if (index >= 84 && index <= 89) {
      return width*0.037;
    } else {
      return width*0.035;
    }
  }

  double getFretPressBasedOnIndex(
    int index, double width,
  ) {
    if (index >= 0 && index <= 5) {
      return width*0.017;
    } else if (index >= 6 && index <= 11) {
      return width*0.029;
    } else if (index >= 12 && index <= 17) {
      return width*0.049;
    } else if (index >= 18 && index <= 23) {
      return width*0.050;
    } else if (index >= 24 && index <= 29) {
      return width*0.050;
    } else if (index >= 30 && index <= 35) {
      return width*0.050;
    } else if (index >= 36 && index <= 41) {
      return width*0.049;
    } else if (index >= 42 && index <= 47) {
      return width*0.050;
    } else if (index >= 48 && index <= 53) {
      return width*0.050;
    } else if (index >= 54 && index <= 59) {
      return width*0.050;
    } else if (index >= 60 && index <= 65) {
      return width*0.049;
    } else if (index >= 66 && index <= 71) {
      return width*0.050;
    } else if (index >= 72 && index <= 77) {
      return width*0.050;
    } else if (index >= 78 && index <= 83) {
      return width*0.050;
    } else if (index >= 84 && index <= 89) {
      return width*0.050;
    } else {
      return width*0.050;
    }
  }

  double getSpace(
    int index,
    double width,
  ) {
    switch (index) {
      case 0:
        return width*0.021;
      case 1:
        return width*0.040;
      case 2:
        return width*0.040;
      case 3:
        return width*0.045;
      case 4:
        return width*0.047;
      case 5:
      case 6:
      case 7:
        return width*0.047;
      case 8:
      case 9:
      case 10:
      case 11:
        return width*0.040;
      case 12:
      case 13:
      case 14:
        return width*0.040;
      default:
        return width*0.040;
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //NUMBERS
              Container(
                width: width*0.80,
                height: 35,
                child: ListView.builder(
                  itemCount: 16,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: getSpace(index,width)),
                      child: Text(
                        index.toString(),
                        style: TextStyle(
                          color: AppColors.whitePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: width*0.013,
                        ),
                      ),
                    );
                  },
                ),
              ),

              //fretboard
              Container(
                height: 255,
                width: width*0.80,
                // alignment: Alignment.,
                child: Stack(
                  children: [

                    //  BOARD SIZE WITH COLOR
                    Row(
                      children: [
                        Container(
                          width: width*0.012,
                        ),
                        Expanded(
                          child: Container(
                            width: width*0.80,
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
                                  ? width*0.020
                                  : index == 4
                                  ? width*0.032
                                  : index == 6
                                  ? width*0.034
                                  : index == 8
                                  ? width*0.035
                                  : index == 11
                                  ? width*0.032
                                  : index == 14
                                  ? width*0.036
                                  : width*0.032),
                          child: Container(
                            // height: 7.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                blackCircle(
                                    isColor: index == 11 ? true : false,
                                    width: width
                                ),
                                SizedBox(
                                  height: index == 11 ? 7.h : 5.h,
                                ),
                                blackCircle(
                                    width: width,
                                    isColor: index == 2 ||
                                        index == 4 ||
                                        index == 6 ||
                                        index == 8 ||
                                        index == 14
                                        ? true
                                        : false),
                                SizedBox(
                                  height: index == 11 ? 7.h : 5.h,
                                ),
                                blackCircle(
                                    width: width,
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
                        return rowDivider(pos,width);
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
                        return colDivider(index, controller.highlightString,width);
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
                            isColor: controller.selectedFret == index ? true : false,
                            color: controller.selectedNote == controller.previousHighlightNode
                                ? AppColors.greenPrimary : AppColors.redPrimary,
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
                        child:
                        RotatedBox(
                          quarterTurns: 1,
                          child:
                          AlignedGridView.count(
                            itemCount: 96,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 6,
                            mainAxisSpacing: width*0.0035,
                            crossAxisSpacing: 4,
                            itemBuilder: (context, index) {
                              final noteIndex = fretList[index];
                              return GestureDetector(
                                onTap: () {
                                  controller.playSound(index, noteIndex.note!,
                                      noteIndex.string!);
                                },
                                child: stringPress(index: index,width: width),
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

  Widget rowDivider(int index,double width) {
    return Padding(
      padding: EdgeInsets.only(left:    width*0.0507),
      child: Container(
        width:   width*0.0025,
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

  Widget colDivider(int index, int? selectedString,double width) {
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
        width: width*0.020,
        height:width*0.020,
        decoration: BoxDecoration(
          color: isColor == true ? AppColors.blackPrimary : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.all(width*0.003),
          child: Container(
            width: width*0.020,
            height:width*0.020,
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
        padding: EdgeInsets.only(left: getHighLightBasedOnIndex(index,width)),
        child: Container(
          width: width*0.020,
          height: width*0.020,
          decoration: BoxDecoration(
            color: isColor == true ? color : Colors.transparent,
            shape: BoxShape.circle,
          ),
          //  child: Text("$index",style: TextStyle(color:Colors.blue ),),
        ),
      );

  Widget stringPress({
    required int index,
    required double width,
  }) =>
      Container(
        // width: 10,
        height: getFretPressBasedOnIndex(index,width),
        decoration: BoxDecoration(
            color: Colors.transparent
        ),
      );

  double getHighLightBasedOnIndex(
      int index,
      double width,
      ) {
    if (index >= 0 && index <= 5) {
      return 0;
    } else if (index >= 6 && index <= 11) {
      return width*0.003;
    } else if (index >= 12 && index <= 17) {
      return width*0.025;
    } else if (index >= 18 && index <= 23) {
      return width*0.034;
    } else if (index >= 24 && index <= 29) {
      return width*0.032;
    } else if (index >= 30 && index <= 35) {
      return width*0.033;
    } else if (index >= 36 && index <= 41) {
      return width*0.033;
    } else if (index >= 42 && index <= 47) {
      return width*0.033;
    } else if (index >= 48 && index <= 53) {
      return width*0.033;
    } else if (index >= 54 && index <= 59) {
      return width*0.032;
    } else if (index >= 60 && index <= 65) {
      return width*0.034;
    } else if (index >= 66 && index <= 71) {
      return width*0.032;
    } else if (index >= 72 && index <= 77) {
      return width*0.032;
    } else if (index >= 78 && index <= 83) {
      return width*0.032;
    } else if (index >= 84 && index <= 89) {
      return width*0.037;
    } else {
      return width*0.035;
    }
  }

  double getFretPressBasedOnIndex(
      int index, double width,
      ) {
    if (index >= 0 && index <= 5) {
      return width*0.017;
    } else if (index >= 6 && index <= 11) {
      return width*0.029;
    } else if (index >= 12 && index <= 17) {
      return width*0.049;
    } else if (index >= 18 && index <= 23) {
      return width*0.050;
    } else if (index >= 24 && index <= 29) {
      return width*0.050;
    } else if (index >= 30 && index <= 35) {
      return width*0.050;
    } else if (index >= 36 && index <= 41) {
      return width*0.049;
    } else if (index >= 42 && index <= 47) {
      return width*0.050;
    } else if (index >= 48 && index <= 53) {
      return width*0.050;
    } else if (index >= 54 && index <= 59) {
      return width*0.050;
    } else if (index >= 60 && index <= 65) {
      return width*0.049;
    } else if (index >= 66 && index <= 71) {
      return width*0.050;
    } else if (index >= 72 && index <= 77) {
      return width*0.050;
    } else if (index >= 78 && index <= 83) {
      return width*0.050;
    } else if (index >= 84 && index <= 89) {
      return width*0.050;
    } else {
      return width*0.050;
    }
  }

  double getSpace(
      int index,
      double width,
      ) {
    switch (index) {
      case 0:
        return width*0.021;
      case 1:
        return width*0.040;
      case 2:
        return width*0.040;
      case 3:
        return width*0.045;
      case 4:
        return width*0.047;
      case 5:
      case 6:
      case 7:
        return width*0.047;
      case 8:
      case 9:
      case 10:
      case 11:
        return width*0.040;
      case 12:
      case 13:
      case 14:
        return width*0.040;
      default:
        return width*0.040;
    }
  }
}
