import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../decorations/button_decorations.dart';
import '../styles/custom_text_styles.dart';
import '../utils/app_ colors.dart';
import '../utils/app_constant.dart';

final ScrollController _scrollController = ScrollController();

Widget populateScoreList(List data) {
  return Padding(
    padding: const EdgeInsets.only(left: 0.0, top: 0.0),
    child: Card(
      color: const Color.fromARGB(84, 12, 12, 12),
      elevation: 1.0,
      child: SizedBox(
        //  height: 400.dp,
        child: Padding(
          padding: EdgeInsets.only(left: 10.dp, top: 15.0.dp),
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: Column(
              children: [
                ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      var model = data[index];
                      int count = index + 1;
                      return Padding(
                        padding: EdgeInsets.all(8.dp),
                        child: Container(
                            margin: EdgeInsets.only(
                                top: 0.dp, left: 0.dp, right: 5.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  // width: 55.w,
                                  child: Row(
                                    children: [
                                      Text(
                                        "$count. ",
                                        style: CustomTextStyles
                                            .whiteLargeTextStyle,
                                      ),
                                      Text(
                                        "${model[AppConstant.username]}",
                                        style: CustomTextStyles
                                            .whiteLargeTextStyle,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  // width: 20.dp,
                                  child: Text(
                                    "${model[AppConstant.score]}",
                                    textAlign: TextAlign.end,
                                    style: CustomTextStyles.whiteLargeTextStyle,
                                  ),
                                )
                              ],
                            )),
                      );
                    },
                    itemCount: data.length),
                leaderBoardButton()
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

leaderBoardTextWidget(String text1, String text2) {
  return Padding(
    padding: EdgeInsets.only(left: 4.0.dp, right: 4.0.dp),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: (() {
        try {
          double.parse(text2);
          return CrossAxisAlignment.center;
        } catch (e) {
          return CrossAxisAlignment.start;
        }
      })(),
      children: [
        Text(
          text1,
          style: TextStyle(
            fontSize: Adaptive.sp(12),
            color: AppColors.whiteColor,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          text2,
          style: TextStyle(
              fontSize: Adaptive.sp(16),
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

leaderBoardButton() {
  return Padding(
    padding: EdgeInsets.only(left: 50.dp, right: 50.dp, bottom: 35.dp),
    child: GestureDetector(
      child: Container(
        height: 40.dp,
        margin: EdgeInsets.only(top: 20.dp),
        decoration: ButtonDecorations.loadButton(),
        child: Center(
            child: Text(AppConstant.loadMore,
                style: CustomTextStyles.whiteMediumTextStyle)),
      ),
      onTap: () {},
    ),
  );
}

leaderBoardTitleWidget() {
  return Padding(
    padding: EdgeInsets.only(top: 17.dp),
    child: Text(
      AppConstant.titleLeaderBoardTitle,
      style: CustomTextStyles.goldNormalTextStyle,
    ),
  );
}
