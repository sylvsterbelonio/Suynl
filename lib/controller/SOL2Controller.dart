import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:suynl/classes/sql/sqlHelper.dart';
import 'package:suynl/models/LessonModel.dart';

import '../constants/constants.dart';

class SOL2Controller extends GetxController {
  Rx<List<LessonModel>> life_class = Rx<List<LessonModel>>([]);
  Rx<LessonModel> selected_lesson = Rx<LessonModel>(new LessonModel(id: 0, materialBookId: 0, lessonType: '', lessonNo: 0, lesson: '', content: '', questionnaire: [], createdByUserId: 0, organizationId: 0, createdAt: DateTime.now(), updatedAt: DateTime.now()));
  final lesson_type = ''.obs;
  final sel_lesson_id = 0.obs;
  final sel_lesson_no = 0.obs;
  final isLoading = false.obs;
  final progress_bar = 0.obs;
  final language = 'English'.obs;
  final box = GetStorage();

  Future get_life_class_lessons({ignoreLoading = false, material_book_id='0', String language = 'English'}) async {
    try {
      //if(!ignoreLoading) isLoading.value = true;

      var token = "123456asaalwkdjalkdlawjdlakwdjalwdkj8dwi334WWADSlksdasdlkjad";


      var response = await http.get(
          Uri.parse(url + '/material/life-class/lessons?material_book_id=${material_book_id}&token=${token}'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${box.read('token')}',
          });

      //print(json.decode(response.body));

      if (response.statusCode == 200) {
        //if(!ignoreLoading) isLoading.value = false;

        // ministry_list.value.clear();
        // Ministry emptyMinistry = new Ministry(id: 0, photo: '', ministryName: '', address: '');
        // ministry_list.value.add(emptyMinistry);
        life_class.value.clear();
        progress_bar.value = 0;
        for (var item in json.decode(response.body)['data']) {
          progress_bar.value += 1;
          LessonModel rawData = LessonModel.fromJson(item);
          await sqlHelper.addMaterialLesson(LessonModel.fromJson(item));
            //ADD QUESTIONNAIRES
            for(int i=0;i<rawData.questionnaire.length;i++){
              await sqlHelper.addMaterialLessonQuestionnaire(rawData.questionnaire[i],rawData.id, language);
              //ADD ANSWERS
              for(int y=0;y<rawData.questionnaire[i].data.answers.length;y++){
                  await sqlHelper.addMaterialLessonQuestionnaireData(
                      rawData.questionnaire[i].data.answers[y],
                      rawData.questionnaire[i].id,
                      language
                  );
              }
            }
          life_class.value.add(rawData);
        }

        return true;

      } else {
       // if(!ignoreLoading) isLoading.value = false;

        // Get.snackbar(
        //     'No Internet',
        //     '',
        //     snackPosition: SnackPosition.BOTTOM,
        //     backgroundColor: Colors.red,
        //     colorText: Colors.white
        // );
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      if(e.toString().contains('OS Error: No address associated with hostname')){
        //EasyLoading.showError('No Internet Connection. Please check your network data.');
      }
      //EasyLoading.dismiss();
      Get.snackbar(
          'No Internet',
          'You need an internet connection to download the language.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white
      );

      return false;
    }
  }


}