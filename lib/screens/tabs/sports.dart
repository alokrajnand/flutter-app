import 'package:flutter/material.dart';
import 'package:flutterapp/env/theam.dart';
import 'package:flutterapp/models/product-model.dart';
import 'package:flutterapp/service/product-service.dart';

class SportTabScreen extends StatelessWidget {
  ///////
  ///
  ///
  Widget _buildUpcomingTournament(product) {
    return Container(
      height: 200,
      width: 300,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/mb-bg.jpg'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('alok'),
              Text('alok'),
              Text('alok'),
            ],
          ),
        ),
      ),
    );
  }

  ///////
  ///
  ///
  Widget _buildTeams(product) {
    return Container(
      height: 300,
      width: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/mb-bg.jpg'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('alok'),
              Text('alok'),
              Text('alok'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15),
          Text(
            'Upcoming Tournament',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 180,
            //color: Colors.black12,
            child: FutureBuilder(
              future: ProductService.getProduct(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.hasData) {
                  List<Product> products = snapshot.data;
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: products
                        .map((Product product) =>
                            _buildUpcomingTournament(product))
                        .toList(),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Teams',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 250,
            //color: Colors.black12,
            child: FutureBuilder(
              future: ProductService.getProduct(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Product>> snapshot) {
                if (snapshot.hasData) {
                  List<Product> products = snapshot.data;
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: products
                        .map((Product product) => _buildTeams(product))
                        .toList(),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      )),
    );
  }
}
