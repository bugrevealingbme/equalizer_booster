import 'package:equalizer_booster/core/styles/custom_color_scheme.dart';
import 'package:flutter/material.dart';
import '../../core/styles/colors.dart';

enum TextStyleType {
  big,
  headline1,
  headline15,
  headline2,
  headline25,
  headline3,
  subtitle1,
  subtitle2,
}

enum TextStyleColors {
  bottomBarIconColor,
}

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyleType textStyleType;
  final TextStyleColors? textStyleColors;
  final Color? color;
  final int? maxLines;
  final double? fontSizeFactor;
  final int fontWeightDelta;

  const CustomText({
    super.key,
    required this.text,
    required this.textStyleType,
    this.textAlign,
    this.textStyleColors,
    this.color,
    this.maxLines,
    this.fontSizeFactor,
    this.fontWeightDelta = 0,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    TextStyle? textStyle;
    Color? color;

    if (this.color != null) {
      color = this.color;
    } else {
      switch (textStyleColors) {
        case TextStyleColors.bottomBarIconColor:
          color = AppColors.bottomBarIconColor;

          break;

        default:
          color = themeData.colorScheme.primaryTextColor;
          break;
      }
    }

    switch (textStyleType) {
      case TextStyleType.big:
        textStyle = TextStyle(
          fontSize: 26,
          color: color,
          fontWeight: FontWeight.w800,
        );
        break;
      case TextStyleType.headline1:
        textStyle = themeData.textTheme.displayLarge
            ?.apply(color: color, fontWeightDelta: fontWeightDelta);
        break;
      case TextStyleType.headline15:
        textStyle =
            TextStyle(fontSize: 15, color: color, fontWeight: FontWeight.w600);
        break;
      case TextStyleType.headline2:
        textStyle = themeData.textTheme.displayMedium
            ?.apply(color: color, fontWeightDelta: 1);
        break;
      case TextStyleType.headline25:
        textStyle =
            TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.w700);
        break;
      case TextStyleType.headline3:
        textStyle = themeData.textTheme.displaySmall?.apply(color: color);
        break;
      case TextStyleType.subtitle1:
        textStyle = themeData.textTheme.titleMedium
            ?.apply(color: color, fontWeightDelta: fontWeightDelta);
        break;
      case TextStyleType.subtitle2:
        textStyle = themeData.textTheme.titleSmall?.apply(
            color: color,
            fontSizeFactor: fontSizeFactor ?? 1.0,
            fontWeightDelta: fontWeightDelta);
        break;
      default:
    }

    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: textStyle,
    );
  }
}
