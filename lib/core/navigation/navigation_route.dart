/* import 'package:flutter/material.dart';

import '../../views/home_view.dart';
import '../constants/route_names.dart';

class NavigationRoute {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.DEFAULT:
        return normalNavigate(const HomeView());
      case RouteNames.HOME_SCREEN:
        return normalNavigate(const HomeView());

      default:
        return normalNavigate(const HomeView());
    }
  }

  static MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }

  static PageRouteBuilder noAnimationNavigate(Widget widget) {
    return PageRouteBuilder(pageBuilder: (_, __, ___) => widget);
  }
}
*/