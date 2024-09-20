
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:suynl/classes/Themes.dart';
import 'package:suynl/classes/clsApp.dart';

import '../widgets/ads/BannerAds.dart';
import 'Settings.dart';
class LessonDetails extends StatefulWidget {
  const LessonDetails({super.key});

  @override
  State<LessonDetails> createState() => _LessonDetailsState();
}

class _LessonDetailsState extends State<LessonDetails> {

  int _currentFontSize = 1;
  bool _fontDecrease = true;
  bool _fontIncrease = true;
  String language = 'English';

  @override
  void initState() {
    reloadTheme();
    super.initState();
  }

  void reloadTheme() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentFontSize = prefs.getInt('fontSize') ?? 1;
    if(_currentFontSize==0) _fontDecrease=false;
    else if(_currentFontSize==2) _fontIncrease=false;
    colorTheme = prefs.getString('colorThemes') ?? clsApp.defaultThemeColor;
    language = prefs.getString('defaultLanguage') ?? clsApp.defaultLanguage;
    setState(() {});
  }
  void updateFontSize() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('fontSize', _currentFontSize);
  }


  List<String> availableFontSize = ['_sm','','_lg'];
  String getLessonFile(String lessonNo){

    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    String fileName='';

      switch(lessonNo) {
        case '0':
          fileName = !isDarkMode ? "sl_00_introduction"+availableFontSize[_currentFontSize]+".html" : "sl_00_dark_introduction"+availableFontSize[_currentFontSize]+".html";
          //fileName = "ex_00_pasiuna_alt.html";
          break;
        case '1':
          fileName = !isDarkMode ? "sl_01_salvation"+availableFontSize[_currentFontSize]+".html" : "sl_01_dark_salvation"+availableFontSize[_currentFontSize]+".html";
          //fileName = "ex_01_patukuranan_alt.html";
          break;
        case '2':
          fileName = !isDarkMode ? "sl_02_repentance"+availableFontSize[_currentFontSize]+".html" : "sl_02_dark_repentance"+availableFontSize[_currentFontSize]+".html";
          //fileName = "ex_02_kinabuhi_human_sa_kamatayon_alt.html";
          break;
        case '3':
          fileName = !isDarkMode ? "sl_03_lordship"+availableFontSize[_currentFontSize]+".html" : "sl_03_dark_lordship"+availableFontSize[_currentFontSize]+".html";
          //fileName = "ex_03_kaluwasan_alt.html";
          break;
        case '4':
          fileName = !isDarkMode ? "sl_04_forgiveness"+availableFontSize[_currentFontSize]+".html" : "sl_04_dark_forgiveness"+availableFontSize[_currentFontSize]+".html";
          //fileName = "ex_04_usa_lang_ka_dalan_alt.html";
          break;
        case '5':
          fileName = !isDarkMode ? "sl_05_the_4_greatest_meetings"+availableFontSize[_currentFontSize]+".html" : "sl_05_dark_the_4_greatest_meetings"+availableFontSize[_currentFontSize]+".html";
          //fileName = "ex_05_pagkatawo_pagusab_alt.html";
          break;
        case '6':
          fileName = !isDarkMode ? "sl_06_devotional_life"+availableFontSize[_currentFontSize]+".html" : "sl_dark_06_devotional_life"+availableFontSize[_currentFontSize]+".html";
          //fileName = "ex_06_tulo_ka_aspeto_sa_kaluwasan_alt.html";
          break;
        case '7':
          fileName = !isDarkMode ? "sl_07_your_active_life_prayer"+availableFontSize[_currentFontSize]+".html" : "sl_07_dark_your_active_life_prayer"+availableFontSize[_currentFontSize]+".html";
          //fileName = "ex_07_mga_pangutana_mahitungod_sa_kaluwasan_alt.html";
          break;
        case '8':
          fileName = !isDarkMode ? "sl_08_sharing_your_new_life_with_others"+availableFontSize[_currentFontSize]+".html" : "sl_08_dark_sharing_your_new_life_with_others"+availableFontSize[_currentFontSize]+".html";
          //fileName = "ex_08_kaluwasan_mawala_ba_o_dili_na_alt.html";
          break;
        case '9':
          fileName = !isDarkMode ? "sl_09_life_of_obedience"+availableFontSize[_currentFontSize]+".html" : "sl_09_dark_life_of_obedience"+availableFontSize[_currentFontSize]+".html";
          //fileName = "ex_09_ang_plano_sa_dios_alt.html";
          break;
        case '10':
          fileName =  !isDarkMode ? "sl_10_life_in_the_church"+availableFontSize[_currentFontSize]+".html" : "sl_10_dark_life_in_the_church"+availableFontSize[_currentFontSize]+".html";
          //fileName = "ex_10_paglakaw_uban_sa_dios_alt.html";
          break;
        case '11':
          fileName =  !isDarkMode ? "ex_11_pito_ka_timailhan"+availableFontSize[_currentFontSize]+".html" : "ex_11_dark_pito_ka_timailhan"+availableFontSize[_currentFontSize]+".html";
          //fileName = "ex_11_pito_ka_timailhan_alt.html";
          break;
        case '12':
          fileName =  !isDarkMode ? "ex_12_pagkaginoo"+availableFontSize[_currentFontSize]+".html" : "ex_12_dark_pagkaginoo"+availableFontSize[_currentFontSize]+".html";
          //fileName = "ex_12_pagkaginoo_alt.html";
          break;
      }
      print(language + "/" + fileName);
      return language + "/" + fileName;

  }



  late final WebViewController controller;

  @override
  Widget build(BuildContext context) {


    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String,String>;
    final String lessonNo = routeArgs['lessonNo'].toString();
    final String title = routeArgs['title'].toString();
    late final WebViewController _controller;
    String fileName='';

    fileName = getLessonFile(lessonNo);

      late final PlatformWebViewControllerCreationParams params;
      if (WebViewPlatform.instance is WebKitWebViewPlatform) {
        params = WebKitWebViewControllerCreationParams(
          allowsInlineMediaPlayback: true,
          mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
        );
      } else {
        params = const PlatformWebViewControllerCreationParams();
      }
    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

      controller
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..enableZoom(true)
        ..runJavaScript('<script>setFontSize('+ availableFontSize[_currentFontSize] +');</script>')
        ..loadFlutterAsset('assets/files/'+fileName);

      // #docregion platform_features
      if (controller.platform is AndroidWebViewController) {
        AndroidWebViewController.enableDebugging(true);
        (controller.platform as AndroidWebViewController)
            .setMediaPlaybackRequiresUserGesture(false);
      }

      // #enddocregion platform_features
      _controller = controller;



    return Scaffold(
      appBar: AppBar(
      title:  Text(lessonNo + ': ' + title),
      actions: [
        IconButton(onPressed: _fontDecrease ?  (){
        setState(() {
            int index = _currentFontSize - 1;
              if (index <= 0) {
                _currentFontSize = 0;
                _fontDecrease = false;
              } else {
                _fontIncrease=true;
                _currentFontSize--;
              }
            print(_currentFontSize);
            updateFontSize();
            });
            }: null,
            icon: Icon(Icons.text_decrease,
            color:  _fontDecrease ? Colors.white: Colors.grey[400])),

        IconButton(onPressed: _fontIncrease ? (){
          setState(() {
            int index = _currentFontSize + 1;
            if(index>1){
              _currentFontSize = 2;
              _fontIncrease = false;
            }else {
              _currentFontSize++;
              _fontDecrease=true;
            }
            });
          print(_currentFontSize);
          updateFontSize();
        }: null,
            icon: Icon(Icons.text_increase,
            color: _fontIncrease ? Colors.white: Colors.grey[400])),
      ],
      backgroundColor: myThemes.getColor(colorTheme),
      ),
      body:  Column(children: [
        Expanded(child: WebViewWidget(controller: _controller,)),
        // BannerAds()
      ]),
    );
  }
}
