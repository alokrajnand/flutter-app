import 'package:flutterapp/models/subscription-model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

class SubscriptionService {
  static const String apiUrl =
      "http://127.0.0.1:8000/api/subscription/";

  static Future<List<Subscription>> getSubscription() async {
    String phoneNumber = await storage.read(key: '_phone_number');
    final response = await http.get(apiUrl + phoneNumber);
    List<dynamic> jsonData = json.decode(response.body);
    List<Subscription> subscriptions =
        jsonData.map((dynamic item) => Subscription.fromJson(item)).toList();
    return subscriptions;
  }
}
