// To parse this JSON data, do
//
//     final lessonModel = lessonModelFromJson(jsonString);

import 'dart:convert';

LessonModel lessonModelFromJson(String str) => LessonModel.fromJson(json.decode(str));

String lessonModelToJson(LessonModel data) => json.encode(data.toJson());

class LessonModel {
  late int id;
  late int materialBookId;
  late String lessonType;
  late int lessonNo;
  late String lesson;
  late String content;
  late List<Questionnaire> questionnaire;
  late int createdByUserId;
  late int organizationId;
  late DateTime createdAt;
  late DateTime updatedAt;

  LessonModel({
    required this.id,
    required this.materialBookId,
    required this.lessonType,
    required this.lessonNo,
    required this.lesson,
    required this.content,
    required this.questionnaire,
    required this.createdByUserId,
    required this.organizationId,
    required this.createdAt,
    required this.updatedAt,
  });



  factory LessonModel.fromJson(Map<String, dynamic> json) => LessonModel(
    id: json["id"]!=null ? json["id"]: 0,
    materialBookId: json["material_book_id"]!=null ? json["material_book_id"]: 0,
    lessonType: json["lesson_type"]!=null ? json["lesson_type"]: '',
    lessonNo: json["lesson_no"]!=null ? json["lesson_no"]: 0,
    lesson: json["lesson"]!=null ? json["lesson"]: '',
    content: json["content"]!=null ? json["content"]: '',
    createdByUserId: json["createdBy_user_id"]!=null ? json["createdBy_user_id"]: '',
    organizationId: json["organization_id"]!=null ? json["organization_id"]: '',
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]) : DateTime.now(),
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : DateTime.now(),
    //questionnaire:[],
    questionnaire: json["questionnaire"]!=null ? List<Questionnaire>.from(json["questionnaire"].map((x) => Questionnaire.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "material_book_id": materialBookId,
    "lesson_type": lessonType,
    "lesson_no": lessonNo,
    "lesson": lesson,
    "content": content,
    "questionnaire": List<dynamic>.from(questionnaire.map((x) => x.toJson())),
    "createdBy_user_id": createdByUserId,
    "organization_id": organizationId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  LessonModel.fromMap(Map<String,dynamic> map) {
    id = map["id"];
    materialBookId= map["material_book_id"];
    lessonType= map["lesson_type"];
    lessonNo= map["lesson_no"];
    lesson= map["lesson"];
    content= map["content"];
    createdByUserId= map["createdBy_user_id"];
    organizationId= map["organization_id"];
    createdAt= DateTime.parse(map["created_at"]);
    updatedAt= DateTime.parse(map["updated_at"]);
    //questionnaire:[],
    questionnaire= [];
  }
}

class Questionnaire {
  late String id;
  late String type;
  late dynamic no;
  late String value;
  late String alignment;
  late String fontStyle;
  late String fontWeight;
  late String column;
  late String label;
  late String label_2;
  late String direction;
  late String image_source;
  late String language;
  late String indent_style;
  late Data data;

  Questionnaire({
    required this.id,
    required this.type,
    required this.no,
    required this.value,
    required this.alignment,
    required this.fontStyle,
    required this.fontWeight,
    required this.column,
    required this.label,
    required this.label_2,
    required this.direction,
    required this.language,
    required this.indent_style,
    required this.data,
  });

  factory Questionnaire.fromJson(Map<String, dynamic> json) => Questionnaire(
    id: json["id"]!=null ? json["id"] : '0',
    type: json["type"]!=null ? json["type"]: '',
    no: json["no"]!=null ? json["no"] : 0,
    value: json["value"]!=null ? json["value"]: '',
    alignment: json["alignment"]!=null ? json["alignment"]: '',
    fontStyle: json["font_style"]!=null ? json["font_style"]: '',
    fontWeight: json["font_weight"]!=null ? json["font_weight"]: '',
    column: json["column"]!=null ? json["column"]:'',
    label: json["label"]!=null ? json["label"]:'',
    label_2: json["label_2"]!=null ? json["label_2"]:'',
    direction: json["direction"]!=null ? json["direction"]:'',
    indent_style: json["indent_style"]!=null ? json["indent_style"]:'',
    language:'',
    //data:new Data(answers: [])
    data: json["data"]!=null ? (json["data"].isEmpty ? new Data(answers: []):Data.fromJson(json["data"])) : new Data(answers: []),
  );

  Questionnaire.fromMap(Map<String,dynamic> map) {
    id = map["id"];
    type =  map["type"];
    no = map["no"];
    value = map["value"];
    alignment = map["alignment"];
    fontStyle = map["font_style"];
    fontWeight= map["font_weight"];
    column= map["column"];
    label= map["label"];
    label_2= map["label_2"];
    direction= map["direction"];
    language= map["language"];
    data = new Data(answers: []);
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "no": no,
    "value": value,
    "alignment": alignment,
    "font_style": fontStyle,
    "font_weight": fontWeight,
    "column": column,
    "label": label,
    "label_2": label_2,
    "data": data.toJson(),
  };
}

class Data {
  List<Answer> answers;
  Data({required this.answers});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    answers: json["answers"]!=null ? List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
  };
}

