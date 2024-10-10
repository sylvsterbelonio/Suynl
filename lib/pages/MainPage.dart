
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suynl/classes/sql/sqlHelper.dart';
import 'package:suynl/controller/SOL2Controller.dart';
import 'package:suynl/pages/SettingsStateless.dart';
import 'package:suynl/pages/booklet.dart';
import 'package:suynl/defaults/defaults.dart';
import 'package:suynl/pages/Settings.dart';
import 'package:suynl/classes/Themes.dart';
import 'package:suynl/classes/clsApp.dart';
import 'package:suynl/widgets/ads/BannerAds.dart';
import 'package:url_launcher/url_launcher.dart';
var indexClicked = 0;
var appBarTitle = 'Booklet';
GlobalKey gk= GlobalKey();
class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}
class _MainPageState extends State<MainPage>{
  late bool isOnline=false;
  late bool has_tagalog = false;
  late bool has_cebuano = false;
  final SOL2Controller _sol1Controller = Get.put(SOL2Controller());
  late List<Widget> pages = [
    Booklet(),
    SettingsStateless(colorTheme: colorTheme, selectedLanguage: loadSelectedLanguage, selectedColor: loadThemeData,appMode: appMode,language: _sol1Controller.language.value,has_tagalog: has_tagalog,has_cebuano: has_cebuano,has_network: isOnline,),
    const Center(child: Text('exit'),
    )];
  late String appMode='trial';
  late Widget bannerAds = BannerAds();
  String language = 'English';

  @override
  void initState(){
    initTheme();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initTheme() async{
    setState(() async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      colorTheme = prefs.getString('colorThemes') ?? clsApp.defaultThemeColor;
      appMode = prefs.getString('appMode') ?? clsApp.DEFAULT_APP_MODE;
      language = prefs.getString('defaultLanguage') ?? clsApp.defaultLanguage;
      _sol1Controller.language.value = language;

      has_tagalog = await sqlHelper.checkMaterialBookIfExist(20);
      has_cebuano = await sqlHelper.checkMaterialBookIfExist(4);
      isOnline = await hasNetwork();
      pages = [
        Booklet(),
        SettingsStateless(colorTheme: colorTheme, selectedLanguage: loadSelectedLanguage, selectedColor: loadThemeData,appMode: appMode,language: _sol1Controller.language.value,has_tagalog: has_tagalog,has_cebuano: has_cebuano,has_network: isOnline,),
        const Center(child: Text('exit'),
        )
      ];

    });
  }

  void loadThemeData(String selectedColor) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('colorThemes', selectedColor);
    language = prefs.getString('defaultLanguage') ?? clsApp.defaultLanguage;
    colorTheme = selectedColor;
    isOnline = await hasNetwork();
    has_tagalog = await sqlHelper.checkMaterialBookIfExist(20);
    has_cebuano = await sqlHelper.checkMaterialBookIfExist(4);

    pages = [
     Booklet(),
     SettingsStateless(colorTheme: colorTheme, selectedLanguage: loadSelectedLanguage, selectedColor: loadThemeData,appMode: appMode,language: language,has_tagalog: has_tagalog,has_cebuano: has_cebuano,has_network: isOnline,),
     const Center(child: Text('exit'),
      )
    ];

    setState(() {
      //colorTheme = prefs.getString('colorThemes') ?? 'Red';
    });
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void loadSelectedLanguage(String selectedLanguage) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('defaultLanguage', selectedLanguage);
    appMode = prefs.getString('appMode') ?? clsApp.DEFAULT_APP_MODE;
    language = prefs.getString('defaultLanguage') ?? clsApp.defaultLanguage;
    language = selectedLanguage;
    has_tagalog = await sqlHelper.checkMaterialBookIfExist(20);
    has_cebuano = await sqlHelper.checkMaterialBookIfExist(4);
    isOnline = await hasNetwork();

    pages = [
      Booklet(),
      SettingsStateless(colorTheme: colorTheme, selectedLanguage: loadSelectedLanguage, selectedColor: loadThemeData,appMode: appMode,language: _sol1Controller.language.value,has_tagalog: has_tagalog,has_cebuano: has_cebuano,has_network: isOnline,),
      const Center(child: Text('exit'),
      )
    ];


