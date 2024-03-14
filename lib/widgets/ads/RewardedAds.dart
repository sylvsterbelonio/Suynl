import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAds{

  String testUnitIdAndroid = 'ca-app-pub-3940256099942544/5224354917';
  String testUnitIdIOS = 'ca-app-pub-3940256099942544/1712485313';
  String liveUnitIdAndroid = '';
  String liveUnitIdIOS = '';

  static final  adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';

  static void loadAd() {
    RewardedAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            showRewarded(ad);
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        ));
  }

  static showRewarded(RewardedAd ad){
    ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      // Reward the user for watching an ad.
    });
  }

}