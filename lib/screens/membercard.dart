import 'package:flutter/material.dart';
import 'package:flutterapp/env/theam.dart';
import 'package:flutterapp/models/user-model.dart';
import 'package:flutterapp/screens/home.dart';

class MemberCardScreen extends StatefulWidget {
  final Usermodel user;
  const MemberCardScreen({@required this.user});
  @override
  _MemberCardScreenState createState() => _MemberCardScreenState();
}

class _MemberCardScreenState extends State<MemberCardScreen> {
  ///
  Future _navigateToHome(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Card'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                _navigateToHome(context);
              }),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        height: 250,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/ob-img-1.png"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Logo',
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 80),
                  Text(
                    widget.user.name,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.PRIMARY_COLOR),
                  ),
                  Text(
                    '0982 4536 3452 6543',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.PRIMARY_COLOR),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
