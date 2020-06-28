import 'package:flutter/material.dart';
import 'package:flutterapp/env/theam.dart';
import 'package:flutterapp/models/course-model.dart';
import 'package:flutterapp/screens/coursedetail.dart';
import 'package:flutterapp/service/edu-services.dart';

import '../productDetail.dart';

class EducationTabScreen extends StatefulWidget {
  @override
  _EducationTabScreenState createState() => _EducationTabScreenState();
}

class _EducationTabScreenState extends State<EducationTabScreen> {
  Widget _buildOfferOfTheDay(course) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          Container(
            width: 340,
            //color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    //color: Colors.black,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        height: 150,
                        width: 130,
                        image: AssetImage(course.courseImagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 180,
                            child: Text(
                              course.courseName,
                              style: TextStyle(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.PRIMARY_COLOR),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'MRP - 200',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                          Text(
                            'Our Price - 150',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          FlatButton(
                              child: Text(
                                'Subscribe for Tomorrow',
                                style: TextStyle(
                                    color: AppColors.PRIMARY_COLOR,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {}),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

////////////////

  Widget _buildcourse(course) {
    return Container(
      width: 210.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CourseDetailScreen(course: course),
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    tag: course.courseImagePath,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        height: 180,
                        width: 200,
                        image: AssetImage(course.courseImagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      course.courseName,
                      style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.PRIMARY_COLOR),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Product Description  - product is of very good quality',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Our Top Courses',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.PRIMARY_COLOR),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent),
                ),
              ],
            ),

            /// NEXT ROW FOR SOME OF THE TOP PRODUCT WE HAVE
            Container(
              height: 330,
              child: FutureBuilder(
                future: EduService.getCourse(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Course>> snapshot) {
                  if (snapshot.hasData) {
                    List<Course> courses = snapshot.data;
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: courses
                          .map((Course courses) => _buildcourse(courses))
                          .toList(),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Offer Of The Day',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.PRIMARY_COLOR),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 180,
              //color: Colors.black12,
              child: FutureBuilder(
                future: EduService.getCourse(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Course>> snapshot) {
                  if (snapshot.hasData) {
                    List<Course> courses = snapshot.data;
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: courses
                          .map((Course courses) => _buildOfferOfTheDay(courses))
                          .toList(),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
