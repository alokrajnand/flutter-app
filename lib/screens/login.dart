import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/models/auth-model.dart';
import 'package:http/http.dart' as http;
import 'home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:async';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //varibale for the form field

  String _phone_number;
  String _password;
  bool _enableAuth = false;
  String _messageToUser = '';
  String userHasTouchId;
  //bool _canCheckBiometrics;

  // Create storage
  final storage = new FlutterSecureStorage();

  //local auth
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    getSecureStorage();
  }

//routing to home
  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  Future storeUserToLocalStorage(String _phone_number, String _password) async {
    await storage.write(key: '_phone_number', value: _phone_number);
    await storage.write(key: '_password', value: _password);
    await storage.write(key: 'userHasTouchId', value: 'true');
  }

  void getSecureStorage() async {
    final value = await storage.read(key: 'userHasTouchId');
    if (value == null) {
      print(value);
      setState(() {
        userHasTouchId = 'false';
      });
    } else {
      print(value);
      setState(() {
        userHasTouchId = 'true';
      });
    }
  }

  void authenticate() async {
    final _canCheckBiometrics = await auth.canCheckBiometrics;
    if (_canCheckBiometrics) {
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.face)) {
        print('you are inside face recogni');
        bool authenticated = false;

        try {
          authenticated = await auth.authenticateWithBiometrics(
              localizedReason: 'Scan your face to authenticate',
              useErrorDialogs: true,
              stickyAuth: true);

          if (authenticated) {
            locaAuthLogin();
          } else {
            print('you are not authenticated');
          }
        } on PlatformException catch (e) {
          print(e);
        }
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        print('you are inside finger print recogni');
      }
    } else {
      print('no biometrics available');
    }
  }

// Login User api call
  Future<Authmodel> locaAuthLogin() async {
    String _phone_number = await storage.read(key: '_phone_number');
    String _password = await storage.read(key: '_password');

    final String apiUrl = "http://127.0.0.1:8000/api/user/login/";
    Map data = {"username": _phone_number, "password": _password};
    String body = jsonEncode(data);
    final response = await http.post(apiUrl,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      final user = Authmodel.fromJson(json.decode(response.body));
      storeUserToLocalStorage(_phone_number, _password);
      setState(() {
        _messageToUser = 'Valid Password';
      });
      _navigateToHome();
    } else if (response.statusCode == 404) {
      setState(() {
        _messageToUser = json.decode(response.body);
      });
    } else if (response.statusCode == 403) {
      setState(() {
        _messageToUser = json.decode(response.body);
      });
    } else {
      setState(() {
        _messageToUser = 'Incorrect Password - Please Check your Password';
      });
    }
  }

  Future<Authmodel> loginuserWithOutLocalSorage(
      String _phone_number, String _password) async {
    final String apiUrl = "http://127.0.0.1:8000/api/user/login/";
    Map data = {"username": _phone_number, "password": _password};
    String body = jsonEncode(data);

    // else - take data from the form and do the post  operation
    final response = await http.post(apiUrl,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      final user = Authmodel.fromJson(json.decode(response.body));
      setState(() {
        _messageToUser = 'Valid Password';
      });
      _navigateToHome();
    } else if (response.statusCode == 404) {
      setState(() {
        _messageToUser = json.decode(response.body);
      });
    } else if (response.statusCode == 403) {
      setState(() {
        _messageToUser = json.decode(response.body);
      });
    } else {
      setState(() {
        _messageToUser = 'Incorrect Password - Please Check your Password';
      });
    }
  }

  Future<Authmodel> loginUser(
      String _phone_number, String _password, bool _enableAuth) async {
    /// if __enableAuth is true
    if (_enableAuth == true) {
      final String apiUrl = "http://127.0.0.1:8000/api/user/login/";
      Map data = {"username": _phone_number, "password": _password};
      String body = jsonEncode(data);
      final response = await http.post(apiUrl,
          headers: {"Content-Type": "application/json"}, body: body);

      if (response.statusCode == 200) {
        final user = Authmodel.fromJson(json.decode(response.body));
        storeUserToLocalStorage(_phone_number, _password);
        setState(() {
          _messageToUser = 'Valid Password';
        });
        _navigateToHome();
      } else if (response.statusCode == 404) {
        setState(() {
          _messageToUser = json.decode(response.body);
        });
      } else if (response.statusCode == 403) {
        setState(() {
          _messageToUser = json.decode(response.body);
        });
      } else {
        setState(() {
          _messageToUser = 'Incorrect Password - Please Check your Password';
        });
      }
      // if __enableAuth is true
    } else {
      loginuserWithOutLocalSorage(_phone_number, _password);
    }
  }

  ///Create a global key for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//Different widget for each form unit

  Widget _buildFormField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone Number'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number is required';
        }
      },
      onSaved: (String value) {
        _phone_number = value;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is required';
        }
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _buildEnableAuthField() {
    return Container(
      child: userHasTouchId == 'true'
          ? InkWell(
              onTap: () {
                authenticate();
              },
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.amber, width: 2.0)),
                  child: Icon(
                    Icons.fingerprint,
                    size: 50,
                  )),
            )
          : Row(
              children: <Widget>[
                SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: Checkbox(
                    value: _enableAuth,
                    onChanged: (bool value) {
                      setState(() {
                        _enableAuth = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 15),
                Text('Enable Touch/Face Login'),
              ],
            ),
    );
  }

  /// Main Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildFormField(),
                _buildPasswordField(),
                SizedBox(height: 30),
                _buildEnableAuthField(),
                SizedBox(height: 20),
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _messageToUser,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    )),
                //submit button
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                    await loginUser(_phone_number, _password, _enableAuth);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
