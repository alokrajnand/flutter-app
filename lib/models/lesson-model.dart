// To parse this JSON data, do
//
//     final lesson = lessonFromJson(jsonString);

import 'dart:convert';

Lesson lessonFromJson(String str) => Lesson.fromJson(json.decode(str));

String lessonToJson(Lesson data) => json.encode(data.toJson());

class Lesson {
  Lesson({
    this.id,
    this.lessonId,
    this.lessonName,
    this.lessonOwner,
    this.lessonShortDesc,
    this.lessonDesc,
    this.lessonImagePath,
    this.lessonVideoPath,
    this.createdDt,
    this.updatedDt,
    this.courseId,
  });

  int id;
  String lessonId;
  String lessonName;
  String lessonOwner;
  String lessonShortDesc;
  dynamic lessonDesc;
  dynamic lessonImagePath;
  dynamic lessonVideoPath;
  dynamic createdDt;
  dynamic updatedDt;
  String courseId;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        lessonId: json["lesson_id"],
        lessonName: json["lesson_name"],
        lessonOwner: json["lesson_owner"],
        lessonShortDesc: json["lesson_short_desc"],
        lessonDesc: json["lesson_desc"],
        lessonImagePath: json["lesson_image_path"],
        lessonVideoPath: json["lesson_video_path"],
        createdDt: json["created_dt"],
        updatedDt: json["updated_dt"],
        courseId: json["course_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lesson_id": lessonId,
        "lesson_name": lessonName,
        "lesson_owner": lessonOwner,
        "lesson_short_desc": lessonShortDesc,
        "lesson_desc": lessonDesc,
        "lesson_image_path": lessonImagePath,
        "lesson_video_path": lessonVideoPath,
        "created_dt": createdDt,
        "updated_dt": updatedDt,
        "course_id": courseId,
      };
}
