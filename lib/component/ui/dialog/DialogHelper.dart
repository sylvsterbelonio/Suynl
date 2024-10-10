import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:suynl/classes/Themes.dart';
import 'package:suynl/controller/SOL2Controller.dart';
import '../../../widgets/GlassBox.dart';

class DialogHelper{

  static Future<void> onClickData(BuildContext context,Function YesResponse,dynamic data )async {
    Navigator.pop(context,false);
    YesResponse(data);
  }
  static Future<void> onClick(BuildContext context,Function YesResponse )async {
    Navigator.pop(context,false);
    YesResponse();
  }
  static void onNoClick(BuildContext context)async {
    Navigator.pop(context,false);
  }

  static Future<void> confirmGlassDialogYesNo({required BuildContext context, String title = 'The system said.', String message = 'Are you sure about this?', required Function YesResponse, required Function NoResponse, String colorTheme = 'Blue', bool isDarkMode = false, required double width}) async {
    if(Platform.isIOS){
      CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
              child: Text('Yes'),
              onPressed: (){onClick(context,YesResponse);}),
          CupertinoDialogAction(
              child: Text('No'),
              onPressed: (){Navigator.pop(context,false);})
        ],
      );
    }else{
      showDialog(
          barrierDismissible: false,
          barrierColor:isDarkMode?Colors.black.withOpacity(0.5): Colors.white.withOpacity(0.8),
          context: context,
          builder: (context)=>
              Dialog(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  child: GlassBox(
                    borderSide: isDarkMode?Colors.grey.withOpacity(0.1):Colors.grey.withOpacity(0.4),
                    leftGradient: isDarkMode?Colors.black.withOpacity(0.7):Colors.white.withOpacity(0.7),
                    rightGradient: isDarkMode?Colors.black.withOpacity(0.4):Colors.white.withOpacity(0.2),
                    sigmaY: 5,
                    sigmaX: 5,
                    height: 160,
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(child: Center(child: Text( message, style: TextStyle(fontSize: width * 0.04,  color: isDarkMode?Colors.white.withOpacity(0.8):Colors.black)))),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation:5,
                                      backgroundColor: myThemes.getColor(colorTheme),
                                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    ),
                                    onPressed: (){onClick(context,YesResponse);}, child: Text('Yes'),),
                                  SizedBox(width: 10,),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation:5,
                                      backgroundColor: myThemes.getColor(colorTheme),
                                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    ),
                                    onPressed: (){Navigator.pop(context,false);}, child: Text('No'),)
                                ],
                              )
                            ]
                        ),
                      ),
                    ),
                  )
              )
      );
    }


  }


  static Future<void> confirmGlassDialog({required BuildContext context, String title = 'The system said.', String message = 'Are you sure about this?', required Function YesResponse, String colorTheme = 'Blue', bool isDarkMode = false, required double width}) async {
    if(Platform.isIOS){
      CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
              child: Text('Yes'),
              onPressed: (){onClick(context,YesResponse);}),
          CupertinoDialogAction(
              child: Text('No'),
              onPressed: (){Navigator.pop(context,false);})
        ],
      );
    }else{
    showDialog(
        barrierColor:isDarkMode?Colors.black.withOpacity(0.5): Colors.white.withOpacity(0.8),
        context: context,
        builder: (context)=>
            Dialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                child: GlassBox(
                  borderSide: isDarkMode?Colors.grey.withOpacity(0.1):Colors.grey.withOpacity(0.4),
                  leftGradient: isDarkMode?Colors.black.withOpacity(0.7):Colors.white.withOpacity(0.7),
                  rightGradient: isDarkMode?Colors.black.withOpacity(0.4):Colors.white.withOpacity(0.2),
                  sigmaY: 5,
                  sigmaX: 5,
                  height: 160,
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(child: Center(child: Text( message, style: TextStyle(fontSize: width * 0.04,  color: isDarkMode?Colors.white.withOpacity(0.8):Colors.black)))),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation:5,
                                    backgroundColor: myThemes.getColor(colorTheme),
                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  ),
                                  onPressed: (){onClick(context,YesResponse);}, child: Text('Yes'),),
                                SizedBox(width: 10,),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation:5,
                                    backgroundColor: myThemes.getColor(colorTheme),
                                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                  ),
                                  onPressed: (){Navigator.pop(context,false);}, child: Text('No'),)
                              ],
                            )
                          ]
                      ),
                    ),
                  ),
                )
            )
    );
    }


  }

  static Future<void> confirmGlassDataDialog({required BuildContext context, String title = '', String message = 'Are you sure about this?', required Function YesResponse, String colorTheme = 'Blue', bool isDarkMode = false, required double width, required dynamic data,double height = 160}) async {
    if(Platform.isIOS){
      CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
              child: Text('Yes'),
              onPressed: (){onClickData(context,YesResponse,data);}),
          CupertinoDialogAction(
              child: Text('No'),
              onPressed: (){Navigator.pop(context,false);})
        ],
      );
    }else{
      showDialog(
          barrierColor:isDarkMode?Colors.black.withOpacity(0.5): Colors.white.withOpacity(0.8),
          context: context,
          builder: (context)=>
              Dialog(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  surfaceTintColor: Colors.transparent,
                  child: GlassBox(
                    borderSide: isDarkMode?Colors.grey.withOpacity(0.1):Colors.grey.withOpacity(0.3),
                    leftGradient: isDarkMode?Colors.black.withOpacity(0.7):Colors.white.withOpacity(0.4),
                    rightGradient: isDarkMode?Colors.black.withOpacity(0.4):Colors.white.withOpacity(0.2),
                    sigmaY: 5,
                    sigmaX: 5,
                    height: height,
                    width: double.infinity,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(title),
                              Expanded(child: Center(child: Text( message, style: TextStyle(fontSize: width * 0.04,  color: isDarkMode?Colors.white.withOpacity(0.8):Colors.black)))),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation:5,
                                      backgroundColor: myThemes.getColor(colorTheme),
                                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    ),
                                    onPressed: (){onClickData(context,YesResponse,data);}, child: Text('Yes'),),
                                  SizedBox(width: 10,),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation:5,
                                      backgroundColor: myThemes.getColor(colorTheme),
                                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    ),
                                    onPressed: (){Navigator.pop(context,false);}, child: Text('No'),)
                                ],
                              )
                            ]
                        ),
                      ),
                    ),
                  )
              )
      );
    }

  }

  static Future<void> confirmDialog({required BuildContext context, String title = 'The system said.', String message = 'Are you sure about this?', required Function YesResponse, String colorTheme = 'Blue', bool isDarkMode = false, required double width}) async {
    showDialog(
        context: context,
        builder: (context)=>
            AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                content: Text(message),
                title: Text(title),
                actions: <Widget>[
                  TextButton(
                      style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)))),
                      onPressed: ()=>{onClick(context, YesResponse)},
                      child:  Text('Yes',style: TextStyle(color: myThemes.getColor(colorTheme)),)),
                  TextButton(
                      style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)))),
                      onPressed: ()=>Navigator.pop(context,false),
                      child:  Text('No',style: TextStyle(color: myThemes.getColor(colorTheme)),)),
                ])
    );
  }


  static Future<void> loading({required BuildContext context, String colorTheme='White', required SOL2Controller life_class_controller})async {
    NumberFormat formatter = NumberFormat.decimalPatternDigits(
      locale: 'en_us',
      decimalDigits: 2,
    );

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
        return Center(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
          CircularProgressIndicator(color: Colors.white),
          SizedBox(height: 20),
          Obx(() {
            return Text('Downloading resources...\n${ formatter.format((life_class_controller.progress_bar.value/11) * 100)} %',textAlign: TextAlign.center,style: TextStyle(color: Colors.white));
          })
        ]));
        });
  }
  static Future<void> loading_validate({required BuildContext context, String colorTheme='White'})async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
                  content: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Text('Validating....'),
                  ],
          ),
          ));
        });
  }

  static Future<void> hide({required BuildContext context}) async {
    Navigator.pop(context);
  }


  }
