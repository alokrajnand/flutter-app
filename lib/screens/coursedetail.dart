import 'package:flutter/material.dart';
import 'package:flutterapp/env/theam.dart';
import 'package:flutterapp/models/course-model.dart';
import 'package:flutterapp/models/lesson-model.dart';
import 'package:flutterapp/service/edu-services.dart';

import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course;
  const CourseDetailScreen({@required this.course});

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  var _selectedLesson = 0;
  var _selectedVideo = 'assets/images/test.mov';
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  Widget _buildLesson(lesson) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedLesson = lesson.id;
                _selectedVideo = lesson.lessonVideoPath;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: _selectedLesson == lesson.id
                      ? AppColors.PRIMARY_COLOR
                      : Colors.white24),
              child: ListTile(
                leading: Icon(Icons.blur_circular),
                title: Text(
                  lesson.lessonName,
                  style: TextStyle(fontSize: 15),
                ),
                trailing: Icon(Icons.video_label),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black12)),
            ),
          ),
        ],
      ),
    );
  }

  void initiatePlayer() {
    videoPlayerController = VideoPlayerController.asset(_selectedVideo);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void initState() {
    initiatePlayer();
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedVideo != _selectedVideo) {
      videoPlayerController.dispose();
      chewieController.dispose();
      initiatePlayer();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Course Detail'),
      ),
      body: Container(
        child: Column(children: <Widget>[
          Container(
            height: 300,
            color: Colors.pinkAccent,
            child: Chewie(controller: chewieController),
          ),
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: EduService.getLesson(widget.course.courseId),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Lesson>> snapshot) {
                  if (snapshot.hasData) {
                    List<Lesson> lessons = snapshot.data;
                    return ListView(
                      children: lessons
                          .map((Lesson lesson) => _buildLesson(lesson))
                          .toList(),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          )
        ]),
      ),
    );
  }
}
