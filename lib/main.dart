import 'package:flutter/material.dart';
import 'package:flutterapp/env/theam.dart';
import 'screens/flash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.PRIMARY_COLOR,
        brightness: Brightness.light,
        accentColor: Colors.cyan[600],
        fontFamily: 'Yantramanav',
        //fontFamily: 'Niconne',
      ),
      home: FlashScreen(),
    );
  }
}
