import 'package:flutterapp/models/product-model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductService {
  static const String apiUrl = "http://127.0.0.1:8000/api/product/";

  static Future<List<Product>> getProduct() async {
    final response = await http.get(apiUrl);
    List<dynamic> jsonData = json.decode(response.body);
    List<Product> products =
        jsonData.map((dynamic item) => Product.fromJson(item)).toList();
    return products;
  }
}
