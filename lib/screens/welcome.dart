import 'package:flutter/material.dart';
import 'package:flutterapp/env/theam.dart';
import 'package:flutterapp/screens/register.dart';
import 'login.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
////////////////
  Future _navigateToLogin(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

////////////////
  Future _navigateToRegister(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterScreen()));
  }

  Widget _loginButton() {
    return Container(
      width: 350.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.9],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Color(0xff1d83ab),
            Color(0xff0cbab8),
          ],
        ),
      ),
      child: FlatButton(
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 26.0,
          ),
        ),
        textColor: Colors.white,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0)),
        onPressed: () {
          _navigateToLogin(context);
        },
      ),
    );
  }

  /// Register Button Widget

  Widget _registerButton() {
    return Container(
      width: 350.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.9],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Color(0xFF0D47A1),
            Color(0xFF1976D2),
          ],
        ),
      ),
      child: FlatButton(
        child: Text(
          'Register',
          style: TextStyle(
            fontSize: 26.0,
          ),
        ),
        textColor: Colors.white,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0)),
        onPressed: () {
          _navigateToRegister(context);
        },
      ),
    );
  }

  /// Register Button Widget

  Widget _welcomeImage() {
    return Image.asset('assets/images/ob-img-1.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
        title: Text('Welcome'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            _welcomeImage(),
            SizedBox(
              height: 20.0,
            ),
            _loginButton(),
            SizedBox(
              height: 20.0,
            ),
            _registerButton(),
          ],
        ),
      ),
    );
  }
}
