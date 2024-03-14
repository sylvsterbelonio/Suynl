import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suynl/pages/MainPage.dart';
import 'package:suynl/pages/Settings.dart';
import 'package:suynl/classes/Themes.dart';
import 'package:suynl/classes/clsApp.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  void loadThemeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      colorTheme = prefs.getString('colorThemes') ?? clsApp.defaultThemeColor;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadThemeData();
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 3),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MainPage()));
    }
    );

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
              SizedBox(
                width: 54.0,
                height: 54.0,
                child: ClipOval(
                  child: Image.asset('assets/images/raw_icon.png'),
                ),
              ),
              const Center(
                child: Text('Starting Up Your New Life',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color:Colors.white,fontStyle: FontStyle.normal),),
              ),
            ]

          )),
    );
  }
}
