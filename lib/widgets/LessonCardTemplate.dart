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
    double width = MediaQuery.of(context).size.width;
    var isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return InkWell(
      onTap: openLesson,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(isDarkMode?0.1:0.4)
            )
          )
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),

          title: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0)),
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
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(lesson.title, overflow: TextOverflow.ellipsis,maxLines: 1,   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: myThemes.getColor(lesson.color)),),
                        Row(children:[
                          Expanded(child: Text(lesson.subTitle,overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(fontSize: width * 0.025,fontStyle: FontStyle.italic), ))])
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
      ),
    );


    return Text('');

  }
}