class Answer {
  dynamic uuid;
  dynamic no;
  dynamic label;
  dynamic label2;
  dynamic objectType;
  dynamic objectType2;
  dynamic answer;
  dynamic answer2;
  dynamic answerType;
  dynamic answerType2;
  dynamic columnSize;
  dynamic columnDirection;
  dynamic listItem;
  dynamic imgSource;
  dynamic language;

  Answer({
    required this.uuid,
    required this.no,
    required this.label,
    required this.label2,
    required this.objectType,
    required this.objectType2,
    required this.answer,
    required this.answer2,
    required this.answerType,
    required this.answerType2,
    required this.columnSize,
    required this.columnDirection,
    required this.listItem,
    required this.imgSource,
    required this.language
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
    uuid: json["uuid"]!=null ? json["uuid"]: '',
    no: json["no"]!=null ? json["no"]: '',
    label: json["label"]!=null ? json["label"]: '',
    label2: json["label_2"]!=null ? json["label_2"]: '',
    objectType: json["object_type"]!=null ? json["object_type"]: '',
    objectType2: json["object_type_2"]!=null ? json["object_type_2"]: '',
    answer: json["answer"]!=null ? json["answer"]: '',
    answer2: json["answer_2"]!=null ? json["answer_2"]: '',
    answerType: json["answer_type"]!=null ? json["answer_type"]: '',
    answerType2: json["answer_type_2"]!=null ? json["answer_type_2"]: '',
    columnSize: json["column_size"]!=null ? json["column_size"]: '',
    columnDirection: json["column_direction"]!=null ? json["column_direction"]: '',
    listItem: json["list_item"]!=null ? json["list_item"]: '',
    imgSource: json["img_source"]!=null ? json["img_source"]: '',
    language: ''
  );
  Answer.fromMap(Map<String,dynamic> map) {
    uuid = map["uuid"];
    no = map["no"];
    label = map["label"];
    label2 = map["label_2"];
    objectType = map["object_type"];
    objectType2 = map["object_type_2"];
    answer = map["answer"];
    answer2 = map["answer_2"];
    answerType = map["answer_type"];
    answerType2 = map["answer_type_2"];
    columnSize = map["column_size"];
    columnDirection = map["column_direction"];
    listItem = map["list_item"];
    imgSource = map["img_source"];
    language = map["language"];
  }


  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "no": no,
    "label": label,
    "label_2": label2,
    "object_type": objectType,
    "object_type_2": objectType2,
    "answer": answer,
    "answer_2": answer2,
    "answer_type": answerType,
    "answer_type_2": answerType2,
    "column_size": columnSize,
    "column_direction": columnDirection,
    "list_item": listItem,
    "img_source": imgSource,
  };
}
