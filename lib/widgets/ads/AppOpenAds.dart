import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:suynl/classes/clsApp.dart';

class AppOpenAds{

  static final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/9257395921'
      : 'ca-app-pub-3940256099942544/5575463023';
  static final adUnitIdLive = Platform.isAndroid
      ? 'ca-app-pub-7554455378496217/1039518803'
      : '-';

  static void loadAd() {
    AppOpenAd.load(
      adUnitId: clsApp.displayRealAds ? adUnitIdLive : adUnitId,
      orientation: AppOpenAd.orientationPortrait,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          showOpenAppAd(ad);
        },
        onAdFailedToLoad: (error) {
          String value = clsApp.displayRealAds ? adUnitIdLive : adUnitId;
          print('AppOpenAd failed to load: $error' + ' ' + value);
          // Handle the error.
        },
      ),
    );
  }

  static void showOpenAppAd(AppOpenAd ad){
    ad.show();
  }

}