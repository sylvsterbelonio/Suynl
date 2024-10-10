import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:suynl/classes/Themes.dart';
import 'package:suynl/classes/clsApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suynl/models/GeneralModel.dart';

class GeneralController extends GetxController {
  final isConnectedToInternet = false.obs;
  final colorTheme = 'Blue'.obs;
  final noInternetRepeat = false.obs;
  final hasInternetRepeat = false.obs;


  @override
  void onInit() async{
    noInternetRepeat.value = false;
    hasInternetRepeat.value = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    colorTheme.value = prefs.getString('colorThemes') ?? clsApp.defaultThemeColor;
    bool isOnline =  await InternetConnection().hasInternetAccess;
    if(isOnline)
      isConnectedToInternet.value=true;
    else
      isConnectedToInternet.value=false;
    super.onInit();
  }

  GeneralModel init_app({required BuildContext context, String colorTheme = 'Blue'}) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: isDarkMode?Colors.grey.withOpacity(0.0):myThemes.getColor(colorTheme), statusBarIconBrightness: Brightness.light, statusBarBrightness: Brightness.light));
    return new GeneralModel(
        width: width,
        height: height,
        font_size_xxs: width * 0.025,
        font_size_xs: width * 0.030,
        font_size_sm: width * 0.035,
        font_size_m: width * 0.040,
        font_size_l: width * 0.045,
        font_size_xl: width * 0.050,
        font_size_xxl: width * 0.055,
        isPortrait: isPortrait,
        isDarkMode: isDarkMode);
  }

}