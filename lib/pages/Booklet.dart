import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suynl/classes/lesson.dart';
import 'package:suynl/widgets/LessonCardTemplate.dart';
import 'package:suynl/pages/Settings.dart';
import 'package:suynl/classes/Themes.dart';
import 'package:suynl/classes/clsApp.dart';
import 'package:suynl/widgets/ads/RewardedInterstitialAds.dart';

import '../widgets/ads/AppOpenAds.dart';
import '../widgets/ads/BannerAds.dart';
import '../widgets/ads/InterstitialAds.dart';
import '../widgets/ads/RewardedAds.dart';

class Booklet extends StatefulWidget {
  const Booklet({super.key});
  @override
  State<Booklet> createState() => _BookletState();
}

class _BookletState extends State<Booklet>{


  String language = 'English';
  bool bannerAdsLoaded = false;
  Widget bannerAds = BannerAds();
  int adClickCount = 0;

  List<Lesson> lesson = [];
  String appMode = 'trial';

  void loadThemeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      colorTheme = prefs.getString('colorThemes') ?? clsApp.defaultThemeColor;
      appMode = prefs.getString('appMode') ??  clsApp.DEFAULT_APP_MODE;
      language = prefs.getString('defaultLanguage') ?? clsApp.defaultLanguage;
      adClickCount = prefs.getInt('adClickCount') ??  0;

      if(language=='English')
      {lesson = [
        Lesson(lessonNo: '0',title: 'INTRODUCTION',subTitle: 'Introduction',color: colorTheme,language:language),
        Lesson(lessonNo: '1',title: 'SALVATION',subTitle: 'Salvation',color: colorTheme,language:language),
        Lesson(lessonNo: '2',title: 'REPENTANCE',subTitle: 'Repentance',color: colorTheme,language:language),
        Lesson(lessonNo: '3',title: 'LORDSHIP',subTitle: 'Lordship',color: colorTheme,language:language),
        Lesson(lessonNo: '4',title: 'FORGIVENESS',subTitle: 'Forgiveness',color: colorTheme,language:language),
        Lesson(lessonNo: '5',title: 'THE 4 GREATEST MEETINGS',subTitle: 'The 4 Greatest Meetings',color: colorTheme,language:language),
        Lesson(lessonNo: '6',title: 'DEVOTIONAL LIFE',subTitle: 'Devotional Life',color: colorTheme,language:language),
        Lesson(lessonNo: '7',title: 'YOUR ACTIVE LIFE PRAYER',subTitle: 'Your Active Life Prayer',color: colorTheme,language:language),
        Lesson(lessonNo: '8',title: 'SHARING YOUR NEW LIFE WITH OTHERS',subTitle: 'Sharing Your New Life With Others',color: colorTheme,language:language),
        Lesson(lessonNo: '9',title: 'LIFE OF OBEDIENCE',subTitle: 'Life Of Obedience',color: colorTheme,language:language),
        Lesson(lessonNo: '10',title: 'FELLOWSHIP WITH BELIEVERS',subTitle: 'Life In The Church',color: colorTheme,language:language),

      ];}
      else
      {lesson = [
        Lesson(lessonNo: '0',title: 'PASIUNA',subTitle: 'Introduction',color: colorTheme,language:language),
        Lesson(lessonNo: '1',title: 'KALUWASAN',subTitle: 'Salvation',color: colorTheme,language:language),
        Lesson(lessonNo: '2',title: 'PAGHINULSOL',subTitle: 'Repentance',color: colorTheme,language:language),
        Lesson(lessonNo: '3',title: 'ANG PAGKA GINOO NI JESUS',subTitle: 'Lordship',color: colorTheme,language:language),
        Lesson(lessonNo: '4',title: 'KAPASAYLOAN',subTitle: 'Forgiveness',color: colorTheme,language:language),
        Lesson(lessonNo: '5',title: '4 KA MAHINONGDANONG PANAGTIGUM',subTitle: 'The 4 Greatest Meetings',color: colorTheme,language:language),
        Lesson(lessonNo: '6',title: 'DEVOTIONAL LIFE',subTitle: 'Devotional Life',color: colorTheme,language:language),
        Lesson(lessonNo: '7',title: 'ANG IMONG AKTIBONG KINABUHI SA PAG-AMPO',subTitle: 'Your Active Life Prayer',color: colorTheme,language:language),
        Lesson(lessonNo: '8',title: 'BAG-ONG KINABUHI',subTitle: 'Sharing Your New Life With Others',color: colorTheme,language:language),
        Lesson(lessonNo: '9',title: 'KINABUHI SA PAGKAMATINUMANON',subTitle: 'Life Of Obedience',color: colorTheme,language:language),
        Lesson(lessonNo: '10',title: 'PAKIG-UBAN SA MAGTUTOTO',subTitle: 'Life In The Church',color: colorTheme,language:language),
      ];}

    });
  }
  void updateAdClickCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('adClickCount', adClickCount);
  }

  @override
  void initState() {
    // TODO: implement initState
    loadThemeData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children:[

                      Column(
                        children: lesson.map((e) => LessonCardTemplate(
                            lesson: e,
                            appMode: appMode,
                            openLesson: (){
                              setState(() {
                                print(e.lessonNo);
                                if(appMode=='trial'){

                                  InterstitialAds.load();

                                  if(e.lessonNo=='1' || e.lessonNo=='2' || e.lessonNo=='3' || e.lessonNo=='4' || e.lessonNo=='5'){
                                    Navigator.pushNamed(
                                        context, '/lesson_details',arguments: {
                                      'lessonNo' : e.lessonNo,
                                      'title': e.title
                                    });
                                  }else{
                                    showDialog(
                                        context: context,
                                        builder: (context)=> AlertDialog(
                                          title: const Text('Sorry, the app is a trial version. To unlock this, you need to buy the full version of this app.',style: TextStyle(fontSize: 16.0),),
                                          actions: <Widget>[
                                            TextButton(
                                                onPressed: ()=>Navigator.pop(context,false),
                                                child:  Text('Ok',style: TextStyle(color: myThemes.getColor(colorTheme)),)),
                                          ],
                                        )
                                    );
                                  }
                                }else{

                                  //InterstitialAds.load();
                                  //RewardedInterstitialAds.loadAd();
                                  setState(() {

                                    adClickCount++;
                                    if(adClickCount>7){
                                      adClickCount=0;
                                      //AppOpenAds.loadAd();
                                      InterstitialAds.load();
                                    }
                                    updateAdClickCount();
                                    print('adCount=' + adClickCount.toString());

                                    Navigator.pushNamed(
                                        context, '/lesson_details',arguments: {
                                      'lessonNo' : e.lessonNo,
                                      'title': e.title
                                    });
                                  });

                                }


                              });
                            }
                        )).toList(),
                      ),

                    ],

                  ),
                ),
              ),
              BannerAds()])
    );

  }
}