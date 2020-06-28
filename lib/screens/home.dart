import 'package:flutter/material.dart';
import 'package:flutterapp/env/theam.dart';
import 'package:flutterapp/models/user-model.dart';
import 'package:flutterapp/screens/drawer.dart';
import 'package:flutterapp/screens/tabs/education.dart';
import 'package:flutterapp/screens/tabs/samaj.dart';
import 'package:flutterapp/screens/tabs/shop.dart';
import 'package:flutterapp/screens/tabs/sports.dart';
import 'package:flutterapp/service/profile-service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
////
  List<IconData> _icons = [
    Icons.shopping_basket,
    Icons.people,
    Icons.games,
    Icons.book,
  ];

  Widget _buildTabContainer(int index) {
    if (index == 0) {
      return ShopTabScreen();
    } else if (index == 1) {
      return SamajTabScreen();
    } else if (index == 2) {
      return SportTabScreen();
    } else if (index == 3) {
      return EducationTabScreen();
    } else {
      return Container(
        child: Text('No Tab Selected'),
      );
    }
  }

  Widget _buildicon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40.0,
          width: 100.0,
          decoration: BoxDecoration(
              color: _selectedIndex == index
                  ? AppColors.PRIMARY_COLOR
                  : Colors.black45,
              borderRadius: BorderRadius.circular(30.0)),
          child: Container(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  _icons[index],
                  color: Colors.white,
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  /////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 248, 252, 1),
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR,
        title: const Text('Home Screen'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.home), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 25.0),
            child: _selectedIndex == 0
                ? Text(
                    'What would you like to Buy ?',
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.PRIMARY_COLOR),
                  )
                : _selectedIndex == 1
                    ? Text(
                        'We are Family',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.PRIMARY_COLOR),
                      )
                    : _selectedIndex == 2
                        ? Text(
                            'We play Together',
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.PRIMARY_COLOR),
                          )
                        : Text(
                            'We Learn Together',
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.PRIMARY_COLOR),
                          ),
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _icons
                  .asMap()
                  .entries
                  .map(
                    (MapEntry map) => _buildicon(map.key),
                  )
                  .toList(),
            ),
          ),
          _buildTabContainer(_selectedIndex)
        ],
      ),
      drawer: FutureBuilder(
        future: ProfileService.getProfile(),
        builder: (BuildContext context, AsyncSnapshot<Usermodel> snapshot) {
          var users = snapshot.data;
          if (snapshot.hasData) {
            return DrawerScreen(users: users);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
