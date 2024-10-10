
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:suynl/classes/clsThemeColor.dart';
import 'package:suynl/component/ui/dialog/DialogHelper.dart';
import 'package:suynl/controller/SOL2Controller.dart';
import 'package:suynl/widgets/ads/InterstitialAds.dart';
import 'package:suynl/widgets/ads/RewardedAds.dart';

class LanguageSwitcher extends StatelessWidget {

  final clsThemeColor cls_themeColor;
  final Function(String) changeClick;
  const LanguageSwitcher({super.key,required this.cls_themeColor,required this.changeClick});


  void download_files(BuildContext context,SOL2Controller _sol2Controller,String value) async{
    if(cls_themeColor.has_internet){

      late int material_book_id = 0;
      _sol2Controller.progress_bar.value = 0;
      if(cls_themeColor.title=='Tagalog')
        material_book_id=20;
      else if(cls_themeColor.title=="Cebuano")
        material_book_id=4;

     // Navigator.pop(context,false);
      Navigator.pop(context,false);

      DialogHelper.loading(context: context,life_class_controller: _sol2Controller);
      bool result = await _sol2Controller.get_life_class_lessons(material_book_id: material_book_id, language: cls_themeColor.title);
      DialogHelper.hide(context: context);

      if(result){
        changeClick(value);
      }

    }else{
      Get.snackbar(
          'Error',
          'Failed to load essential resources. Please connect to the internet.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
      Navigator.pop(context,false);
    }
  }
  bool response_reward(){
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final SOL2Controller _sol2Controller = Get.put(SOL2Controller());

    return RadioListTile<String>(
      title: Row(
        children: [
          Expanded(
              child: Text(cls_themeColor.title)),

        ],
      ),
      value: cls_themeColor.title,
      groupValue: cls_themeColor.groupValue,
      onChanged: (value) async{
        if(cls_themeColor.remark=='no'){
          //Navigator.pop(context,false);
          await showDialog(
              context: context,
              builder: (context)=> AlertDialog(
                title: const Text('Do you want to download this language?',style: TextStyle(fontSize: 16.0),),
                actions: <Widget>[
                  TextButton(
                      onPressed: ()=>Navigator.pop(context,false),
                      child:  Text('No')),
                  TextButton(
                      onPressed: () async{

                        // Navigator.pop(context,false);
                        // RewardedAds.loadAd(
                        //     context: context,
                        //     sol2Controller: _sol2Controller,
                        //     value: value.toString(), response: download_files);

                        if(cls_themeColor.has_internet){



                          late int material_book_id = 0;
                          _sol2Controller.progress_bar.value = 0;
                          if(cls_themeColor.title=='Tagalog')
                            material_book_id=20;
                          else if(cls_themeColor.title=="Cebuano")
                            material_book_id=4;

                          Navigator.pop(context,false);
                          Navigator.pop(context,false);

                          DialogHelper.loading(context: context,life_class_controller: _sol2Controller);
                          bool result = await _sol2Controller.get_life_class_lessons(material_book_id: material_book_id, language: cls_themeColor.title);
                          DialogHelper.hide(context: context);


                          if(result){
                            InterstitialAds.load();
                            changeClick(value!);
                          }




                        }else{
                          Get.snackbar(
                              'Error',
                              'Failed to load essential resources. Please connect to the internet.',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red,
                              colorText: Colors.white
                          );
                          Navigator.pop(context,false);
                        }
                      },
                      child:  Text('Yes')),
                ],
              )
          );
        }else{
          changeClick(value!);
        }
      },
      selected: cls_themeColor.groupValue == cls_themeColor.title ? true:false,
    );
  }
}
