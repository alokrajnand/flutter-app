import 'package:flutter/material.dart';
import 'package:flutterapp/env/theam.dart';
import 'package:flutterapp/models/user-model.dart';
import 'package:flutterapp/screens/product.dart';
import 'package:flutterapp/screens/profile.dart';
import 'package:flutterapp/screens/request.dart';
import 'package:flutterapp/screens/subscription.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterapp/screens/welcome.dart';

class DrawerScreen extends StatefulWidget {
  final Usermodel users;
  const DrawerScreen({this.users});

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  // Create storage
  final storage = new FlutterSecureStorage();

////////////////
  Future _navigateToProfile(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfileScreen()));
  }

  ////////////////
  Future _navigateToSubscription(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SubscriptionScreen()));
  }

  ////////////////
  Future _navigateToProduct(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductScreen()));
  }

  ////////////////
  Future _navigateToRequest(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RequestScreen()));
  }

  ////////////////
  Future _navigateToWelcome(context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/ob-img-1.png'),
            ),
            accountName: Text(
              widget.users.name,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            accountEmail: Text(
              widget.users.phoneNumber,
              style: TextStyle(fontSize: 15),
            ),
          ),
          ListTile(
              leading: Icon(
                Icons.person,
                color: AppColors.PRIMARY_COLOR,
                size: 25,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                    color: AppColors.PRIMARY_COLOR,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              trailing: Icon(
                Icons.arrow_forward,
                color: AppColors.PRIMARY_COLOR,
                size: 25,
              ),
              onTap: () {
                Navigator.of(context).pop();
                _navigateToProfile(context);
              }),
          Divider(thickness: 2),
          ListTile(
            leading: Icon(
              Icons.comment,
              color: AppColors.PRIMARY_COLOR,
              size: 25,
            ),
            title: Text(
              'Request',
              style: TextStyle(
                  color: AppColors.PRIMARY_COLOR,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            trailing: Icon(
              Icons.arrow_forward,
              color: AppColors.PRIMARY_COLOR,
              size: 25,
            ),
            onTap: () {
              Navigator.of(context).pop();
              _navigateToRequest(context);
            },
          ),
          Divider(thickness: 2),
          ListTile(
            leading: Icon(
              Icons.subscriptions,
              color: AppColors.PRIMARY_COLOR,
              size: 25,
            ),
            title: Text(
              'Subscription',
              style: TextStyle(
                  color: AppColors.PRIMARY_COLOR,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            trailing: Icon(
              Icons.arrow_forward,
              color: AppColors.PRIMARY_COLOR,
              size: 25,
            ),
            onTap: () {
              Navigator.of(context).pop();
              _navigateToSubscription(context);
            },
          ),
          Divider(thickness: 2),
          ListTile(
            leading: Icon(
              Icons.add_shopping_cart,
              color: AppColors.PRIMARY_COLOR,
              size: 25,
            ),
            title: Text(
              'Product',
              style: TextStyle(
                  color: AppColors.PRIMARY_COLOR,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            trailing: Icon(
              Icons.arrow_forward,
              color: AppColors.PRIMARY_COLOR,
              size: 25,
            ),
            onTap: () {
              Navigator.of(context).pop();
              _navigateToProduct(context);
            },
          ),
          Divider(thickness: 2),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: AppColors.PRIMARY_COLOR,
              size: 25,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                  color: AppColors.PRIMARY_COLOR,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            trailing: Icon(
              Icons.arrow_forward,
              color: AppColors.PRIMARY_COLOR,
              size: 25,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Divider(thickness: 2),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: AppColors.PRIMARY_COLOR,
              size: 25,
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                  color: AppColors.PRIMARY_COLOR,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            trailing: Icon(
              Icons.arrow_forward,
              color: AppColors.PRIMARY_COLOR,
              size: 25,
            ),
            onTap: () async {
              Navigator.of(context).pop();
              await storage.deleteAll();
              await _navigateToWelcome(context);
            },
          ),
        ],
      ),
    );
  }
}
