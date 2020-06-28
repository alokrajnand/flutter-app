import 'dart:convert';
import 'package:flutterapp/screens/welcome.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterapp/env/theam.dart';
import 'package:flutterapp/models/auth-model.dart';
import 'package:flutterapp/screens/home.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shimmer/shimmer.dart';

class FlashScreen extends StatefulWidget {
  @override
  _FlashScreenState createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  // Create storage
  final storage = new FlutterSecureStorage();
  String _messageToUser = '';
  //local auth
  final LocalAuthentication auth = LocalAuthentication();

  ///dart logic

  ///navigation to home
  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  /// Navigation to login
  ////////////////
  Future _navigateToWelcome(context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }

  @override
  void initState() {
    super.initState();

    _chekLocalAuthLoginCredential().then((status) {
      if (status) {
        print('ok');
        locaAuthLogin();
      } else {
        print('ok here');
        _navigateToWelcome(context);
      }
    });
  }

// Login User api call
  Future<Authmodel> locaAuthLogin() async {
    String _phone_number = await storage.read(key: '_phone_number');
    String _password = await storage.read(key: '_password');

    final String apiUrl = "http://127.0.0.1:8000/api/user/login/";
    Map data = {"username": _phone_number, "password": _password};
    String body = jsonEncode(data);
    final response = await http.post(apiUrl,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      final user = Authmodel.fromJson(json.decode(response.body));
      //storeUserToLocalStorage(_phone_number, _password);
      setState(() {
        _messageToUser = 'Valid Password';
      });
      _navigateToHome();
    } else if (response.statusCode == 404) {
      setState(() {
        _messageToUser = json.decode(response.body);
      });
      Fluttertoast.showToast(msg: _messageToUser);
    } else if (response.statusCode == 403) {
      setState(() {
        _messageToUser = json.decode(response.body);
      });
      Fluttertoast.showToast(msg: _messageToUser);
    } else {
      setState(() {
        _messageToUser = 'Incorrect Password - Please Check your Password';
      });
      Fluttertoast.showToast(msg: _messageToUser);
    }
  }

//future to check the record in local storage and if true then paas true

  Future<bool> _chekLocalAuthLoginCredential() async {
    String _phone_number = await storage.read(key: '_phone_number');
    if (_phone_number == null) {
      return false;
    } else {
      return true;
    }
  }

//function to delay for 50 seconds
  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    return true;
  }

  /// Navigation to Register

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/mb-bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.PRIMARY_COLOR,
        //appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Color(0xffe00ff),
                child: Container(
                  child: Text(
                    'Samaj',
                    style: TextStyle(color: Colors.pink, fontSize: 80),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
