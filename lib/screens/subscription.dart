import 'package:flutter/material.dart';
import 'package:flutterapp/models/subscription-model.dart';
import 'package:flutterapp/service/subscription-service.dart';

import 'home.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  ///
  Future _navigateToHome(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  Widget _buildSubscription(subscription) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: InkWell(
          onTap: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0),
                  ),
                  child: Image.asset('assets/images/ob-img-1.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 250,
                      child: Text(
                        'Raw Cow Milk - 1 litter Raw Cow Milk - 1 litter ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Quantity' + subscription.id.toString() + '1 Daily'),
                    Text('Active'),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                _navigateToHome(context);
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 28.0),
        child: Container(
          child: FutureBuilder(
            future: SubscriptionService.getSubscription(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Subscription>> snapshot) {
              if (snapshot.hasData) {
                List<Subscription> subscriptions = snapshot.data;
                return ListView(
                  children: subscriptions
                      .map(
                        (Subscription subscription) =>
                            _buildSubscription(subscription),
                      )
                      .toList(),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
