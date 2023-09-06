// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on HomeViewModelBase, Store {
  late final _$bannerAdAtom =
      Atom(name: 'HomeViewModelBase.bannerAd', context: context);

  @override
  BannerAd? get bannerAd {
    _$bannerAdAtom.reportRead();
    return super.bannerAd;
  }

  @override
  set bannerAd(BannerAd? value) {
    _$bannerAdAtom.reportWrite(value, super.bannerAd, () {
      super.bannerAd = value;
    });
  }

  late final _$isBannerAdLoadedAtom =
      Atom(name: 'HomeViewModelBase.isBannerAdLoaded', context: context);

  @override
  bool get isBannerAdLoaded {
    _$isBannerAdLoadedAtom.reportRead();
    return super.isBannerAdLoaded;
  }

  @override
  set isBannerAdLoaded(bool value) {
    _$isBannerAdLoadedAtom.reportWrite(value, super.isBannerAdLoaded, () {
      super.isBannerAdLoaded = value;
    });
  }

  late final _$eqactiveAtom =
      Atom(name: 'HomeViewModelBase.eqactive', context: context);

  @override
  bool get eqactive {
    _$eqactiveAtom.reportRead();
    return super.eqactive;
  }

  @override
  set eqactive(bool value) {
    _$eqactiveAtom.reportWrite(value, super.eqactive, () {
      super.eqactive = value;
    });
  }

  late final _$volumeBoostAcAtom =
      Atom(name: 'HomeViewModelBase.volumeBoostAc', context: context);

  @override
  bool get volumeBoostAc {
    _$volumeBoostAcAtom.reportRead();
    return super.volumeBoostAc;
  }

  @override
  set volumeBoostAc(bool value) {
    _$volumeBoostAcAtom.reportWrite(value, super.volumeBoostAc, () {
      super.volumeBoostAc = value;
    });
  }

  late final _$selectedEqpresAtom =
      Atom(name: 'HomeViewModelBase.selectedEqpres', context: context);

  @override
  int get selectedEqpres {
    _$selectedEqpresAtom.reportRead();
    return super.selectedEqpres;
  }

  @override
  set selectedEqpres(int value) {
    _$selectedEqpresAtom.reportWrite(value, super.selectedEqpres, () {
      super.selectedEqpres = value;
    });
  }

  late final _$volumeValueAtom =
      Atom(name: 'HomeViewModelBase.volumeValue', context: context);

  @override
  double get volumeValue {
    _$volumeValueAtom.reportRead();
    return super.volumeValue;
  }

  @override
  set volumeValue(double value) {
    _$volumeValueAtom.reportWrite(value, super.volumeValue, () {
      super.volumeValue = value;
    });
  }

  late final _$bassValueAtom =
      Atom(name: 'HomeViewModelBase.bassValue', context: context);

  @override
  double get bassValue {
    _$bassValueAtom.reportRead();
    return super.bassValue;
  }

  @override
  set bassValue(double value) {
    _$bassValueAtom.reportWrite(value, super.bassValue, () {
      super.bassValue = value;
    });
  }

  late final _$systemVolumeAtom =
      Atom(name: 'HomeViewModelBase.systemVolume', context: context);

  @override
  double get systemVolume {
    _$systemVolumeAtom.reportRead();
    return super.systemVolume;
  }

  @override
  set systemVolume(double value) {
    _$systemVolumeAtom.reportWrite(value, super.systemVolume, () {
      super.systemVolume = value;
    });
  }

  late final _$eqpresAtom =
      Atom(name: 'HomeViewModelBase.eqpres', context: context);

  @override
  List<Widget> get eqpres {
    _$eqpresAtom.reportRead();
    return super.eqpres;
  }

  @override
  set eqpres(List<Widget> value) {
    _$eqpresAtom.reportWrite(value, super.eqpres, () {
      super.eqpres = value;
    });
  }

  @override
  String toString() {
    return '''
bannerAd: ${bannerAd},
isBannerAdLoaded: ${isBannerAdLoaded},
eqactive: ${eqactive},
volumeBoostAc: ${volumeBoostAc},
selectedEqpres: ${selectedEqpres},
volumeValue: ${volumeValue},
bassValue: ${bassValue},
systemVolume: ${systemVolume},
eqpres: ${eqpres}
    ''';
  }
}
