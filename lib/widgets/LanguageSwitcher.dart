
import 'package:flutter/material.dart';
import 'package:suynl/classes/clsThemeColor.dart';

class LanguageSwitcher extends StatelessWidget {

  final clsThemeColor cls_language;
  final Function(String) changeClick;
  const LanguageSwitcher({super.key,required this.cls_language,required this.changeClick});

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      title: Row(
        children: [
          Expanded(
              child: Text(cls_language.title)),

        ],
      ),
      value: cls_language.title,
      groupValue: cls_language.groupValue,
      onChanged: (value){
        changeClick(value!);
      },
      selected: cls_language.groupValue == cls_language.title ? true:false,
    );
  }
}
