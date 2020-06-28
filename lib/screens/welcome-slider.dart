import 'package:flutter/material.dart';
import '../models/onboarding_slider.dart';
import '../custom_widget/onboarding_slider.dart';
//import '../custom_widget/image_banner.dart';

class WelcomeScreenSlider extends StatefulWidget {
  @override
  _WelcomeScreenSliderState createState() => _WelcomeScreenSliderState();
}

class _WelcomeScreenSliderState extends State<WelcomeScreenSlider> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              itemCount: slideList.length,
              itemBuilder: (ctx, i) => SlideItem(i),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
            child: Text(
          'This is a button',
          style: TextStyle(fontSize: 19),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
