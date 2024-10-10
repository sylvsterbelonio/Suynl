
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:suynl/classes/sql/sqlHelper.dart';
import 'package:suynl/pages/FontSettings.dart';
import 'package:suynl/pages/SplashScreen.dart';
import 'package:suynl/pages/MainPage.dart';
import 'package:suynl/pages/LessonDetails.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  sqlHelper.initDefaultDB;

  runApp(
      GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/home': (context) => const MainPage(),
            '/lesson_details': (context) => const LessonDetails(),
            '/font_settings': (context) => const FontSettings(),
          }
      ));
}






