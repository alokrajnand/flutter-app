import 'package:flutter/material.dart';
import 'package:flutterapp/env/theam.dart';
import 'package:flutterapp/models/user-model.dart';
import 'package:flutterapp/screens/request.dart';
import 'package:flutterapp/screens/subscription.dart';
import 'package:flutterapp/screens/welcome.dart';
import 'package:flutterapp/service/profile-service.dart';
import 'home.dart';
import 'membercard.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ///
  Future _navigateToHome(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  ////////////////
  Future _navigateToSubscription(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SubscriptionScreen()));
  }

  ////////////////
  Future _navigateToRequest(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RequestScreen()));
  }

  ////////////////
  Future _navigateToMemberCard(context, users) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MemberCardScreen(user: users)));
  }

  ////////////////
  Future _navigateToWelcome(context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }

  Widget _buildProfileBanner(user) {
    return Container(
      color: AppColors.PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 72,
                  backgroundColor: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/ob-img-1.png'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  user.userCity +
                      ' | ' +
                      user.userDistrict +
                      ' | ' +
                      user.userState,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white70,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Subscription'),
                        onPressed: () {
                          _navigateToSubscription(context);
                        },
                      ),
                      SizedBox(width: 20),
                      RaisedButton(
                        child: Text('Request'),
                        onPressed: () {
                          _navigateToRequest(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

///////// Widget for the different component of the profile

  Widget _buildprofileUserAddress(user) {
    return Container(
      width: 400,
      child: Card(
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Address :',
                style: TextStyle(
                    color: AppColors.PRIMARY_COLOR,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Name - ' + user.name,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
              ),
              Text(
                'district - ' + user.userDistrict,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
              ),
              Text(
                'City/Village - ' + user.userCity,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
              ),
              Text(
                'Pin Code - ' + user.userPincode.toString(),
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildprofileEdit() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        color: Colors.white70,
        child: ListTile(
            leading: Icon(
              Icons.person,
              color: AppColors.PRIMARY_COLOR,
              size: 23,
            ),
            title: Text(
              ' Edit Profile',
              style: TextStyle(
                color: AppColors.PRIMARY_COLOR,
                fontSize: 19,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward,
              color: AppColors.PRIMARY_COLOR,
              size: 23,
            ),
            onTap: () {
              Navigator.of(context).pop();
            }),
      ),
    );
  }

  Widget _buildprofileLogout() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        color: Colors.white70,
        child: ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: AppColors.PRIMARY_COLOR,
              size: 23,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: AppColors.PRIMARY_COLOR,
                fontSize: 19,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward,
              color: AppColors.PRIMARY_COLOR,
              size: 23,
            ),
            onTap: () async {
              Navigator.of(context).pop();
              await storage.deleteAll();
              await _navigateToWelcome(context);
            }),
      ),
    );
  }

  Widget _builUserCard(user) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Card(
        color: Colors.white70,
        child: ListTile(
            leading: Icon(
              Icons.card_membership,
              color: AppColors.PRIMARY_COLOR,
              size: 23,
            ),
            title: Text(
              'Your Member Card',
              style: TextStyle(
                color: AppColors.PRIMARY_COLOR,
                fontSize: 19,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward,
              color: AppColors.PRIMARY_COLOR,
              size: 23,
            ),
            onTap: () {
              final users = Usermodel(name: user.name);
              Navigator.of(context).pop();
              _navigateToMemberCard(context, users);
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Profile Screen'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                _navigateToHome(context);
              }),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: ProfileService.getProfile(),
          builder: (BuildContext context, AsyncSnapshot<Usermodel> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  _buildProfileBanner(snapshot.data),
                  SizedBox(height: 10),
                  _buildprofileUserAddress(snapshot.data),
                  _buildprofileEdit(),
                  _builUserCard(snapshot.data),
                  _buildprofileLogout(),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
