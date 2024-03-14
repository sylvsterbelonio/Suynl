import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suynl/classes/clsSetting.dart';
import 'package:suynl/widgets/ColorThemeSwitcher.dart';
import 'package:suynl/widgets/SettingsCardTemplate.dart';
import 'package:suynl/classes/clsThemeColor.dart';
import 'package:suynl/classes/clsApp.dart';

class Settings extends StatefulWidget {
  final Function refreshMainPage;
  const Settings({super.key,required this.refreshMainPage});

  @override
  State<Settings> createState() => _SettingsState();
}

List<String> options = ['Black', 'Green', 'Blue', 'Orange', 'Pink', 'Red', 'Purple', 'Teal'];
late String colorTheme='Red';
late String appMode='trial';

class _SettingsState extends State<Settings> {

  List<clsSetting> clsSettings = [
    clsSetting(icon: 'theme',title: 'Theme:', rightBox: 'yes',color: colorTheme),
    clsSetting(icon: 'locker',title: 'Privacy Policy', rightBox: '',color: colorTheme),
    clsSetting(icon: 'exclamation',title: 'Terms & Condition', rightBox: '',color: colorTheme),
    clsSetting(icon: 'star',title: 'Rate Us', rightBox: '',color: colorTheme),
  ];


  void loadSharedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      colorTheme = prefs.getString('colorThemes') ?? 'Red';
      appMode = prefs.getString('appMode') ?? clsApp.DEFAULT_APP_MODE;
    });
  }

  @override
  void initState() {
    loadSharedData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    void reloadThemeColorSelected(String value) async{
      colorTheme = value;
      Navigator.pop(context);
      clsSettings = [
        clsSetting(icon: 'theme',title: 'Theme:', rightBox: 'yes',color: colorTheme),
        clsSetting(icon: 'locker',title: 'Privacy Policy', rightBox: '',color: colorTheme),
        clsSetting(icon: 'exclamation',title: 'Terms & Condition', rightBox: '',color: colorTheme),
        clsSetting(icon: 'star',title: 'Rate Us', rightBox: '',color: colorTheme),
      ];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('colorThemes', colorTheme);
      setState(() {
      });

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

    /*
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: clsSettings.map((e) =>
              SettingsCardTemplate(
              cls_setting: e,
              openClick: (){
                setState(() {
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
                });
              }
          )).toList(),
        ),
      ),
    );
     */
    return SizedBox();
  }
}

