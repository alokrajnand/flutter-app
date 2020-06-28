import 'package:flutter/material.dart';
import '../models/onboarding_slider.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(slideList[index].imageUrl),
        Center(
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(slideList[index].header,
                    style: TextStyle(fontSize: 22)))),
        Center(
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(slideList[index].description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 19)))),
      ],
    );
  }
}
