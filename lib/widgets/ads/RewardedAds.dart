import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:suynl/controller/SOL2Controller.dart';

class RewardedAds{

  String testUnitIdAndroid = 'ca-app-pub-3940256099942544/5224354917';
  String testUnitIdIOS = 'ca-app-pub-3940256099942544/1712485313';
  String liveUnitIdAndroid = '';
  String liveUnitIdIOS = '';
  static late final   BuildContext _context;
  static late final   String _value;

  static final  adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';

  static late SOL2Controller _sol2Controller;
  static late Function _response;


  static void loadAd({required BuildContext context,required SOL2Controller sol2Controller,required String value, required Function response}) {
    _context = context;
    _sol2Controller = sol2Controller;
    _value = value;
    _response = response;

    RewardedAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {

                },
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  showRewarded(ad);
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');
          },
        ),
      );
  }

  static showRewarded(RewardedAd ad) async{
    ad.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
      _response(_context,_sol2Controller,_value);
    });



  }



}