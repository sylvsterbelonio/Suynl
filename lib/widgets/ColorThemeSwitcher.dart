import 'package:flutter/material.dart';
import 'package:suynl/classes/Themes.dart';
import 'package:suynl/classes/clsThemeColor.dart';

class ColorThemeSwitcher extends StatelessWidget {
  final clsThemeColor cls_themeColor;
  final Function(String) changeClick;
  const ColorThemeSwitcher({super.key,required this.cls_themeColor,required this.changeClick});

  @override
  Widget build(BuildContext context) {

      return RadioListTile<String>(
        title: Row(
          children: [
            Expanded(
                flex: 9,
                child: Text(cls_themeColor.title)),
            Expanded(
                flex: 1,
                child: Container(
                  height: 20,
                  width: 10,
                  color: myThemes.getColor(cls_themeColor.title),
                ))
          ],
        ),
        value: cls_themeColor.title,
        groupValue: cls_themeColor.groupValue,
        onChanged: (value){
          changeClick(value!);
        },
        selected: cls_themeColor.groupValue == cls_themeColor.title ? true:false,
      );

  }
}
