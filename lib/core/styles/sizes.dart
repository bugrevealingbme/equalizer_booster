import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizes {
  static double height = ScreenUtil().screenHeight;
  static double height3 = ScreenUtil().screenHeight * .03;
  static double height5 = ScreenUtil().screenHeight * .05;
  static double height6 = ScreenUtil().screenHeight * .06;
  static double height7 = ScreenUtil().screenHeight * .07;
  static double height8 = ScreenUtil().screenHeight * .08;
  static double height9 = ScreenUtil().screenHeight * .09;
  static double height10 = ScreenUtil().screenHeight * .10;
  static double height15 = ScreenUtil().screenHeight * .15;
  static double height20 = ScreenUtil().screenHeight * .20;
  static double height25 = ScreenUtil().screenHeight * .25;
  static double height30 = ScreenUtil().screenHeight * .30;
  static double height32 = ScreenUtil().screenHeight * .32;
  static double height33 = ScreenUtil().screenHeight * .33;
  static double height35 = ScreenUtil().screenHeight * .35;
  static double height37 = ScreenUtil().screenHeight * .37;
  static double height40 = ScreenUtil().screenHeight * .40;
  static double height50 = ScreenUtil().screenHeight * .50;
  static double height60 = ScreenUtil().screenHeight * .60;
  static double height70 = ScreenUtil().screenHeight * .70;
  static double height80 = ScreenUtil().screenHeight * .80;

  static double width = ScreenUtil().screenWidth;
  static double width03 = ScreenUtil().screenWidth * .03;
  static double width04 = ScreenUtil().screenWidth * .04;
  static double width05 = ScreenUtil().screenWidth * .05;
  static double width07 = ScreenUtil().screenWidth * .07;
  static double width10 = ScreenUtil().screenWidth * .10;
  static double width15 = ScreenUtil().screenWidth * .15;
  static double width20 = ScreenUtil().screenWidth * .20;
  static double width25 = ScreenUtil().screenWidth * .25;
  static double width30 = ScreenUtil().screenWidth * .30;
  static double width35 = ScreenUtil().screenWidth * .35;
  static double width45 = ScreenUtil().screenWidth * .45;
  static double width55 = ScreenUtil().screenWidth * .55;
  static double width65 = ScreenUtil().screenWidth * .65;
  static double width70 = ScreenUtil().screenWidth * .70;
  static double width75 = ScreenUtil().screenWidth * .75;
  static double width85 = ScreenUtil().screenWidth * .85;
  static double width95 = ScreenUtil().screenWidth * .95;
  static double width100 = ScreenUtil().screenWidth;

  static double pixelRatio = ScreenUtil().pixelRatio ?? 1;
  static double discoverRoomSize = ScreenUtil().screenWidth * .13721;

  final bool useTabletLayout = ScreenUtil().screenWidth > 600;

  static Widget sizedBoxBottom() {
    return SizedBox(height: ScreenUtil().bottomBarHeight);
  }

  static Widget sizedBoxForExtended(
      {double nega = 0, double toolbarHeight = kToolbarHeight}) {
    return SizedBox(
        height: (toolbarHeight + ScreenUtil().statusBarHeight) - nega);
  }
}
