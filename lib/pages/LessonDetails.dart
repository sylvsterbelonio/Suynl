import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:suynl/classes/clsSetting.dart';
import 'package:suynl/classes/clsThemeColor.dart';
import 'package:suynl/classes/sql/sqlHelper.dart';
import 'package:suynl/controller/GeneralController.dart';
import 'package:suynl/controller/SOL2Controller.dart';
import 'package:suynl/widgets/LanguageSwitcher.dart';
import 'package:suynl/widgets/ads/BannerAds.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:suynl/classes/clsApp.dart';
import 'package:suynl/models/LessonModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suynl/classes/Themes.dart';

class LessonDetails extends StatefulWidget {
  const LessonDetails({super.key});

  @override
  State<LessonDetails> createState() => _LessonDetailsState();
}

class _LessonDetailsState extends State<LessonDetails> with SingleTickerProviderStateMixin{

  final SOL2Controller _sol1Controller = Get.put(SOL2Controller());
  final GeneralController _generalController = Get.put(GeneralController());
  late TabController _controller = TabController(length: 2, vsync: this);
  late String colorTheme = clsApp.defaultThemeColor;
  StreamSubscription? _internetConnectionStreamSubscription;
  late String appTitle = 'Lesson 1';
  late String language = clsApp.defaultLanguage;
  late int lesson_id = 0;
  late String lesson_type = '';
  late bool has_tagalog = false;
  late bool has_cebuano = false;
  late List<clsThemeColor> cls_language = [];
  List<clsSetting> clsSettings = [];
  late bool has_network = false;

  @override
  void initState() {
    reloadTheme();
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _controller.addListener(() {
      setState(() {
      });
    });
  }
  void internet_config(){
    _internetConnectionStreamSubscription = InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          setState(() {
            has_network = true;
            _generalController.isConnectedToInternet.value = true;
            // Get.snackbar(
            //     'Online',
            //     'You are now connected!',
            //     snackPosition: SnackPosition.BOTTOM,
            //     backgroundColor: Colors.black,
            //     colorText: Colors.white
            // );
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            has_network=false;
            // Get.snackbar(
            //     'Offline',
            //     'You are disconnected from the internet.',
            //     snackPosition: SnackPosition.BOTTOM,
            //     backgroundColor: Colors.black,
            //     colorText: Colors.white
            // );
          });
          break;
        default:
          setState(() {
            has_network=false;
          });
          break;
      }
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
  void reloadTheme() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _generalController.onInit();
    colorTheme = prefs.getString('colorThemes') ?? clsApp.defaultThemeColor;
    language = prefs.getString('defaultLanguage') ?? clsApp.defaultLanguage;
    has_tagalog = await sqlHelper.checkMaterialBookIfExist(20);
    has_cebuano = await sqlHelper.checkMaterialBookIfExist(4);

    has_network = _generalController.isConnectedToInternet.value;
    cls_language = [
      clsThemeColor(title: 'English', groupValue: language,remark: 'yes',has_internet: has_network),
      clsThemeColor(title: 'Tagalog', groupValue: language,remark: has_tagalog?'yes':'no',has_internet: has_network),
      clsThemeColor(title: 'Cebuano', groupValue: language,remark: has_cebuano?'yes':'no',has_internet: has_network),
    ];
    clsSettings = [
      clsSetting(icon: 'language',title: 'Language', rightBox: language,color: colorTheme),
    ];
    internet_config();
    //print('select lang->'+language);
    setState(() {});
  }

  @override
  void dispose() {
    if(_internetConnectionStreamSubscription!=null) _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }


  void getLessonQuestion(String lessonNo,String language, String lesson_type){
      if(lessonNo.length==1) lessonNo = '0' + lessonNo;
      int lesson_no = int.parse(lessonNo);
      _sol1Controller.sel_lesson_no.value = lesson_no;
      _sol1Controller.sel_lesson_id.value = _sol1Controller.selected_lesson.value.id.toInt();
  }
  void reloadLanguageSelected(String value) async{
    Navigator.pop(context);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('defaultLanguage', value);


    language = value;
    _sol1Controller.language.value = value;
    has_tagalog = await sqlHelper.checkMaterialBookIfExist(20);
    has_cebuano = await sqlHelper.checkMaterialBookIfExist(4);
    has_network = _generalController.isConnectedToInternet.value;
    cls_language = [
      clsThemeColor(title: 'English', groupValue: language,remark: 'yes',has_internet: has_network),
      clsThemeColor(title: 'Tagalog', groupValue: language,remark: has_tagalog?'yes':'no',has_internet: has_network),
      clsThemeColor(title: 'Cebuano', groupValue: language,remark: has_cebuano?'yes':'no',has_internet: has_network),
    ];
    //print('select lang->'+language);
    setState(() {});
  }

  Widget getBody(LessonModel data, int lesson_no){

    late final WebViewController _controller_page;
    late String sampleHtml = '''
                            ''' +  data.content + '''                                                                   
                            ''';

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
      ..loadHtmlString(sampleHtml);

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller_page = controller;

    return Padding(
      padding: EdgeInsets.all(0),
      child: Column(
          children: [

            Expanded(
              child: RawScrollbar(child: WebViewWidget(controller: _controller_page)),
            ),
            BannerAds(),
          ]),
    );



  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String,String>;
    final String lessonNo = routeArgs['lessonNo'].toString();
    lesson_type =  routeArgs['lesson_type'].toString();
    final title = routeArgs['title'].toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson_type + " " + lessonNo + ': ' + title),
        actions: [
          IconButton(onPressed: () async{
            await showModalBottomSheet(context: context, builder: (context){
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children:[
                      Container(
                        width:double.infinity,
                        decoration: BoxDecoration(
                          border:Border(
                            bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.4)
                            )
                          )

                        ),
                        child: Padding(
                            padding:EdgeInsets.all(20),
                            child: Text('Select Language:')),
                      ),
                      Column(
                        children: cls_language.map((ef) =>
                            LanguageSwitcher(cls_themeColor: ef, changeClick: reloadLanguageSelected)).toList()
                    )],
                  ),
                ),
              );
            });

          }, icon: Icon(Icons.translate))
         ],
        backgroundColor: isDarkMode? null:  myThemes.getColor(colorTheme),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<LessonModel>(
            future: sqlHelper().get_material_lessons_by_id(lessonNo,language,lesson_type),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                _sol1Controller.selected_lesson.value = snapshot.data;
                return getBody(snapshot.data!,int.parse(lessonNo));
              }
              else
                return const Center(child: CircularProgressIndicator());
            },
            ),
          )
        ]),

    );
  }
}
