import 'package:equalizer_booster/core/base_view.dart';
import 'package:equalizer_booster/core/styles/custom_color_scheme.dart';
import 'package:equalizer_booster/core/styles/sizes.dart';
import 'package:equalizer_booster/core/styles/values.dart';
import 'package:equalizer_booster/view_model/home_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:volume_controller/volume_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onDispose: (model) => model.dispose(),
      onPageBuilder: (context, viewModel, t, themeData) => Scaffold(
          backgroundColor: themeData.colorScheme.background,
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            titleSpacing: AppValues.screenPadding,
            backgroundColor: themeData.colorScheme.background,
            actionsIconTheme:
                IconThemeData(color: themeData.colorScheme.primaryTextColor),
            iconTheme:
                IconThemeData(color: themeData.colorScheme.primaryTextColor),
            title: const Text('Volume Booster'),
            titleTextStyle: TextStyle(
                color: themeData.colorScheme.primaryTextColor,
                fontWeight: FontWeight.w900,
                fontSize: 24),
            toolbarTextStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: themeData.colorScheme.primary,
            ),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Observer(builder: (_) {
                return CircleSlider(
                  value: viewModel.volumeValue,
                  icon: viewModel.systemVolume > 85
                      ? Icons.volume_up_outlined
                      : viewModel.systemVolume > 50
                          ? Icons.volume_up_outlined
                          : viewModel.systemVolume > 85
                              ? Icons.volume_up_outlined
                              : Icons.volume_up_outlined,
                  text: t.volume,
                  t: t,
                  maxim: 150,
                  active: true,
                  onChanged: (volume) {
                    changeVolume(volume, viewModel);
                  },
                );
              }),
              const SizedBox(height: 5),
              Observer(builder: (_) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppValues.screenPadding),
                    child: Row(
                      children: [
                        for (int i = 50; i <= 150; i += 25) ...[
                          bubchoose(
                            themeData,
                            '$i%',
                            (viewModel.volumeValue - i).abs() <= 12,
                            () => changeVolume(i.toDouble(), viewModel,
                                click: true),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
                child: Divider(height: 100, thickness: 2),
              ),
              Observer(builder: (_) {
                return CircleSlider(
                  value: viewModel.bassValue,
                  icon: Icons.speaker_outlined,
                  text: t.bas_boost,
                  color: const Color(0xff486479),
                  active: viewModel.eqactive,
                  t: t,
                  onChanged: (volume) {
                    changeBass(volume, viewModel);
                  },
                );
              }),
              Observer(builder: (_) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppValues.screenPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int i = 0; i <= 100; i += 25) ...[
                          bubchoose(
                            themeData,
                            '$i%',
                            (viewModel.bassValue - i).abs() <= 12,
                            () => changeBass(i.toDouble(), viewModel),
                            color: const Color(0xff486479),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              const Spacer(),
              _bannerAd(viewModel),
              const SizedBox(height: 20),
            ],
          )),
    );
  }

  Observer _bannerAd(HomeViewModel viewModel) {
    return Observer(builder: (_) {
      return (viewModel.bannerAd != null && viewModel.isBannerAdLoaded)
          ? Column(
              children: [
                const SizedBox(height: 0),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: viewModel.bannerAd?.size.width.toDouble(),
                    height: viewModel.bannerAd?.size.height.toDouble(),
                    child: viewModel.bannerAd != null
                        ? AdWidget(ad: viewModel.bannerAd!)
                        : const SizedBox(),
                  ),
                ),
              ],
            )
          : const SizedBox();
    });
  }

  void changeBass(double volume, HomeViewModel viewModel) {
    viewModel.bassValue = volume;

    volume = volume * 10;

    LoudnessEnhancerHelper.setBassGain(volume.toInt());
  }

  void changeVolume(double volume, HomeViewModel viewModel, {bool? click}) {
    VolumeController().setVolume(volume / 100.0, showSystemUI: false);

    viewModel.volumeValue = volume;

    if (volume > 100) {
      LoudnessEnhancerHelper.setTargetGain(((volume * 10)).toInt());

      viewModel.volumeBoostAc = true;
    } else if (viewModel.volumeBoostAc == true) {
      LoudnessEnhancerHelper.setTargetGain(0);
      LoudnessEnhancerHelper.disableLoudnessEnhancer();

      viewModel.volumeBoostAc = false;
    }
  }

  Widget bubchoose(
      ThemeData themeData, String text, bool selected, Function() onPress,
      {Color? color}) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: selected == true
              ? color ?? themeData.colorScheme.secondaryColor
              : Colors.transparent,
          border: Border.all(
            color: selected == true
                ? Colors.transparent
                : themeData.colorScheme.secondaryBgColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: selected != true
                ? themeData.colorScheme.secondaryTextColor
                : Colors.white,
          ),
        ),
      ),
    );
  }
}

class CircleSlider extends StatelessWidget {
  const CircleSlider({
    super.key,
    required this.text,
    required this.icon,
    required this.active,
    required this.t,
    required this.value,
    this.onChanged,
    this.maxim = 100,
    this.color,
  });

  final String text;
  final IconData icon;
  final double maxim;
  final bool active;
  final AppLocalizations t;
  final double value;
  final Color? color;
  final Function(double)? onChanged;

  @override
  Widget build(BuildContext context) {
    double sliderValue = value;
    ThemeData themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.screenPadding),
      margin: const EdgeInsets.only(bottom: 15),
      child: StatefulBuilder(builder: (context, setstate) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 60,
                    activeTrackColor: active
                        ? color ?? themeData.colorScheme.secondaryColor
                        : themeData.colorScheme.secondaryBgColorDark,
                    inactiveTrackColor: active
                        ? themeData.colorScheme.secondaryBgColor
                        : themeData.colorScheme.secondaryBgColor
                            .withOpacity(0.5),
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 0,
                      disabledThumbRadius: 0,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 0.0,
                    ),
                    trackShape: const RoundedRectSliderTrackShape(),
                  ),
                  child: IgnorePointer(
                    ignoring: !active,
                    child: Slider(
                      allowedInteraction: SliderInteraction.slideOnly,
                      thumbColor: Colors.transparent,
                      label: text,
                      value: sliderValue,
                      onChanged: (newValue) {
                        if (onChanged != null) {
                          onChanged!(newValue);
                        }

                        if (newValue == 100 ||
                            newValue == 0 ||
                            newValue == 150) {
                          HapticFeedback.mediumImpact();
                        }
                        if ((newValue / 25).floor() !=
                            (sliderValue / 25).floor()) {
                          HapticFeedback.lightImpact();
                        }

                        setstate(
                          () {
                            sliderValue = newValue;
                          },
                        );
                      },
                      min: 0.0,
                      max: maxim,
                    ),
                  ),
                ),
              ),
            ),
            if (maxim > 100)
              Positioned(
                top: 0,
                bottom: 0,
                right: AppSizes.width30 - 14,
                child: IgnorePointer(
                  ignoring: true,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 20,
                        decoration: BoxDecoration(
                          color: themeData.colorScheme.secondaryColor
                              .withOpacity(0.33),
                        ),
                      ),
                      IgnorePointer(
                        ignoring: true,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Text(
                            t.b_boost,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:
                                  color ?? themeData.colorScheme.secondaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 15,
              right: 15,
              child: IgnorePointer(
                ignoring: true,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: active
                          ? Colors.white
                          : themeData.colorScheme.secondaryTextColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      text,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: active
                            ? Colors.white
                            : themeData.colorScheme.secondaryTextColor,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${sliderValue.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: active
                            ? Colors.white
                            : themeData.colorScheme.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
