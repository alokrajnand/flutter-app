import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutterapp/models/subscription-model.dart';
import 'package:flutterapp/models/user-model.dart';
import 'package:flutterapp/screens/subscription.dart';
import 'package:flutterapp/service/profile-service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BillScreen extends StatefulWidget {
  final Subscription subscription;
  const BillScreen({this.subscription});

  @override
  _BillScreenState createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
//// Paymant gateway code
  String _messageToUser = '';
  var _phone_number;
  //int totalAmount = 100;
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _hanlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _hanlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _hanleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var _taxAmount = (widget.subscription.subscriptionPrice * 0.05);
    var _totalAmount = (_taxAmount + widget.subscription.subscriptionPrice);
    var options = {
      'key': 'rzp_test_Bg4MvuxRPcfPFx',
      'amount': _totalAmount * 100,
      'name': 'Alok',
      'description': 'test Payment',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _hanlePaymentSuccess(PaymentSuccessResponse response) {
    subscribe(_phone_number);
    Fluttertoast.showToast(
        msg: 'Success ' + response.paymentId, timeInSecForIosWeb: 5);
    // call post method to enter subscription data
  }

  void _hanlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'Error' + response.code.toString() + response.message);
  }

  void _hanleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: 'External Wallet' + response.walletName);
  }

//// Post method for subscription entry

//routing to the Subscription page
  void _navigateToSubscription() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => SubscriptionScreen()));
  }

  ///
  Future<Subscription> subscribe(_phoneNumber) async {
    final String apiUrl = "http://127.0.0.1:8000/api/subscription/sub/";

    Map data = {
      "product_id": widget.subscription.productId,
      "product_name": widget.subscription.productName,
      "prodcut_image_pat": widget.subscription.prodcutImagePat,
      "product_price": widget.subscription.productPrice,
      "subscription_price": widget.subscription.subscriptionPrice,
      "quantity": widget.subscription.quantity,
      "subscription_type": widget.subscription.subscriptionType,
      "subscription_status": widget.subscription.subscriptionStatus,
      "user_id": _phoneNumber,
    };

    String body = jsonEncode(data);
    print(body);
    final response = await http.post(apiUrl,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      setState(() {
        _messageToUser = 'Subscription is suceess';
      });
      _navigateToSubscription();
    } else {
      setState(() {
        _messageToUser = 'Subscription Fail please cunsult customer support';
      });
    }
  }

  Widget _buildBill({Usermodel users}) {
    var _taxAmount = (widget.subscription.subscriptionPrice * 0.05);
    var _totalAmount = (_taxAmount + widget.subscription.subscriptionPrice);
    return Padding(
      padding:
          const EdgeInsets.only(top: 18.0, bottom: 18, left: 8.0, right: 8.0),
      child: Container(
          height: 500,
          width: 500,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 15.0, left: 25.0, right: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Bill Reciept',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Name'),
                      Text(users.name),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Phone Number'),
                      Text(widget.subscription.userId),
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Amount'),
                      Text(widget.subscription.subscriptionPrice.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Tax = 2 %'),
                      Text(_taxAmount.toString()),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Total'),
                      Text(_totalAmount.toString()),
                    ],
                  ),
                  SizedBox(height: 80),
                  RaisedButton(
                      child: Text('Pay'),
                      onPressed: () {
                        openCheckout();
                      }),
                  Text(_messageToUser)
                ],
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Bill'),
      ),
      body: Container(
        child: FutureBuilder(
          future: ProfileService.getProfile(),
          builder: (BuildContext context, AsyncSnapshot<Usermodel> snapshot) {
            var users = snapshot.data;
            if (snapshot.hasData) {
              _phone_number = users.phoneNumber;
              return _buildBill(users: users);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
