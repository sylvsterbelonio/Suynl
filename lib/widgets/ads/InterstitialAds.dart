import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAds {

  String testUnitIdAndroid = 'ca-app-pub-3940256099942544/1033173712';
  String testUnitIdIOS = 'ca-app-pub-3940256099942544/4411468910';
  String liveUnitIdAndroid = '';
  String liveUnitIdIOS = '';

  static final  adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  static load() {
    InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            showInterstitial(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  static showInterstitial(InterstitialAd ad){
    ad.show();
  }

}

