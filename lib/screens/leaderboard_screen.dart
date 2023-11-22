// import 'package:flutter/material.dart';
// import 'package:flutter_sizer/flutter_sizer.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:musicgame/controllers/leaderboard_controller.dart';
// import 'package:musicgame/global/global.dart';
// import 'package:musicgame/resources/custom_colors.dart';
// import 'package:musicgame/resources/custom_images.dart';
// import 'package:musicgame/resources/strings.dart';
// import 'package:musicgame/screens/leaderboard/widgets/leaderboard_widget.dart';
//
// // ignore: must_be_immutable
// class LeadershipScreen extends StatelessWidget {
//   String? intervalType;
//   LeadershipScreen({this.intervalType, super.key});
//   LeaderBoardController lc = Get.put(LeaderBoardController());
//   Global g = Global();
//
//   @override
//   Widget build(BuildContext context) {
//     lc.getLearderBoard();
//     return Scaffold(
//       backgroundColor: CustomColors.backgroundColor,
//       body: GetBuilder<LeaderBoardController>(builder: (con) {
//         return SafeArea(
//           child: Padding(
//             padding: EdgeInsets.only(top: 20.dp, left: 10.0.dp, right: 10.0.dp),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                         padding: EdgeInsets.only(left: 150.dp, top: 0.dp),
//                         child: SvgPicture.asset(CustomImages.svg_trophyIcon)),
//                     Padding(
//                       padding:
//                           EdgeInsets.only(left: 0.dp, top: 0.dp, right: 25.dp),
//                       child: GestureDetector(
//                           onTap: () => Get.back(),
//                           child: SizedBox(
//                             width: 25,
//                             height: 25,
//                             child: SvgPicture.asset(
//                                 CustomImages.svg_forward_button),
//                           )),
//                     ),
//                   ],
//                 ),
//                 leaderBoardTitleWidget(),
//                 con.isLoading.value
//                     ? Padding(
//                         padding: EdgeInsets.only(top: 30.0.h),
//                         child: const Center(
//                             child: CircularProgressIndicator(
//                           color: CustomColors.redlight,
//                         )),
//                       )
//                     : Column(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 top: 20.dp, left: 10.0.dp, right: 10.0.dp),
//                             child: Container(
//                               width: 90.w,
//                               height: 10.h,
//                               padding:
//                                   EdgeInsets.only(left: 15.dp, right: 15.dp),
//                               decoration: BoxDecoration(
//                                 borderRadius: const BorderRadius.all(
//                                   Radius.circular(12),
//                                 ),
//                                 border: Border.all(
//                                   color: CustomColors.greyColor,
//                                 ),
//                                 color: CustomColors.greyColor,
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   leaderBoardTextWidget('Current Leader',
//                                       con.highestUserScore.value),
//                                   leaderBoardTextWidget(
//                                       'Score', con.highScore.value),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 top: 20.dp, left: 10.0.dp, right: 10.0.dp),
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding:
//                                       EdgeInsets.symmetric(horizontal: 30.dp),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         Strings.user,
//                                         style: const TextStyle(
//                                             color: Colors.white),
//                                       ),
//                                       Text(
//                                         Strings.scoreTemp,
//                                         style: const TextStyle(
//                                             color: Colors.white),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 populateScoreList(con.scoreList),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//               ],
//             ),
//           ),
//         );
//       }),
//       // bottomNavigationBar: leaderBoardButton(),
//     );
//   }
// }
