// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

Course courseFromJson(String str) => Course.fromJson(json.decode(str));

String courseToJson(Course data) => json.encode(data.toJson());

class Course {
    Course({
        this.id,
        this.courseId,
        this.courseName,
        this.courseCategory,
        this.courseOwner,
        this.courseShortDesc,
        this.courseDesc,
        this.courseImagePath,
        this.createdDt,
        this.updatedDt,
    });

    int id;
    String courseId;
    String courseName;
    String courseCategory;
    String courseOwner;
    String courseShortDesc;
    dynamic courseDesc;
    dynamic courseImagePath;
    dynamic createdDt;
    dynamic updatedDt;

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        courseId: json["course_id"],
        courseName: json["course_name"],
        courseCategory: json["course_category"],
        courseOwner: json["course_owner"],
        courseShortDesc: json["course_short_desc"],
        courseDesc: json["course_desc"],
        courseImagePath: json["course_image_path"],
        createdDt: json["created_dt"],
        updatedDt: json["updated_dt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
        "course_name": courseName,
        "course_category": courseCategory,
        "course_owner": courseOwner,
        "course_short_desc": courseShortDesc,
        "course_desc": courseDesc,
        "course_image_path": courseImagePath,
        "created_dt": createdDt,
        "updated_dt": updatedDt,
    };
}
