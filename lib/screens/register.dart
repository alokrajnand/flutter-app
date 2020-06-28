import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutterapp/models/auth-model.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

//create a future /function that return auth model

class _RegisterScreenState extends State<RegisterScreen> {
// Form Variables
  String _name;
  String _phoneNumber;
  String _password;
  String _messageToUser = '';

// Register User Api Call

//routing to home
  void _navigateToauth(_phoneNumber) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AuthScreen(_phoneNumber)));
  }

  Future<Authmodel> registerUser(
      String _phoneNumber, String _name, String _password) async {
    final String apiUrl = "http://127.0.0.1:8000/api/user/register/";

    Map data = {
      "phone_number": _phoneNumber,
      "name": _name,
      "password": _password
    };
    String body = jsonEncode(data);

    final response = await http.post(apiUrl,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      setState(() {
        _messageToUser = 'registration success';
      });
      _navigateToauth(_phoneNumber);
    } else {
      setState(() {
        _messageToUser = 'phone number all ready exists';
      });
    }
  }

// Create a global key for the form

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// different widgent for the each form input field

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Requires';
        }
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildPhoneNumberField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone Number'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number is Requires';
        }
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: 'Password'),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Requires';
        }
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildNameField(),
                _buildPhoneNumberField(),
                _buildPasswordField(),
                SizedBox(height: 80),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _messageToUser,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    )),
                RaisedButton(
                  child: Text('Register'),
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                    print(_name);
                    print(_phoneNumber);
                    print(_password);
                    final Authmodel user =
                        await registerUser(_phoneNumber, _name, _password);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
