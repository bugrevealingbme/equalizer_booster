import 'dart:async';
import 'dart:developer';

import 'package:equalizer_booster/globals.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/services.dart';
import 'package:volume_controller/volume_controller.dart';

part 'home_view_model.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  late BuildContext lcontext;
  late List<String> fetchPresets;

  @observable
  BannerAd? bannerAd;
  @observable
  bool isBannerAdLoaded = false;
  final adUnitId = 'ca-app-pub-3753684966275105/4405212157';

  /// Loads a banner ad.
  void loadBannerAd() {
    if (upgraded.value == true) {
      return;
    }

    bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.largeBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isBannerAdLoaded = true;
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @observable
  bool eqactive = true;

  @observable
  bool volumeBoostAc = false;

  @observable
  int selectedEqpres = 0;

  @observable
  double volumeValue = 0;

  @observable
  double bassValue = 0;

  @observable
  double systemVolume = 0;

  @observable
  List<Widget> eqpres = [];

  Timer? timer;

  startRepeatedFunction() async {
    systemVolume = await VolumeController().getVolume();
    volumeValue = systemVolume * 100.0;

    timer = Timer.periodic(const Duration(milliseconds: 200), (timer) async {
      systemVolume = await VolumeController().getVolume();

      if (systemVolume != 1.0) {
        volumeValue = systemVolume * 100.0;
      }
    });
  }

  setContext(BuildContext context) => lcontext = context;

  init() {
    startRepeatedFunction();

    loadBannerAd();

    openReview();
  }

  openReview() async {
    final InAppReview inAppReview = InAppReview.instance;

    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  dispose() {}
}

class LoudnessEnhancerHelper {
  static const platform = MethodChannel('your_channel_name_here');

  /* static Future<void> getmusic() async {
    try {
      dynamic test = await platform.invokeMethod('getMusicInfo');
      log(test.toString());
    } catch (e) {
      print("Error: $e");
    }
  } */

  static Future<void> disableLoudnessEnhancer() async {
    try {
      dynamic test = await platform.invokeMethod('disableLoudnessEnhancer');
      log(test.toString());
    } catch (e) {
      log("Error: $e");
    }
  }

  static Future<void> setTargetGain(int targetGain) async {
    try {
      dynamic test = await platform
          .invokeMethod('setTargetGain', {'targetGain': targetGain});
      log(test.toString());
    } catch (e) {
      log("Error: $e");
    }
  }

  static Future<void> setBassGain(int targetStrength) async {
    try {
      dynamic test = await platform
          .invokeMethod('enableBassBoost', {'targetStrength': targetStrength});
      log(test.toString());
    } catch (e) {
      log("Error: $e");
    }
  }
}
