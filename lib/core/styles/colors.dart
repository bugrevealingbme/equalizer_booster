import 'package:flutter/material.dart';

class AppColors {
  static const bgColor = Color(0xff202124);
  static const secondaryBgColor = Color(0xff303134);
  static const secondaryBgColorLight = Color(0xff3c4043);
  static const secondaryBgColorDark = Color(0xff4d5154);
  static const primaryColor = Color(0xff724879);
  static const secondaryColor = Color(0xff724879);
  static const buttonColor = Color(0xfff3f4f6);

  static const primaryTextColor = Color(0xffe8eaed);
  static const secondaryTextColor = Color(0xff9aa0a6);
  static const secondaryTextColorDark = Color(0xff999994);

  static const dividerColor = Color(0xff171717);
  static const dividerTickColor = Color(0xff25282b);
  static const dividerAll = Color(0xff3c4043);

  static const bottomBarIconColor = Color(0xff999994);

  static final shimmerBaseColor = Colors.grey.shade800;
  static final shimmerHighlightColor = Colors.grey.shade600;

  static const articleColor = Color(0xff2865ca);
  static const questionColor = Colors.redAccent;
  static const developmentColor = Color.fromRGBO(56, 142, 60, 1);
  static const guideColor = Color(0xff2570E7);
  static const themeAppsModsColor = Color.fromRGBO(255, 145, 0, 1);
  static const accessoriesColor = Color.fromRGBO(249, 168, 37, 1);

  static const photoColor = Color(0xff19b2a6);
  static const pollColor = Color(0xfff5b400);
  static const videoColor = Color(0xff3b48df);

  static const createdUserColor = Color(0xfff0c400);

  static List<Color> lvlColors = const [
    Color(0xffffa200),
    Color(0xffee1224),
    Color(0xff01a7f8),
    Color(0xff2ab900),
    Color(0xff4401a5),
    Color(0xffe82bda),
    Color(0xff343f7c),
    Color(0xff4a4562)
  ];

  static Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
        c.alpha,
        c.red + ((255 - c.red) * p).round(),
        c.green + ((255 - c.green) * p).round(),
        c.blue + ((255 - c.blue) * p).round());
  }

  static Color darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
        (c.blue * f).round());
  }

  static Color invert(Color color) {
    final r = 255 - color.red;
    final g = 255 - color.green;
    final b = 255 - color.blue;

    return Color.fromARGB((color.opacity * 255).round(), r, g, b);
  }

  static createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
