import 'dart:convert';
import 'package:flutterapp/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  final String _phoneNumber;
  AuthScreen(@required this._phoneNumber);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String _otp;
  String _messageToUser = '';

  void _navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void validatOtp(String _otp) async {
    print(_otp);
    String _phoneNumber = (this.widget._phoneNumber);
    final String apiUrl = "http://127.0.0.1:8000/api/user/phone_varification/";

    Map data = {
      "phone_number": _phoneNumber,
      "phone_otp": _otp,
    };
    String body = jsonEncode(data);

    final response = await http.post(apiUrl,
        headers: {"Content-Type": "application/json"}, body: body);

    print(response.statusCode);
    print(_phoneNumber);
    if (response.statusCode == 200) {
      setState(() {
        _messageToUser = 'Welcome to Family - Please Login';
      });
      _navigateToLogin();
    } else {
      setState(() {
        _messageToUser = response.body.substring(1, response.body.length - 1);
      });
    }
  }

  Widget _buildOtpField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'OTP'),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Otp Is requred';
        }
      },
      onSaved: (String value) {
        _otp = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Authenticate')),
      body: Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildOtpField(),
                  SizedBox(height: 10),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _messageToUser,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      )),
                  SizedBox(height: 20),
                  RaisedButton(
                      child: Text('Validate'),
                      onPressed: () {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        _formKey.currentState.save();
                        validatOtp(_otp);
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
