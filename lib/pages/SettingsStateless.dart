import 'package:flutter/material.dart';
import 'package:suynl/classes/clsSetting.dart';
import 'package:url_launcher/url_launcher.dart';
import '../classes/clsThemeColor.dart';
import '../widgets/ColorThemeSwitcher.dart';
import '../widgets/SettingsCardTemplate.dart';
import 'package:suynl/widgets/LanguageSwitcher.dart';

class SettingsStateless extends StatelessWidget {
  final String colorTheme;
  final Function selectedColor;
  final Function selectedLanguage;
  final String appMode;
  final String language;

  const SettingsStateless({super.key,required this.colorTheme,required this.selectedLanguage,required this.selectedColor,required this.appMode,required this.language});

  @override
  Widget build(BuildContext context) {

    Future<void> _launchUrl(String url) async {
      final Uri _url = Uri.parse(url);
      if (!await launchUrl(_url,mode: LaunchMode.inAppWebView)) {
        throw Exception('Could not launch $_url');
      }
    }

    void buyAction() async{
      print('buy');
    }
    void restoreAction(){
      print('restore');
    }

    print('first load sa settings ->'+language);
    print('first load sa color settings ->'+colorTheme);


    List<String> options = ['Black', 'Green', 'Blue', 'Orange', 'Pink', 'Red', 'Purple', 'Teal'];
    List<clsSetting> clsSettings = [];

    if(appMode=='trial'){
      clsSettings = [
        clsSetting(icon: 'language',title: 'Language', rightBox: language,color: colorTheme),
        clsSetting(icon: 'theme',title: 'Theme:', rightBox: 'yes',color: colorTheme),
        clsSetting(icon: 'locker',title: 'Privacy Policy', rightBox: '',color: colorTheme),
        clsSetting(icon: 'exclamation',title: 'Terms & Condition', rightBox: '',color: colorTheme),
        //clsSetting(icon: 'star',title: 'Rate Us', rightBox: '',color: colorTheme),
        clsSetting(icon: 'nativeAds',title: 'Buy', rightBox: '',color: colorTheme),
      ];
    }
    else {
      clsSettings = [
        clsSetting(icon: 'language',title: 'Language', rightBox: language,color: colorTheme),
        clsSetting(icon: 'theme',title: 'Theme:', rightBox: 'yes',color: colorTheme),
        clsSetting(icon: 'locker',title: 'Privacy Policy', rightBox: '',color: colorTheme),
        clsSetting(icon: 'exclamation',title: 'Terms & Condition', rightBox: '',color: colorTheme),
        //clsSetting(icon: 'star',title: 'Rate Us', rightBox: '',color: colorTheme),
        clsSetting(icon: 'nativeAds',title: 'Buy', rightBox: '',color: colorTheme),
      ];}

    void reloadThemeColorSelected(String value) async{
      Navigator.pop(context);
      clsSettings = [
        clsSetting(icon: 'theme',title: 'Theme:', rightBox: 'yes',color: colorTheme),
        clsSetting(icon: 'locker',title: 'Privacy Policy', rightBox: '',color: colorTheme),
        clsSetting(icon: 'exclamation',title: 'Terms & Condition', rightBox: '',color: colorTheme),
        //clsSetting(icon: 'star',title: 'Rate Us', rightBox: '',color: colorTheme),
      ];
      selectedColor(value);
    }
    void reloadLanguageSelected(String value) async {
      Navigator.pop(context);
      clsSettings = [
        clsSetting(icon: 'theme',title: 'Theme:', rightBox: 'yes',color: colorTheme),
        clsSetting(icon: 'locker',title: 'Privacy Policy', rightBox: '',color: colorTheme),
        clsSetting(icon: 'exclamation',title: 'Terms & Condition', rightBox: '',color: colorTheme),
        //clsSetting(icon: 'star',title: 'Rate Us', rightBox: '',color: colorTheme),
      ];
      selectedLanguage(value);
    }

    List<clsThemeColor> cls_themeColor = [
      clsThemeColor(title: options[0], groupValue: colorTheme),
      clsThemeColor(title: options[1], groupValue: colorTheme),
      clsThemeColor(title: options[2], groupValue: colorTheme),
      clsThemeColor(title: options[3], groupValue: colorTheme),
      clsThemeColor(title: options[4], groupValue: colorTheme),
      clsThemeColor(title: options[5], groupValue: colorTheme),
      clsThemeColor(title: options[6], groupValue: colorTheme),
      clsThemeColor(title: options[7], groupValue: colorTheme),
    ];
    List<clsThemeColor> cls_language = [
      clsThemeColor(title: 'Cebuano', groupValue: language),
      clsThemeColor(title: 'English', groupValue: language),
    ];

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: clsSettings.map((e) =>
              SettingsCardTemplate(
                  cls_setting: e,
                  openClick: () async{
                      print(e.title);
                      if(e.title=='Theme:'){
                        //load bottom sheet dialog
                        showModalBottomSheet(context: context, builder: (context){
                          return SafeArea(
                            child: SingleChildScrollView(
                              child: Column(
                                  children: cls_themeColor.map((ef) =>
                                      ColorThemeSwitcher(cls_themeColor: ef, changeClick: reloadThemeColorSelected)).toList()
                              ),
                            ),
                          );
                        });
                      }
                      else if(e.title=='Language'){
                        showModalBottomSheet(context: context, builder: (context){
                          return SafeArea(
                            child: SingleChildScrollView(
                              child: Column(
                                  children: cls_language.map((ef) =>
                                      LanguageSwitcher(cls_language: ef, changeClick: reloadLanguageSelected)).toList()
                              ),
                            ),
                          );
                        });
                      }
                      else if(e.title=='Privacy Policy'){
                        _launchUrl('https://lpz.zithvirtualsolutions.com/suynl/privacy-policy');
                      }
                      else if(e.title=='Terms & Condition'){
                        _launchUrl('https://lpz.zithvirtualsolutions.com/suynl/terms-and-conditions');
                      }
                  },
                buyAction: buyAction,
                restoreAction: restoreAction,
              )).toList(),
        ),
      ),
    );
  }

  void onPaymentResult(Map<String, dynamic> result) {

  }
}
