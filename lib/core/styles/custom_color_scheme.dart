import 'package:flutter/material.dart';

import 'colors.dart';

extension CustomColorScheme on ColorScheme {
  Color get primaryColorLite => AppColors.primaryColor.withOpacity(0.1);

  Color get buttonColor => AppColors.buttonColor;

  Color get secondaryBgColor => AppColors.secondaryBgColor;

  Color get secondaryBgColorLight => AppColors.secondaryBgColorLight;

  Color get secondaryBgColorDark => AppColors.secondaryBgColorDark;

  Color get dividerAllColor => AppColors.dividerAll;

  Color get dividerColor => AppColors.dividerColor;

  Color get dividerTickColor => AppColors.dividerTickColor;

  Color get primaryTextColor => AppColors.primaryTextColor;

  Color get secondaryTextColor => AppColors.secondaryTextColor;

  Color get secondaryColor => AppColors.secondaryColor;

  Color get secondaryTextColorDark => AppColors.secondaryTextColorDark;

  Color get bottomBarIconColor => AppColors.bottomBarIconColor;

  Color get shimmerBaseColor => AppColors.shimmerBaseColor;

  Color get shimmerHighlightColor => AppColors.shimmerHighlightColor;
}
