import 'package:flutter/material.dart';
import 'package:flutterapp/env/theam.dart';
import 'package:flutterapp/models/product-model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({@required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool monday = true;
  bool tuesday = true;
  bool wednesday = true;
  bool thuresday = true;
  bool friday = true;
  bool saturday = true;
  bool sunday = true;

  var _advancePayment = [
    "For 7 days",
    "For 14 days",
    "For 21 days",
    "For 30 days"
  ];
  var _advancePaymentSelected = "For 7 days";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.PRIMARY_COLOR, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0)
                  ],
                ),
                child: Hero(
                  tag: widget.product.prodcutImagePat,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image(
                      image: AssetImage(widget.product.prodcutImagePat),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10.0,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 10),
                        Text(
                          widget.product.productName,
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.PRIMARY_COLOR),
                        ),
                        SizedBox(height: 0),
                        Text(
                          'Price : 200 per unit',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: <Widget>[_buildSubscriptionForm()],
            ),
          )
        ],
      ),
    );
  }

  //// Widget to build the product banner

  Widget _buildSubscriptionForm() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Quantity',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    color: AppColors.PRIMARY_COLOR,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.remove),
                      onPressed: () {},
                    ),
                  ),
                  Text('1'),
                  Container(
                    color: AppColors.PRIMARY_COLOR,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.add),
                      onPressed: () {},
                    ),
                  )
                ]),
          ),
          SizedBox(height: 10),
          Text(
            'Repeat',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('M'),
                        Checkbox(
                            value: monday,
                            onChanged: (bool value) {
                              setState(() {
                                monday = value;
                              });
                            }),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('T'),
                        Checkbox(
                            value: tuesday,
                            onChanged: (bool value) {
                              setState(() {
                                tuesday = value;
                              });
                            }),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('W'),
                        Checkbox(
                            value: wednesday,
                            onChanged: (bool value) {
                              setState(() {
                                wednesday = value;
                              });
                            }),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('T'),
                        Checkbox(
                            value: thuresday,
                            onChanged: (bool value) {
                              setState(() {
                                thuresday = value;
                              });
                            }),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('F'),
                        Checkbox(
                            value: friday,
                            onChanged: (bool value) {
                              setState(() {
                                friday = value;
                              });
                            }),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('S'),
                        Checkbox(
                            value: saturday,
                            onChanged: (bool value) {
                              setState(() {
                                saturday = value;
                              });
                            }),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('S'),
                        Checkbox(
                            value: sunday,
                            onChanged: (bool value) {
                              setState(() {
                                sunday = value;
                              });
                            }),
                      ]),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Advance payement ',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: Container(
              alignment: Alignment.center,
              color: Colors.amber,
              child: DropdownButton<String>(
                  items: _advancePayment.map((String dropDownStringItem) {
                    return DropdownMenuItem(
                      value: dropDownStringItem,
                      child: Container(
                        width: 350,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 20, right: 20),
                          child: Center(
                            child: Text(
                              dropDownStringItem,
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String newValueSelected) {
                    print(newValueSelected);
                    setState(() {
                      this._advancePaymentSelected = newValueSelected;
                    });
                  },
                  value: _advancePaymentSelected),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Start Date',
            style: TextStyle(
              fontSize: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              color: AppColors.PRIMARY_COLOR,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Select date',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Icon(Icons.calendar_today, color: Colors.white),
                  ],
                ),
              ),
              onPressed: () {
                showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));
              },
            ),
          )
        ],
      ),
    );
  }
}
