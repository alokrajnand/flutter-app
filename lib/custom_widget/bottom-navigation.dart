import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  Widget test() {
    return BottomNavigationBar(currentIndex: _currentIndex, items: [
      BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('home'),
          backgroundColor: Colors.blue),
      BottomNavigationBarItem(
          icon: Icon(Icons.subscriptions),
          title: Text('Subscription'),
          backgroundColor: Colors.blue),
      BottomNavigationBarItem(
          icon: Icon(Icons.add_box),
          title: Text('issue'),
          backgroundColor: Colors.blue),
      BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
          backgroundColor: Colors.blue)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
