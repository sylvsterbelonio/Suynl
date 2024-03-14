import 'package:flutter/material.dart';
import 'package:suynl/classes/lesson.dart';
import 'package:suynl/classes/Themes.dart';


class LessonCardTemplate extends StatelessWidget {

  final Lesson lesson;
  final VoidCallback openLesson;
  final String appMode;
  const LessonCardTemplate({super.key, required this.lesson, required this.openLesson,required this.appMode});


  @override
  Widget build(BuildContext context) {

    if(appMode=='trial'){
      if(lesson.lessonNo=='1' || lesson.lessonNo=='2' || lesson.lessonNo=='3' || lesson.lessonNo=='4' || lesson.lessonNo=='5') {
        return Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
          child: InkWell(
            onTap:
            openLesson
            ,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0)),
                      color: myThemes.getLightColor(lesson.color),
                    ),
                    child: Center(
                        child:
                        SizedBox(
                          width: 24.0,
                          child: Center(
                            child: Text(lesson.lessonNo,
                              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0, color: Colors.white),),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(child: Text(lesson.title,overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: myThemes.getColor(lesson.color)),)),

                        ],
                      ),
                    ),
                  ),
                  const Icon(
                      Icons.keyboard_arrow_right_outlined
                  ),
                ],
              ),
            ),
          ),
        );
      }else{
        return Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)
          ),
          child: InkWell(
            onTap:
            openLesson
            ,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0)),
                      color: myThemes.getLightColor(lesson.color),
                    ),
                    child: Center(
                        child:
                        SizedBox(
                          width: 24.0,
                          child: Center(
                            child: Text(lesson.lessonNo,
                              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0, color: Colors.white),),
                          ),
                        )),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(lesson.title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: myThemes.getColor(lesson.color)),),
                          Text(lesson.subTitle)
                        ],
                      ),
                    ),
                  ),
                  Center(child: Text('Lock',style: TextStyle(color: Colors.grey,fontStyle: FontStyle.italic),)),
                  const Icon(
                      Icons.keyboard_arrow_right_outlined
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }else{
      return Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
        ),
        child: InkWell(
          onTap:
          openLesson
          ,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0)),
                    color: myThemes.getLightColor(lesson.color),
                  ),
                  child: Center(
                      child:
                      SizedBox(
                        width: 24.0,
                        child: Center(
                          child: Text(lesson.lessonNo,
                            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0, color: Colors.white),),
                        ),
                      )),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(lesson.title,overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: myThemes.getColor(lesson.color)),),
                        Text(lesson.subTitle,overflow: TextOverflow.ellipsis,style: TextStyle(fontStyle: FontStyle.italic),)
                      ],
                    ),
                  ),
                ),
                const Icon(
                    Icons.keyboard_arrow_right_outlined
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Text('');

  }
}
