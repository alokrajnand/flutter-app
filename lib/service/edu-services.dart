import 'package:flutterapp/models/course-model.dart';
import 'package:flutterapp/models/lesson-model.dart';
import 'package:flutterapp/models/lesson-model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EduService {
  static const String apiUrl = "http://127.0.0.1:8000/api/course/";

  static Future<List<Course>> getCourse() async {
    final response = await http.get(apiUrl);
    List<dynamic> jsonData = json.decode(response.body);
    List<Course> Courses =
        jsonData.map((dynamic item) => Course.fromJson(item)).toList();
    return Courses;
  }

  static Future<List<Lesson>> getLesson(courseName) async {
    final response = await http.get(
        'http://127.0.0.1:8000/api/course/' + courseName,
        headers: {"Content-Type": "application/json"});
    List<dynamic> jsonData = json.decode(response.body);
    List<Lesson> lesson =
        jsonData.map((dynamic item) => Lesson.fromJson(item)).toList();
    return lesson;
  }
}
