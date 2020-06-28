// To parse this JSON data, do
//
//     final subscription = subscriptionFromJson(jsonString);

import 'dart:convert';

Subscription subscriptionFromJson(String str) =>
    Subscription.fromJson(json.decode(str));

String subscriptionToJson(Subscription data) => json.encode(data.toJson());

class Subscription {
  Subscription({
    this.id,
    this.subscriptionId,
    this.productId,
    this.productName,
    this.prodcutImagePat,
    this.productPrice,
    this.subscriptionPrice,
    this.quantity,
    this.subscriptionType,
    this.subscriptionStatus,
    this.userId,
    this.createdDt,
    this.updatedDt,
  });

  int id;
  String subscriptionId;
  String productId;
  String productName;
  String prodcutImagePat;
  int productPrice;
  int subscriptionPrice;
  int quantity;
  String subscriptionType;
  String subscriptionStatus;
  String userId;
  DateTime createdDt;
  DateTime updatedDt;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"],
        subscriptionId: json["subscription_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        prodcutImagePat: json["prodcut_image_pat"],
        productPrice: json["product_price"],
        subscriptionPrice: json["subscription_price"],
        quantity: json["quantity"],
        subscriptionType: json["subscription_type"],
        subscriptionStatus: json["subscription_status"],
        userId: json["user_id"],
        createdDt: DateTime.parse(json["created_dt"]),
        updatedDt: DateTime.parse(json["updated_dt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subscription_id": subscriptionId,
        "product_id": productId,
        "product_name": productName,
        "prodcut_image_pat": prodcutImagePat,
        "product_price": productPrice,
        "subscription_price": subscriptionPrice,
        "quantity": quantity,
        "subscription_type": subscriptionType,
        "subscription_status": subscriptionStatus,
        "user_id": userId,
        "created_dt": createdDt.toIso8601String(),
        "updated_dt": updatedDt.toIso8601String(),
      };
}
