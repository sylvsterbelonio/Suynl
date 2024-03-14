import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:suynl/classes/clsApp.dart';

class RewardedInterstitialAds{

  static final  adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5354046379'
      : 'ca-app-pub-3940256099942544/6978759866';
  static final adUnitIdLive = Platform.isAndroid
      ? ''
      : '';

  static void loadAd() {
    RewardedInterstitialAd.load(
        adUnitId: clsApp.displayRealAds ? adUnitIdLive: adUnitId,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            showRewardedInterstitial(ad);
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedInterstitialAd failed to load: $error');
          },
        ));
  }

  static showRewardedInterstitial(RewardedInterstitialAd ad){
    ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      // Reward the user for watching an ad.
    });
  }

}