import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Future navigateToPage({String? path, Object? data}) async {
    return await navigatorKey.currentState!.pushNamed(path!, arguments: data);
  }

  static Future navigateToPageClear({String? path, Object? data}) async {
    await navigatorKey.currentState!.pushNamedAndRemoveUntil(
      path!,
      (Route<dynamic> route) => false,
      arguments: data,
    );
  }

  static Future navigateToPageReplacement({String? path, Object? data}) async {
    await navigatorKey.currentState!.pushReplacementNamed(
      path!,
      arguments: data,
    );
  }

  static navigatePopPop({String? path, Object? data}) {
    navigatorKey.currentState!
      ..pop()
      ..pop();
  }

  static navigatePop({String? path, Object? data}) {
    navigatorKey.currentState!.pop(data);
  }

  static navigateMaybePop({String? path, Object? data}) {
    navigatorKey.currentState!.maybePop();
  }
}
