import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class myThemes{

  static Future<String> loadThemeColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = await prefs.getString('colorThemes') ?? 'Blue';
    return data;
  }

  static Color getColor(String colorType){
    Color cColor = Colors.red;
    switch(colorType){
      case 'Black':
        cColor = Colors.black;
        break;
      case 'Green':
        cColor = Colors.green;
        break;
      case 'Blue':
        cColor = Colors.blue;
        break;
      case 'Orange':
        cColor = Colors.orange;
        break;
      case 'Pink':
        cColor = Colors.pink;
        break;
      case 'Red':
        cColor = Colors.red;
        break;
      case 'Purple':
        cColor = Colors.purple;
        break;
      case 'Teal':
        cColor = Colors.teal;
        break;
    }
    return cColor;
  }

  static Color? getLightColor(String colorType){
    Color? cColor = Colors.red[300];
    switch(colorType){
      case 'Black':
        cColor = Colors.grey[800];
        break;
      case 'Green':
        cColor = Colors.green[300];
        break;
      case 'Blue':
        cColor = Colors.blue[300];
        break;
      case 'Orange':
        cColor = Colors.orange[300];
        break;
      case 'Pink':
        cColor = Colors.pink[300];
        break;
      case 'Red':
        cColor = Colors.red[300];
        break;
      case 'Purple':
        cColor = Colors.purple[300];
        break;
      case 'Teal':
        cColor = Colors.teal[300];
        break;
    }
    return cColor;
  }

}