import 'package:flutterapp/models/product-model.dart';
import 'package:flutterapp/models/user-model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

class ProfileService {
  static Future<Usermodel> getProfile() async {
    String phoneNumber = await storage.read(key: '_phone_number');

    final response = await http.get(
        'http://127.0.0.1:8000/api/profile/' + phoneNumber,
        headers: {"Content-Type": "application/json"});
    var data = Usermodel.fromJson(json.decode(response.body.toString()));
    return data;
  }
}
