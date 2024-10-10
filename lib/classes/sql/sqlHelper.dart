
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';
import 'package:suynl/classes/clsApp.dart';
import 'package:suynl/classes/sql/clsSqlLesson.dart';
import 'package:sqflite/sqflite.dart';
import 'package:suynl/models/LessonModel.dart';

class sqlHelper{

  static String getCurrentTimeStamp(){
    DateTime _now = DateTime.now();
    return '${_now.year}-${_now.month}-${_now.day} ${_now.hour}:${_now.minute}:${_now.second}';
  }
  static Future<void> createLessonTables(sql.Database database) async{
    await database.execute("""CREATE TABLE sol_lesson(
    lessonID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    lessonNo INTEGER,
    bookType TEXT,
    answer_1 TEXT,
    answer_2 TEXT,
    answer_3 TEXT,
    answer_4 TEXT,
    answer_5 TEXT,
    answer_6 TEXT,
    answer_7 TEXT,
    answer_8 TEXT,
    answer_9 TEXT,
    answer_10 TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP)
         """);
  }
  static Future<void> createDailyVerseTables(sql.Database database) async{
    await database.execute("""CREATE TABLE sol_daily_verse(
    dailyVerseId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    lessonID INTEGER,
    weekNo INTEGER,
    dayNo INTEGER,
    check_1 INTEGER NOT NULL DEFAULT 0,
    check_2 INTEGER NOT NULL DEFAULT 0,
    check_3 INTEGER NOT NULL DEFAULT 0,
    check_4 INTEGER NOT NULL DEFAULT 0,
    check_5 INTEGER NOT NULL DEFAULT 0,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP)
         """);
  }

  static Future<Database> get initDefaultDB async {
    final dbPath = await sql.getDatabasesPath();
    final path = join(dbPath,clsApp.defaultDB);
    final exist = await sql.databaseExists(path);
      if(exist)
          {
           // print('db already existed');
          }
      else{
          //  print('creating a copy from assets');
            try{
              await Directory(dirname(path)).create(recursive: true);
            }catch(err){
         //     print('there was error on creating db: $err');
            }
            ByteData data = await rootBundle.load(join("assets",clsApp.defaultDB));
            List<int> bytes = data.buffer.asInt8List(data.offsetInBytes,data.lengthInBytes);
            await File(path).writeAsBytes(bytes,flush: true);
         //   print('db copied!');
          }
    return await sql.openDatabase(path);
  }

  //INSERT TABLE

