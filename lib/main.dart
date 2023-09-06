import 'dart:io';

import 'package:equalizer_booster/views/custom_error_view.dart';
import 'package:equalizer_booster/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'core/constants/app_constants.dart';
import 'core/styles/colors.dart';
import 'globals.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

main() async {
  //fixs
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  PaintingBinding.instance.imageCache.maximumSizeBytes =
      1024 * 1024 * 8000; // 8000 MB
  await ScreenUtil.ensureScreenSize();
  MobileAds.instance.initialize();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  upgraded.value = prefs.getBool("upgraded") ?? false;

  //
  OneSignal.Debug.setLogLevel(OSLogLevel.none);
  OneSignal.initialize("d7ecaf93-4de3-4f48-821d-5d43d9bbae70");
  OneSignal.Notifications.requestPermission(true);
  //

  //color and theme
  MaterialColor primaryColor =
      AppColors.createMaterialColor(AppColors.primaryColor);
  ThemeMode themeMode = ThemeMode.system;

  primaryColor = AppColors.createMaterialColor(
      Color(prefs.getInt("wcolor") ?? AppColors.primaryColor.value));
  //

  //lang
  String appLang = 'en'; //await langBox.get('lang');
  appLang = prefs.getString("language") ?? Platform.localeName.substring(0, 2);
  //if lang not supported
  if (!AppConstants.supportedLocales.contains(Locale(appLang))) {
    appLang = 'en';
  }
  //

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MyApp(
            locale: appLang,
            themeMode: themeMode,
            primaryColor: primaryColor,
          )));
}

class MyApp extends StatefulWidget {
  final String locale;
  final ThemeMode themeMode;
  final MaterialColor primaryColor;

  const MyApp(
      {Key? key,
      required this.locale,
      required this.themeMode,
      required this.primaryColor})
      : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>();
}

class MyAppState extends State<MyApp> {
  MaterialColor? _primaryColor;
  Locale? _locale;

  void changeTheme(ThemeMode lthemeMode) {
    setState(() {});
  }

  void changeColor(MaterialColor lprimaryColor) {
    setState(() {
      _primaryColor = lprimaryColor;
    });
  }

  setLocale(Locale value) async {
    setState(() {
      _locale = value;
    });
    if (_locale != null) {
      await AppLocalizations.delegate.load(_locale!);
    }
  }

  setStateState() async {
    setState(() {});
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            builder: (BuildContext context, Widget? widget) {
              ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                return CustomError(errorDetails: errorDetails);
              };
              return widget!;
            },
            title: 'Volume Booster Enhanced',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppConstants.supportedLocales,
            locale: _locale ?? Locale(widget.locale),
            localeResolutionCallback: (
              locale,
              supportedLocales,
            ) {
              return locale;
            },
            theme: ThemeData(
              useMaterial3: true,
              primarySwatch: _primaryColor ?? widget.primaryColor,
              appBarTheme: const AppBarTheme(
                foregroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  systemStatusBarContrastEnforced: false,
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.dark,
                  systemNavigationBarColor: AppColors.bgColor,
                ),
              ),
              dividerColor: AppColors.dividerAll,
              dividerTheme: const DividerThemeData(
                color: AppColors.dividerAll,
              ),
              colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: _primaryColor ?? widget.primaryColor,
                      brightness: Brightness.light,
                      backgroundColor: AppColors.bgColor)
                  .copyWith(background: AppColors.bgColor),
              textTheme: const TextTheme(
                displayLarge: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryTextColor,
                ),
                displayMedium: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryTextColor,
                ),
                displaySmall: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryTextColor,
                ),
                titleSmall: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryTextColor,
                ),
                bodyLarge: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryTextColor,
                ),
                bodyMedium: TextStyle(
                  color: AppColors.primaryTextColor,
                ),
              ),
            ),
            home: const HomeView(),
          );
        });
  }
}