    setState(() {
      //colorTheme = prefs.getString('colorThemes') ?? 'Red';
    });
  }

  @override
  Widget build(BuildContext context) {

    VoidCallback clickDrawer(int index){
      return () {
        setState((){
          indexClicked=index;
          Navigator.pop(context);
          if(index==0)
            appBarTitle = 'Booklet';
          else
            appBarTitle = 'Settings';
        });
      };
    }

    Future<bool> _onBackPressed() async{
      return (await showDialog(
          context: context,
          builder: (context)=> AlertDialog(
            title: const Text('Do you really want to exit the app?',style: TextStyle(fontSize: 16.0),),
            actions: <Widget>[
              TextButton(
                  onPressed: ()=>Navigator.pop(context,false),
                  child:  Text('No',style: TextStyle(color: myThemes.getColor(colorTheme)),)),
              TextButton(
                  onPressed: ()=>SystemNavigator.pop(),
                  child:  Text('Yes',style: TextStyle(color: myThemes.getColor(colorTheme)),)),
            ],
          )
      )
      );
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          backgroundColor: myThemes.getColor(colorTheme),
        ),
        body: pages[indexClicked],
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(clsApp.override_app_resources?'Mahalaga I':'SUYNL v1.0.2',style: (TextStyle(fontWeight: FontWeight.bold)),),
                accountEmail: Text(clsApp.override_app_resources?'Jesus Christ Basic Foundation':'Starting Up Your New Life',style: TextStyle(fontSize: 12),),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset(clsApp.override_app_resources?'assets/images/raw_icon_alt.png':'assets/images/raw_icon.png'),
                  ),
                ),
                decoration: BoxDecoration(
                    color: myThemes.getColor(colorTheme),
                    image: DecorationImage(
                        image: AssetImage(''),
                        fit: BoxFit.cover)
                ),
              ),
              ListTile(
                  leading: Icon(
                      Defaults.drawerItemIcon[0],
                      color: indexClicked ==0 ? myThemes.getColor(colorTheme) : Defaults.drawerItemColor),
                  title: Text(
                    Defaults.drawerItemText[0],
                    style: TextStyle(color: indexClicked ==0 ? myThemes.getColor(colorTheme) : Defaults.drawerItemColor),),
                  onTap: clickDrawer(0)
              ),
              ListTile(
                  leading: Icon(
                      Defaults.drawerItemIcon[1],
                      color: indexClicked ==1 ? myThemes.getColor(colorTheme) : Defaults.drawerItemColor),
                  title: Text(
                    Defaults.drawerItemText[1],
                    style: TextStyle(color: indexClicked ==1 ? myThemes.getColor(colorTheme) : Defaults.drawerItemColor),),
                  onTap: clickDrawer(1)
              ),
              ListTile(
                leading: Icon(
                    Defaults.drawerItemIcon[2],
                    color: indexClicked ==2 ? myThemes.getColor(colorTheme) : Defaults.drawerItemColor),
                title: Text(
                  Defaults.drawerItemText[2],
                  style: TextStyle(color: indexClicked ==2 ? myThemes.getColor(colorTheme) : Defaults.drawerItemColor),),
                onTap: (){
                  setState(() {
                    Navigator.pop(context);

                    if (Platform.isAndroid || Platform.isIOS) {
                      final appId = Platform.isAndroid ? 'YOUR_ANDROID_PACKAGE_ID' : 'YOUR_IOS_APP_ID';
                      final url = Uri.parse(
                        Platform.isAndroid
                        //? "https://play.google.com/store/search?q=pub%3ALPZ%20Developer&c=apps"
                            ? "https://play.google.com/store/search?q=pub%3AChrist%20Mindset&c=apps"
                            : "https://apps.apple.com/app/id$appId",
                      );
                      launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }

                  });
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(
                    Defaults.drawerItemIcon[3],
                    color: indexClicked ==3 ? myThemes.getColor(colorTheme) : Defaults.drawerItemColor),
                title: Text(
                  Defaults.drawerItemText[3],
                  style: TextStyle(color: indexClicked ==3 ? myThemes.getColor(colorTheme) : Defaults.drawerItemColor),),
                onTap: (){
                  setState(() {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context)=> AlertDialog(
                          title: const Text('Do you really want to exit the app?',style: TextStyle(fontSize: 16.0),),
                          actions: <Widget>[
                            TextButton(
                                onPressed: ()=>Navigator.pop(context,false),
                                child:  Text('No',style: TextStyle(color: myThemes.getColor(colorTheme)),)),
                            TextButton(
                                onPressed: ()=> SystemNavigator.pop(),
                                child:  Text('Yes',style: TextStyle(color: myThemes.getColor(colorTheme)),)),
                          ],
                        )
                    );
                  });
                },
              )
            ],
          ),
        ),
      ),
    );

  }
}