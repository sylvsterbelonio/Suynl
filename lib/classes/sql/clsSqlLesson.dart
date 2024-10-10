class clsSqlLesson{
  late int lessonID;
  late int lessonNo;
  late String bookType;
  late String answer_1;
  late String answer_2;
  late String answer_3;
  late String answer_4;
  late String answer_5;
  late String answer_6;
  late String answer_7;
  late String answer_8;
  late String answer_9;
  late String answer_10;
  late String createdDt;
  late String updatedDt;
  late int maxAnswers;
  late int completionRate;
  clsSqlLesson({
    required this.lessonID,
    required this.lessonNo,
    required this.bookType,
    required this.answer_1,
    required this.answer_2,
    required this.answer_3,
    required this.answer_4,
    required this.answer_5,
    required this.answer_6,
    required this.answer_7,
    required this.answer_8,
    required this.answer_9,
    required this.answer_10,
    required this.createdDt,
    required this.updatedDt,
    required this.maxAnswers,
    required this.completionRate,
  });

  factory clsSqlLesson.fromJson(Map<String,dynamic> json) => clsSqlLesson(
    lessonID: json['lessonID'],
    lessonNo: json['lessonNo'],
    bookType: json['bookType'],
    answer_1: json['answer_1'],
    answer_2: json['answer_2'],
    answer_3: json['answer_3'],
    answer_4: json['answer_4'],
    answer_5: json['answer_5'],
    answer_6: json['answer_6'],
    answer_7: json['answer_7'],
    answer_8: json['answer_8'],
    answer_9: json['answer_9'],
    answer_10: json['answer_10'],
    createdDt: json['createdAt'],
    updatedDt: json['updatedAt'],
    maxAnswers: json['maxAnswers'],
    completionRate: json['completionRate'],
  );
  Map<String,dynamic> toJson() => {
    'lessonID':lessonID,
    'lessonNo': lessonNo,
    'bookType': bookType,
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
    'createdDt':createdDt,
    'updatedDt':updatedDt,
    'completionRate':completionRate,
  };
  clsSqlLesson.fromMap(Map<String,dynamic> map) {
    lessonID = map['lessonID'];
    lessonNo = map['lessonNo'];
    bookType = map['bookType'];
    answer_1 = map['answer_1'];
    answer_2 = map['answer_2'];
    answer_3 = map['answer_3'];
    answer_4 = map['answer_4'];
    answer_5 = map['answer_5'];
    answer_6 = map['answer_6'];
    answer_7 = map['answer_7'];
    answer_8 = map['answer_8'];
    answer_9 = map['answer_9'];
    answer_10 = map['answer_10'];
    createdDt = map['createdAt'];
    updatedDt = map['updatedAt'];
    maxAnswers = map['maxAnswers'];
    completionRate = map['completionRate'];
  }
  clsSqlLesson.fromSnapshot(snapshot):
        lessonID = snapshot.data()['lessonID'],
        lessonNo = snapshot.data()['lessonNo'],
        bookType = snapshot.data()['bookType'],
        answer_1 = snapshot.data()['answer_1'],
        answer_2 = snapshot.data()['answer_2'],
        answer_3 = snapshot.data()['answer_3'],
        answer_4 = snapshot.data()['answer_4'],
        answer_5 = snapshot.data()['answer_5'],
        answer_6 = snapshot.data()['answer_6'],
        answer_7 = snapshot.data()['answer_7'],
        answer_8 = snapshot.data()['answer_8'],
        answer_9 = snapshot.data()['answer_9'],
        answer_10 = snapshot.data()['answer_10'],
        createdDt = snapshot.data()['createdDt'],
        updatedDt = snapshot.data()['updatedDt'],
        maxAnswers = snapshot.data()['maxAnswers'],
        completionRate = snapshot.data()['completionRate'];
}