
import 'package:flutter/material.dart';
import 'package:suynl/classes/clsSetting.dart';
import 'package:suynl/classes/Themes.dart';
import 'package:suynl/widgets/ads/BannerAdsLarge.dart';

import 'ads/BannerAds.dart';
import 'ads/NativeAds.dart';

class SettingsCardTemplate extends StatelessWidget {

  final clsSetting cls_setting;
  final VoidCallback openClick;
  final VoidCallback buyAction;
  final VoidCallback restoreAction;
  const SettingsCardTemplate({super.key, required this.cls_setting, required this.openClick,required this.buyAction,required this.restoreAction});

  @override
  Widget build(BuildContext context) {

    Widget getIcons(String icons){
      switch(icons){
        case 'language':
          return Icon(Icons.language, size: 16,);
        case 'theme':
          return Icon(Icons.color_lens, size: 16,);
        case 'locker':
          return Icon(Icons.lock, size: 16,);
        case 'exclamation':
          return Icon(Icons.info, size: 16,);
        case 'star':
          return Icon(Icons.star, size: 16,);
      }
      return SizedBox();
    }

    if(cls_setting.icon=='theme'){
      return Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: InkWell(
          onTap:
          openClick,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: getIcons(cls_setting.icon),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cls_setting.title, style: const TextStyle(fontSize: 16, ),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                    height: 10.0,
                    width: 30.0,
                    color: myThemes.getColor(cls_setting.color)
                  ),
                ),
                const Icon(
                    Icons.keyboard_arrow_right_outlined
                ),
              ],
            ),
          ),
        ),
      );
    }
    else if(cls_setting.icon=='language'){
      return Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: InkWell(
          onTap:
          openClick
          ,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: getIcons(cls_setting.icon),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cls_setting.title, style: const TextStyle(fontSize: 16, ),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    cls_setting.rightBox
                  ),
                )
                ,
                const Icon(
                    Icons.keyboard_arrow_right_outlined
                ),
              ],
            ),
          ),
        ),
      );
    }
    else if(cls_setting.icon=='buy'){
      return SafeArea(
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text('You are currently trying the free trial of Simbanay Series One.'),
                SizedBox(height: 10,),
                Text('LIMITED MODE: You can view up to 5 lessons only and it contains ad.'),
                SizedBox(height: 10,),
                Text('To remove ads and view 12 lessons, would you like to purchase the full version of the app? This is a one-time fee only.'),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed:
                          buyAction
                              , child: Text('Buy'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(myThemes.getColor(cls_setting.color)))),
                      SizedBox(width: 10.0,),
                      ElevatedButton(onPressed:
                        restoreAction
                      , child: Text('Restore'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(myThemes.getColor(cls_setting.color)))),
                    ],
                  ),
                )
              ],
        )),
      );
    }
    else if (cls_setting.icon=='nativeAds'){
      return BannerAdsLarge();
    }
    else {
      return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
      ),
      child: InkWell(
        onTap:
        openClick
        ,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 8.0),
                 child: getIcons(cls_setting.icon),
               ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cls_setting.title, style: const TextStyle(fontSize: 16, ),),
                    ],
                  ),
                ),
              ),
              const Icon(
                  Icons.keyboard_arrow_right_outlined
              ),
            ],
          ),
        ),
      ),
    );
    }
  }
}
