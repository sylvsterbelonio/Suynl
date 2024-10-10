import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suynl/classes/lesson.dart';
import 'package:suynl/classes/sql/sqlHelper.dart';
import 'package:suynl/controller/GeneralController.dart';
import 'package:suynl/controller/SOL2Controller.dart';
import 'package:suynl/models/GeneralModel.dart';
import 'package:suynl/models/LessonModel.dart';
import 'package:suynl/pages/Settings.dart';
import 'package:suynl/classes/clsApp.dart';
import 'package:suynl/widgets/LessonCardTemplate.dart';
import 'package:suynl/widgets/ads/RewardedInterstitialAds.dart';
import '../widgets/ads/BannerAds.dart';
import '../widgets/ads/InterstitialAds.dart';

class Booklet extends StatefulWidget {
  const Booklet({super.key});
  @override
  State<Booklet> createState() => _BookletState();
}

class _BookletState extends State<Booklet>{
  GeneralController _generalController = Get.put(GeneralController());
  final SOL2Controller _sol2Controller = Get.put(SOL2Controller());
  late GeneralModel _generalModel;
  String language = 'English';
  bool bannerAdsLoaded = false;
  Widget bannerAds = BannerAds();
  int adClickCount = 0;
  late int material_id = 2;

  List<Lesson> lesson = [];
  String appMode = 'trial';

  void loadThemeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    colorTheme = prefs.getString('colorThemes') ?? clsApp.defaultThemeColor;
    appMode = prefs.getString('appMode') ??  clsApp.DEFAULT_APP_MODE;
    adClickCount = prefs.getInt('adClickCount') ??  0;
    language = prefs.getString('defaultLanguage') ?? clsApp.defaultLanguage;

    material_id = 2;
    if(language=='Tagalog') material_id=20;
    else if(language=='Cebuano') material_id=4;

    print('langtoday' + language);

    List<LessonModel> lessons_ = await sqlHelper().getAllMaterialLessons(material_id, '');

    lesson.clear();
    for(int i=0;i<lessons_.length;i++){
      print(lessons_[i].lesson);
      lesson.add(
        Lesson(lessonNo: lessons_[i].lessonNo.toString(),title: lessons_[i].lesson,subTitle: 'Lesson Topic',color: colorTheme,language: language),
      );
    }
    setState(() {});
  }

  void updateAdClickCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('adClickCount', adClickCount);
  }
  void openLesson(Lesson e){

    adClickCount++;
    if(adClickCount>clsApp.defaultAppOpenCounter){
      adClickCount=0;
      InterstitialAds.load();
    }
    //print('sample->>' + e.lessonNo);
    _sol2Controller.lesson_type.value = '';

    updateAdClickCount();
    Navigator.pushNamed(
        context, '/lesson_details',arguments: {
      'lessonNo' : e.lessonNo,
      'lesson_type' : '',
      'title': e.title
    }).then((value) {
      loadThemeData();
      setState(() {});
    });

  }
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    loadThemeData();
  }

  @override
  Widget build(BuildContext context) {
    _generalModel = _generalController.init_app(context: context,colorTheme: _generalController.colorTheme.value);

    var height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child:
        FutureBuilder(
              future: sqlHelper().getAllMaterialLessons(material_id, ''),
              builder: (BuildContext context, AsyncSnapshot<List<LessonModel>> snapshot){
                    if(snapshot.data?.length==0){
                      return Container(
                        height: _generalModel.isPortrait?_generalModel.height * 0.9:_generalModel.height * 0.75,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.search_off_outlined, size: _generalModel.width * 0.2,),
                                Center(child: Text('No Data Found', style: TextStyle(fontWeight: FontWeight.bold, fontSize: _generalModel.width * 0.04),)),
                                Center(child: Text('You need an internet connection to download material books.', style: TextStyle(fontStyle: FontStyle.italic,fontSize: _generalModel.width * 0.03),))
                              ]
                          ),
                        ),
                      );
                    }else if(snapshot.hasData){
                            return Column(
                              children:[
                                Column(
                                  children: lesson.map((e) => LessonCardTemplate(
                                      lesson: e,
                                      appMode: appMode,
                                      openLesson: (){openLesson(e);}
                                  )).toList(),
                                ),
                              ],
                            );
                    }else{
                        return Padding(
                            padding: EdgeInsets.symmetric(vertical: 100),
                            child: Center(child: CircularProgressIndicator()));
                    }
                }
              ),

                ),
              ),
              BannerAds()
            ])
    );

  }
}