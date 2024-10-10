import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suynl/classes/sql/sqlHelper.dart';
import 'package:suynl/controller/GeneralController.dart';
import 'package:suynl/controller/SOL2Controller.dart';
import 'package:suynl/pages/MainPage.dart';
import 'package:suynl/pages/Settings.dart';
import 'package:suynl/classes/Themes.dart';
import 'package:suynl/classes/clsApp.dart';
import 'package:suynl/widgets/ads/AppOpenAds.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  final SOL2Controller _sol2Controller = Get.put(SOL2Controller());
  final GeneralController _generalController = Get.put(GeneralController());
  late bool hasInternet = true;
  late bool loading = false;

  void loadThemeData() async {
    _generalController.onInit();
    hasInternet = await _generalController.isConnectedToInternet.value;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      colorTheme = prefs.getString('colorThemes') ?? clsApp.defaultThemeColor;
    });
  }

  void first_load_resources() async{
    print('naka load na');
    bool checker = await sqlHelper.checkMaterialBookIfExist(2);

    if(!checker){
      //if(hasInternet){
      await sqlHelper.deleteAllMaterialLesson();
      await sqlHelper.deleteAllMaterialLessonQuestionnaire();
      await sqlHelper.deleteAllMaterialLessonQuestionnaireData();

      //await _lifeClassController.get_life_class_lessons(material_book_id: 8);
      _sol2Controller.isLoading.value= true;
      await _sol2Controller.get_life_class_lessons(material_book_id: 2);
      _sol2Controller.isLoading.value= false;

      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => MainPage()));
      }
      );


      // }

    }else{
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => MainPage()));
      }
      );
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    AppOpenAds.loadAd();
    loadThemeData();
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    first_load_resources();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: [SystemUiOverlay.top,SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [myThemes.getColor(colorTheme), Colors.white],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Expanded(
                flex: 8,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      SizedBox(
                        width: 100.0,
                        height: 100.0,
                        child: ClipOval(
                          child: Image.asset(clsApp.override_app_resources?'assets/images/raw_icon_alt.png':'assets/images/raw_icon.png'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('SUYNL',style: TextStyle(letterSpacing: 2,fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('Starting Up Your New Life',
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal,color:Colors.black,fontStyle: FontStyle.normal),),
                    ]
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(children: [
                  Obx((){
                    NumberFormat formatter = NumberFormat.decimalPatternDigits(
                      locale: 'en_us',
                      decimalDigits: 2,
                    );
                    return _sol2Controller.isLoading.value?
                    Column(
                      children: [
                        Text('Loading Essential Resources...\n${ formatter.format((_sol2Controller.progress_bar.value/11) * 100)} %',textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontStyle: FontStyle.italic)),
                        SizedBox(height: 5),
                        Padding(
                            padding:EdgeInsets.symmetric(horizontal: 10),
                            child: LinearProgressIndicator(color: Colors.red,backgroundColor: Colors.grey,)),
                        SizedBox(height: 10,),
                      ],
                    ):Container();
                  }),
                  Text('All rights reserved \u00a9 2024',style: TextStyle(fontSize: 13),),
                  Text('Christ Mindset',style: TextStyle(fontWeight: FontWeight.bold),),
                ],),
              ),

            ]

          )),
    );
  }
}
