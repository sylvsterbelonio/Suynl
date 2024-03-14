import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suynl/classes/clsApp.dart';

class BannerAdsLarge extends StatefulWidget {
  const BannerAdsLarge({Key? key}) : super(key:key);
  @override
  State<BannerAdsLarge> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAdsLarge> {
  BannerAd? bannerAd;
  bool isBannerAdLoaded = false;

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';
  final adUnitIdLive = Platform.isAndroid
      ? 'ca-app-pub-7554455378496217/9066312517'
      : 'ca-app-pub-7554455378496217/2504003089';

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    initializeBanner();
  }

  void initializeBanner(){
    bannerAd = BannerAd(
        size: AdSize.largeBanner,
        adUnitId: clsApp.displayRealAds ? adUnitIdLive : adUnitId,
        listener: BannerAdListener(
            onAdFailedToLoad: (ad, error) {
              String value = clsApp.displayRealAds ? adUnitIdLive : adUnitId;
              print('ad Failed to load->'+ error.message + ' ' + value);
              ad.dispose();
            },
            onAdLoaded: (ad) {
              print('Ad Loaded');
              setState(() {
                isBannerAdLoaded = true;
              });
            }),
        request: const AdRequest());
    bannerAd!.load();
  }

  String appMode = 'trial';

  void loadThemeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      appMode = prefs.getString('appMode') ?? clsApp.DEFAULT_APP_MODE;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadThemeData();
    initializeBanner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (appMode == 'full') {
      return isBannerAdLoaded
          ? SafeArea(
        child: Column(
            children: [
              Center(child: Text('Advertisement', style: TextStyle(fontSize: 10.0),)),
              SizedBox(
                width: double.infinity,
                height: bannerAd?.size.height.toDouble(),
                child: AdWidget(
                    ad: bannerAd!
                ),
              ),
            ]),
      ) : SizedBox(height: 0,);
    }
    else {
      return SizedBox(height: 0,);
    }
    return SizedBox(height: 0,);
  }

}
