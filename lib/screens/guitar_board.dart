import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tempo_bpm/model/board_model.dart';
import 'package:tempo_bpm/utils/app_%20colors.dart';

class GuitarBoard extends StatefulWidget {
  const GuitarBoard({super.key});

  @override
  State<GuitarBoard> createState() => _GuitarBoardAltState();
}

class _GuitarBoardAltState extends State<GuitarBoard> {

  List<BoardModel> fretList = [];



  // GuitarController provider = Get.find<GuitarController>();
  // late GuitarProvider provider;
  Future<void> loadFullList() async {
    fretList.clear();
    fretList.add(BoardModel(
        id: 01,
        string: 1,
        fret: 1,
        fretCode: "A#",
        fretSound: "djkdfjf"));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadFullList();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.025),
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
                                width: width * 0.073,
                              ),
                              blackCircle(
                                  height: height,
                                  isColor: index == 2 ||
                                          index == 4 ||
                                          index == 6 ||
                                          index == 8
                                      ? true
                                      : false),
                              SizedBox(
                                width: width * 0.073,
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

                  ListView.builder(
                      itemCount: 6,
                      shrinkWrap: false,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return colDivider(width, index , 5);
                      },
                     ),

                  // // GREEN RED CIRCLE
                  ListView.builder(
                    itemCount: 15,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: height * 0.002),
                        child: Container(
                          height: height * 0.0775, // color: Colors.red,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              redGreenCircle(isColor: true, height: height),
                              SizedBox(
                                width: width * 0.021,
                              ),
                              redGreenCircle(isColor: true, height: height),
                              SizedBox(
                                width: width * 0.021,
                              ),
                              redGreenCircle(isColor: true, height: height),
                              SizedBox(
                                width: width * 0.021,
                              ),
                              redGreenCircle(isColor: true, height: height),
                              SizedBox(
                                width: width * 0.021,
                              ),
                              redGreenCircle(isColor: true, height: height),
                              SizedBox(
                                width: width * 0.021,
                              ),
                              redGreenCircle(isColor: true, height: height),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  /// With Grid
                  ///===========================================================

          // AlignedGridView.count(
          //   crossAxisCount: 4,
          //   mainAxisSpacing: 4,
          //   crossAxisSpacing: 4,
          //   itemBuilder: (context, index) {
          //     return Tile(
          //       index: index,
          //       extent: (index % 7 + 1) * 30,
          //     );
          //   },
          // ),



                  ///===========================================================
                  // // FRETH PRESS

                  // ListView.builder(
                  //   itemCount: 16,
                  //   shrinkWrap: true,
                  //   padding: EdgeInsets.zero,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   itemBuilder: (context, index) {
                  //     return Padding(
                  //       padding: EdgeInsets.only(
                  //
                  //           bottom: height * 0.004
                  //
                  //       ),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           stringPress(
                  //               index: index, height: height, width: width),
                  //           SizedBox(
                  //             width: width * 0.045,
                  //           ),
                  //           stringPress(
                  //               index: index, height: height, width: width),
                  //           SizedBox(
                  //             width: width * 0.045,
                  //           ),
                  //           stringPress(
                  //               index: index, height: height, width: width),
                  //           SizedBox(
                  //             width: width * 0.045,
                  //           ),
                  //           stringPress(
                  //               index: index, height: height, width: width),
                  //           SizedBox(
                  //             width: width * 0.045,
                  //           ),
                  //           stringPress(
                  //               index: index, height: height, width: width),
                  //           SizedBox(
                  //             width: width * 0.045,
                  //           ),
                  //           stringPress(
                  //               index: index, height: height, width: width),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),
                  ///===========================================================

                ],
              ),
            ),
            //SPACER
            SizedBox(
              width: width * 0.02,
            ),
            // NUMBERS
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
                                            ? height * 0.055
                                            : index == 5
                                                ? height * 0.055
                                                : index == 6
                                                    ? height * 0.055
                                                    : index == 7
                                                        ? height * 0.055
                                                        : index == 8
                                                            ? height * 0.055
                                                            : index == 9
                                                                ? height * 0.055
                                                                : index == 10
                                                                    ? height *
                                                                        0.055
                                                                    : index ==
                                                                            11
                                                                        ? height *
                                                                            0.055
                                                                        : index ==
                                                                                12
                                                                            ? height *
                                                                                0.055
                                                                            : index == 13
                                                                                ? height * 0.055
                                                                                : index == 14
                                                                                    ? height * 0.055
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

  Widget colDivider(double width, int index,int selectedIndex) {
    return Padding(
      padding: EdgeInsets.only(
          left:
          index == 0  ?
          width * 0.023 : width * 0.075
      ),
      child: Container(
        width: index == 0
            ? width * 0.011
            : index == 1
                ? width * 0.010
                : index == 2
                    ? width * 0.009
                    : index == 3
                        ? width * 0.008
                        : index == 4
                            ? width * 0.007
                            : width * 0.006,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors:

                  selectedIndex == index ?
                  [
                    AppColors.redPrimary,
                    AppColors.redPrimary
                  ]:

              [
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

  Widget redGreenCircle({bool? isColor, required double height}) => Container(
        width: height * 0.035,
        height: height * 0.035,
        decoration: BoxDecoration(
          color:
              isColor == true ? AppColors.greenPrimary : AppColors.redPrimary,
          shape: BoxShape.circle,
        ),
      );

  Widget stringPress(
          {required int index,
          required double height,
          required double width,}
         ) =>
           Container(
           width: width * 0.040,
           height:
             index == 0 ? height * 0.015 :
             index == 1 ? height * 0.060:
             index == 2 ? height * 0.075 :
             index == 3 ? height * 0.075 :
             index == 4 ? height * 0.077 :
             index == 5 ? height * 0.076 :
             index == 6 ? height * 0.075 :
             index == 7 ? height * 0.076 :
             index == 8 ? height * 0.077 :
             index == 9 ? height * 0.076 :
             index == 10 ? height * 0.076 :
             index == 11 ? height * 0.076 :
             index == 12 ? height * 0.076 :
             index == 13 ? height * 0.075 :
             index == 14 ? height * 0.076 :
             height* 0.076,
             decoration: BoxDecoration(
           color: Colors.deepPurple.withOpacity(0.5),
        ),
      );


  Widget fretSpacePress(
      {required int index,
        required double height,
        required double width}) => Container(
        width: width * 0.060,
        height:
        index == 0 ? height * 0.015 :
        index == 1 ? height * 0.060:
        index == 2 ? height * 0.075 :
        index == 3 ? height * 0.075 :
        index == 4 ? height * 0.077 :
        index == 5 ? height * 0.076 :
        index == 6 ? height * 0.075 :
        index == 7 ? height * 0.076 :
        index == 8 ? height * 0.077 :
        index == 9 ? height * 0.076 :
        index == 10 ? height * 0.076 :
        index == 11 ? height * 0.076 :
        index == 12 ? height * 0.076 :
        index == 13 ? height * 0.075 :
        index == 14 ? height * 0.076 :
        height* 0.076,
        decoration: const BoxDecoration(
          color: Colors.teal,
        ),
      );


}