  static Future<int> addMaterialLesson(LessonModel lessonData) async{
    final db = await initDefaultDB;
    final data = {
      'id' : lessonData.id,
      'material_book_id' : lessonData.materialBookId,
      'lesson_type' : lessonData.lessonType,
      'lesson_no' : lessonData.lessonNo,
      'lesson' : lessonData.lesson,
      'content' : lessonData.content,
      'file_path' : '',
      'file_dark_path':'',
      'questionnaire':'',
      'createdBy_user_id':lessonData.createdByUserId,
      'organization_id':lessonData.organizationId,
      'created_at':DateTime.now().toString(),
      'updated_at':DateTime.now().toString()
    };
    final id = await db.insert('material_lessons', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  static Future<void> deleteAllMaterialLesson() async{
    final db = await initDefaultDB;
    try{
      await db.delete('material_lessons');
    }catch(err){
      //  print("Something went wrong when deleting an item: $err");
    }
  }

  static Future<int> addMaterialLessonQuestionnaire(Questionnaire _data, int material_lesson_id, String language) async{
    final db = await initDefaultDB;
    final data = {
      'id' : _data.id,
      'lesson_id' : material_lesson_id,
      'type' : _data.type,
      'no' : _data.no,
      'value' : _data.value,
      'alignment' : _data.alignment,
      'font_style' : _data.fontStyle,
      'font_weight':_data.fontWeight,
      'column':_data.column,
      'label':_data.label,
      'label_2':_data.label_2,
      'direction':_data.direction,
      'indent_style':_data.indent_style,
      'language': language
    };
    final id = await db.insert('material_lessons_questionnaire', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  static Future<void> deleteAllMaterialLessonQuestionnaire() async{
    final db = await initDefaultDB;
    try{
      await db.delete('material_lessons_questionnaire');
    }catch(err){
      //  print("Something went wrong when deleting an item: $err");
    }
  }
  static Future<int> addMaterialLessonQuestionnaireData(Answer _data, String questionnaire_id, String language) async{
    final db = await initDefaultDB;
    final data = {
      'uuid' : _data.uuid,
      'questionnaire_id' : questionnaire_id,
      'no' : _data.no,
      'label' : _data.label,
      'label_2' : _data.label2,
      'object_type' : _data.objectType,
      'object_type_2' : _data.objectType2,
      'answer':_data.answer,
      'answer_2':_data.answer2,
      'answer_type':_data.answerType,
      'answer_type_2':_data.answerType2,
      'column_size':_data.columnSize,
      'column_direction':_data.columnDirection,
      'list_item':_data.listItem,
      'img_source':_data.imgSource,
      'language':language
    };

    final id = await db.insert('material_lessons_questionnaire_data', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  static Future<void> deleteAllMaterialLessonQuestionnaireData() async{
    final db = await initDefaultDB;
    try{
      await db.delete('material_lessons_questionnaire_data');
    }catch(err){
      //  print("Something went wrong when deleting an item: $err");
    }
  }

  static Future<bool> checkMaterialBookIfExist(int material_book_id) async{
    final db = await initDefaultDB;
    final mapValues = await db.rawQuery('''SELECT * from material_lessons where material_book_id=?''',[material_book_id]);
    if(mapValues.isEmpty)
      return false;
    else
      return true;
  }

  Future<List<LessonModel>> getAllMaterialLessons(int material_book_id, String lesson_type) async {
    List<LessonModel> lessons = [];
    final db = await initDefaultDB;
    final mapValues = await db.rawQuery('''SELECT * from material_lessons  where material_book_id=? and lesson_type=? order by lesson_no''', [material_book_id,lesson_type]);
    for(var lessonMap in mapValues){
      LessonModel rows = LessonModel.fromMap(lessonMap);
      lessons.add(rows);
    }
    return lessons;
  }
  Future<LessonModel> get_material_lessons_by_id(String lesson_no,String language, String lesson_type) async{
    final db = await initDefaultDB;
    late int material_book_id = 2;
    if(language=='Cebuano')
      material_book_id = 4;
    else if(language=='Tagalog')
      material_book_id = 20;

    print('sladkamsldkjas' + lesson_no + '|' + language + "|" + material_book_id.toString() + '|' + lesson_type);
    List<Map<String,dynamic>> mapValues = await db.rawQuery('''SELECT * from material_lessons where lesson_no=? and material_book_id=? and lesson_type=?''',[lesson_no,material_book_id,lesson_type]);
    for(var lessonMap in mapValues){

      LessonModel rows = LessonModel.fromMap(lessonMap);
      //print('nia - ' + rows.toString());
      return rows;
    }
    return LessonModel(id: 0, materialBookId: 0, lessonType: '', lessonNo: 0, lesson: '', content: '', questionnaire: [], createdByUserId: 0, organizationId: 0, createdAt: DateTime.now(), updatedAt: DateTime.now());
  }
  Future <List<Questionnaire>> get_material_lessons_questions_by_id(String lesson_id, String language) async{
    final db = await initDefaultDB;

    List<Questionnaire> data = [];

    List<Map<String,dynamic>> mapValues = await db.rawQuery('''SELECT * from material_lessons_questionnaire where lesson_id=? and language=?''',[lesson_id,language]);
    for(var lessonMap in mapValues){
      Questionnaire rows = Questionnaire.fromMap(lessonMap);
      //print('nia ra questionnaires- ' + rows.toString());
      data.add(rows);
    }
    return data;
  }
  Future <List<Answer>> get_material_lessons_questions_data_answer_by_id(String questionnaire_id, String language) async{
    final db = await initDefaultDB;
    List<Answer> data = [];
    //print('ready' + questionnaire_id);
    List<Map<String,dynamic>> mapValues = await db.rawQuery('''SELECT * from material_lessons_questionnaire_data where questionnaire_id=? and language=?''',[questionnaire_id,language]);
    for(var lessonMap in mapValues){
      Answer rows = Answer.fromMap(lessonMap);
      data.add(rows);
    }
    return data;
  }


  static Future<int> addLesson(clsSqlLesson lessonData) async{
    final db = await initDefaultDB;
    final data = {
      'lessonNo' : lessonData.lessonNo,
      'bookType' : lessonData.bookType,
      'answer_1' : lessonData.answer_1,
      'answer_2' : lessonData.answer_2,
      'answer_3' : lessonData.answer_3,
      'answer_4' : lessonData.answer_4,
      'answer_5' : lessonData.answer_5,
      'answer_6' : lessonData.answer_6,
      'answer_7' : lessonData.answer_7,
      'answer_8' : lessonData.answer_8,
      'answer_9' : lessonData.answer_9,
      'answer_10' : lessonData.answer_10,
      'updatedAt': DateTime.now().toString()
    };
    final id = await db.insert('sol_lesson', data,
    conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> updateCheckReadStatus(int dailyVerseID, String status, double totalEarnedPoints, String createdDt) async{
    final db = await initDefaultDB;
    late Map<String, dynamic> row;
    // row to update
    if(createdDt.trim()!=''){
      row = {
        'status' : status,
        'completion_rate' : totalEarnedPoints.toStringAsFixed(0),
        'updateDt': DateTime.now().toString()
      };
    }else{
      row = {
        'status' : status,
        'completion_rate' : totalEarnedPoints.toStringAsFixed(0),
        'updateDt': DateTime.now().toString(),
        'createdDt': DateTime.now().toString()
      };
    }

    return await db.update('tbl_daily_verse', row, where: "dailyVerseID = ?", whereArgs: [dailyVerseID]);
  }
  static Future<int> updateDevotionalStatus(int dailyVerseID,String rhema,String commands,String warnings,String promises,String application, double totalEarnedPoints, String createdDt) async{
    final db = await initDefaultDB;
    late Map<String, dynamic> row;
    // row to update
    if(createdDt.trim()!=''){
      row = {
        'devo_rhema': rhema,
        'devo_commands' : commands,
        'devo_warnings' : warnings,
        'devo_promises' : promises,
        'devo_application' : application,
        'completion_rate' : totalEarnedPoints.toStringAsFixed(0),
        'updateDt': DateTime.now().toString()
      };
    }else{
      row = {
        'devo_rhema': rhema,
        'devo_commands' : commands,
        'devo_warnings' : warnings,
        'devo_promises' : promises,
        'devo_application' : application,
        'completion_rate' : totalEarnedPoints.toStringAsFixed(0),
        'createdDt' : DateTime.now().toString(),
        'updateDt': DateTime.now().toString()
      };
    }

    return await db.update('tbl_daily_verse', row, where: "dailyVerseID = ?", whereArgs: [dailyVerseID]);
  }


  static Future<int> updateLesson(int LessonNo, String answer_1,String answer_2,String answer_3,String answer_4,String answer_5,String answer_6,String answer_7,String answer_8,String answer_9,String answer_10, int maxAnswers, int completionRate,String createdDt, String bookType) async{
    final db = await initDefaultDB;
    late Map<String, dynamic> row;
    // row to update
    //print('meeeee!!!' + bookType);
    int no_jumper = 0;
    if(bookType=='family') no_jumper = 10;

    if(createdDt.trim()!=''){
      row = {
        'answer_1': answer_1,
        'answer_2': answer_2,
        'answer_3': answer_3,
        'answer_4': answer_4,
        'answer_5': answer_5,
        'answer_6': answer_6,
        'answer_7': answer_7,
        'answer_8': answer_8,
        'answer_9': answer_9,
        'answer_10': answer_10,
        'completionRate' : completionRate.toString(),
        'updatedAt': DateTime.now().toString()
      };
    }else{
      row = {
        'answer_1': answer_1,
        'answer_2': answer_2,
        'answer_3': answer_3,
        'answer_4': answer_4,
        'answer_5': answer_5,
        'answer_6': answer_6,
        'answer_7': answer_7,
        'answer_8': answer_8,
        'answer_9': answer_9,
        'answer_10': answer_10,
        'completionRate' : completionRate.toString(),
        'updatedAt': DateTime.now().toString(),
        'createdAt': DateTime.now().toString()
      };
    }
    int lessonID = LessonNo + no_jumper;
    //print('yuuu!!!' + lessonID.toString());

    return await db.update('tbl_my_lesson', row, where: "lessonID=?", whereArgs: [lessonID]);

  }


  static Future<int> updateDeclaration(
      int ansActID,
      String answer_1,
      String answer_2,
      String answer_3,
      String answer_4,
      String completionRate)  async{
    final db = await initDefaultDB;
    late Map<String, dynamic> row;
    // row to update
      row = {
        'ansActID': ansActID,
        'answer_1' : answer_1,
        'answer_2' : answer_2,
        'answer_3' : answer_3,
        'answer_4' : answer_4,
        'completionRate' : completionRate,
        'dtAnswered': DateTime.now().toString(),
        'action': 'Changed'
      };
    return await db.update('tbl_answer_activity', row, where: "ansActID = ?", whereArgs: [ansActID]);
  }
  static Future<int> updateProfileOfTheEnemy(
      int ansActID,
      String answer_1,
      String answer_2,
      String answer_3,
      String answer_4,
      String answer_5,
      String answer_6,
      String answer_7,
      String answer_8,
      String answer_9,
      String answer_10,
      String answer_11,
      String completionRate)  async{
    final db = await initDefaultDB;
    late Map<String, dynamic> row;
    // row to update
    row = {
      'ansActID': ansActID,
      'answer_1' : answer_1,
      'answer_2' : answer_2,
      'answer_3' : answer_3,
      'answer_4' : answer_4,
      'answer_5' : answer_5,
      'answer_6' : answer_6,
      'answer_7' : answer_7,
      'answer_8' : answer_8,
      'answer_9' : answer_9,
      'answer_10' : answer_10,
      'answer_11' : answer_11,
      'completionRate' : completionRate,
      'dtAnswered': DateTime.now().toString(),
      'action': 'Changed'
    };
    return await db.update('tbl_answer_activity', row, where: "ansActID = ?", whereArgs: [ansActID]);
  }


  static Future<int> importLessons(int lessonID,Map<String, dynamic> row) async{
    final db = await initDefaultDB;
    return await db.update('tbl_my_lesson', row, where: "lessonID = ?", whereArgs: [lessonID]);
  }
  static Future<int> importDailyVerse(int dailyVerseID,Map<String, dynamic> row) async{
    final db = await initDefaultDB;
    return await db.update('tbl_daily_verse', row, where: "dailyVerseID = ?", whereArgs: [dailyVerseID]);
  }


  static Future<int> resetLesson() async{
    final db = await initDefaultDB;
    Map<String, dynamic> row = {
      'answer_1' : '',
      'answer_2'  : '',
      'answer_3' : '',
      'answer_4'  : '',
      'answer_5' : '',
      'answer_6'  : '',
      'answer_7' : '',
      'answer_8'  : '',
      'answer_9' : '',
      'answer_10'  : '',
      'createdAt' : '',
      'updatedAt': '',
      'completionRate': 0
    };
    return await db.update('tbl_my_lesson', row);
  }
  static Future<int> resetDailyVerse() async{
    final db = await initDefaultDB;
    Map<String, dynamic> row = {
      'status' : 'n,n,n,n,n',
      'devo_rhema'  : '',
      'devo_commands' : '',
      'devo_warnings'  : '',
      'devo_promises' : '',
      'devo_application'  : '',
      'completion_rate' : 0,
      'createdDt'  : '',
      'updateDt' : ''
    };
    return await db.update('tbl_daily_verse', row);
  }

  //https://www.youtube.com/watch?v=9kbt4SBKhm0
  //SOURCE CODE FROM THAT VIDEO TO LEARN MORE...//


  static getLessonByID(int id, String bookType) async{
    final db = await initDefaultDB;
    int jumper = 0;
    if(bookType=='family') jumper=10;
    int lessonID = id + jumper;
    final result = await db.rawQuery('''SELECT * from tbl_my_lesson where lessonID=?''',[lessonID]);
    return clsSqlLesson.fromJson(result.first);
  }



  Future<List<clsSqlLesson>> getAllLessonsOnlySelectedID(String whereStringArguments,  List<int> whereValue) async{
    List<clsSqlLesson> lesson = [];
    final db = await initDefaultDB;
    List<Map<String,dynamic>> mapValues = await db.rawQuery('''SELECT * from tbl_my_lesson where $whereStringArguments''',whereValue);
    for(var lessonMap in mapValues){
      clsSqlLesson rows = clsSqlLesson.fromMap(lessonMap);
      lesson.add(rows);
    }
    return lesson;
  }


  static getAllLesson() async {
    final db = await initDefaultDB;
    final result = await db.rawQuery('''SELECT * from tbl_my_lesson''');
    //return result.map((e) => modelDailyVerse.fromJson(e).toString());
  }


  //DELETE RECORD
  static Future<void> deleteLesson(int id) async{
    final db = await initDefaultDB;
    try{
      await db.delete('sol_lesson', where: "lessonID=?", whereArgs: [id]);
    }catch(err){
    //  print("Something went wrong when deleting an item: $err");
    }
  }
  //GET ALL RECORDS
  static Future<List<Map<String, dynamic>>> getAllLessons() async {
    final db = await initDefaultDB;
    return db.query('sol_lesson',orderBy: "lessonNo");
  }




}