import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/env/theam.dart';
import 'package:flutterapp/models/product-model.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterapp/models/subscription-model.dart';

import 'bill.dart';

final storage = new FlutterSecureStorage();

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({@required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  var _counter = 1;
  bool _isButtonDisabled = true;
  bool _isButtonEnabled = false;

///// Counter function if counter is 1 then make minus button disable
  ///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
                image: DecorationImage(
                  image: AssetImage(widget.product.prodcutImagePat),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.product.productName,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.PRIMARY_COLOR,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.product.productShortDesc,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Price/Unit',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.PRIMARY_COLOR,
                      ),
                    ),
                    Text(
                      widget.product.productPrice.toString(),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.PRIMARY_COLOR,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),

            ///C0unter
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Quantity',
                      style: TextStyle(
                          fontSize: 25,
                          color: AppColors.PRIMARY_COLOR,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(color: Colors.amber)),
                        child: SizedBox(
                          width: 120,
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: Icon(Icons.add),
                                color: Colors.green,
                                onPressed: _isButtonEnabled
                                    ? null
                                    : () {
                                        setState(() {
                                          _counter++;
                                          if (_counter >= 2) {
                                            _isButtonDisabled = false;
                                          } else {
                                            _isButtonDisabled = true;
                                          }
                                        });
                                      },
                              ),
                              SizedBox(width: 3),
                              Text(_counter.toString()),
                              SizedBox(width: 3),
                              IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: Icon(Icons.remove),
                                color: Colors.green,
                                onPressed: _isButtonDisabled
                                    ? null
                                    : () {
                                        setState(() {
                                          _counter--;
                                          if (_counter == 1) {
                                            _isButtonDisabled = true;
                                          } else {
                                            _isButtonDisabled = false;
                                          }
                                        });
                                      },
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25),
            SizedBox(
              width: 300,
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.cyanAccent)),
                // elevation: 0,
                color: Colors.white,
                textColor: AppColors.PRIMARY_COLOR,
                child: Text(
                  'Subscribe for Every Day',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  String _phone_number =
                      await storage.read(key: '_phone_number');
                  final subscription = Subscription(
                      productId: widget.product.procuctId,
                      productName: widget.product.productName,
                      prodcutImagePat: widget.product.prodcutImagePat,
                      productPrice: widget.product.productPrice,
                      subscriptionPrice: widget.product.productPrice * _counter,
                      quantity: _counter,
                      subscriptionType: 'Daily',
                      subscriptionStatus: 'Requested',
                      userId: _phone_number);

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          BillScreen(subscription: subscription),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.cyanAccent)),
                // elevation: 0,
                color: Colors.white,
                textColor: AppColors.PRIMARY_COLOR,
                child: Text(
                  'Subscribe For Tomorrow',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  String _phone_number =
                      await storage.read(key: '_phone_number');
                  final subscription = Subscription(
                      productId: widget.product.procuctId,
                      productName: widget.product.productName,
                      prodcutImagePat: widget.product.prodcutImagePat,
                      productPrice: widget.product.productPrice,
                      subscriptionPrice: widget.product.productPrice * _counter,
                      quantity: _counter,
                      subscriptionType: 'Adhoc',
                      subscriptionStatus: 'Requested',
                      userId: _phone_number);

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          BillScreen(subscription: subscription),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
