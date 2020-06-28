import 'package:flutter/material.dart';
import 'package:flutterapp/env/theam.dart';
import 'package:flutterapp/screens/home.dart';
import 'package:flutterapp/screens/product.dart';
import 'package:flutterapp/screens/profile.dart';
import 'package:flutterapp/screens/request.dart';
import 'package:flutterapp/screens/subscription.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    ProfileScreen(),
    ProductScreen(),
    RequestScreen(),
    
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('home'),
              backgroundColor: AppColors.PRIMARY_COLOR,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              backgroundColor: AppColors.PRIMARY_COLOR,
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.subscriptions),
                title: Text('Subscription'),
                backgroundColor: AppColors.PRIMARY_COLOR),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_box),
                title: Text('Request'),
                backgroundColor: AppColors.PRIMARY_COLOR)
          ]),
    );
  }
}
