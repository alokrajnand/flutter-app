import 'package:flutter/material.dart';
import 'package:flutterapp/env/theam.dart';
import 'package:flutterapp/screens/productDetail.dart';
import 'package:flutterapp/service/product-service.dart';
import 'package:flutterapp/models/product-model.dart';

class ShopTabScreen extends StatefulWidget {
  @override
  _ShopTabScreenState createState() => _ShopTabScreenState();
}

class _ShopTabScreenState extends State<ShopTabScreen> {
  /// future show model sheet

  _showModalBottomSheet(context, product) {
    showBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (BuildContext context) {
          return Container(
              height: 700,
              color: Colors.transparent,
              child: ProductDetailScreen(product: product));
        });
  }

  Widget _buildOfferOfTheDay(product) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          Container(
            width: 320,
            //color: Colors.amber,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    //color: Colors.black,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image(
                        height: 120,
                        width: 120,
                        image: AssetImage(product.prodcutImagePat),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 150,
                          child: Text(
                            product.productName,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: AppColors.PRIMARY_COLOR),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'MRP - 200',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                        ),
                        Text(
                          'Our Price - 150',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          width: 120,
                          height: 25,
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: BorderSide(color: Colors.cyanAccent)),
                            // elevation: 0,
                            color: Colors.white,
                            textColor: AppColors.PRIMARY_COLOR,
                            child: Text(
                              'Subscribe',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              _showModalBottomSheet(context, product);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

////////////////

  Widget _buildproduct(product) {
    return Container(
      width: 210.0,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                    height: 180,
                    width: 200,
                    image: AssetImage(product.prodcutImagePat),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.productName,
                    style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.PRIMARY_COLOR),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Product Description  - product is of very good quality',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: 109,
            height: 25,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.cyanAccent)),
              // elevation: 0,
              color: Colors.white,
              textColor: AppColors.PRIMARY_COLOR,
              child: Text(
                'Subscribe',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                _showModalBottomSheet(context, product);
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Our Top Product',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.PRIMARY_COLOR),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent),
                ),
              ],
            ),

            /// NEXT ROW FOR SOME OF THE TOP PRODUCT WE HAVE
            Container(
              height: 370,
              child: FutureBuilder(
                future: ProductService.getProduct(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasData) {
                    List<Product> products = snapshot.data;
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: products
                          .map((Product product) => _buildproduct(product))
                          .toList(),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Offer Of The Day',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.PRIMARY_COLOR),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pinkAccent),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 140,
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
                          .map(
                              (Product product) => _buildOfferOfTheDay(product))
                          .toList(),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
