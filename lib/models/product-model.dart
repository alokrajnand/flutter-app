// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    Product({
        this.id,
        this.procuctId,
        this.productName,
        this.productPrice,
        this.productCategory,
        this.productOwner,
        this.productShortDesc,
        this.productDesc,
        this.prodcutImagePat,
        this.createdDt,
        this.updatedDt,
    });

    int id;
    String procuctId;
    String productName;
    int productPrice;
    String productCategory;
    String productOwner;
    String productShortDesc;
    dynamic productDesc;
    String prodcutImagePat;
    dynamic createdDt;
    dynamic updatedDt;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        procuctId: json["procuct_id"],
        productName: json["product_name"],
        productPrice: json["product_price"],
        productCategory: json["product_category"],
        productOwner: json["product_owner"],
        productShortDesc: json["product_short_desc"],
        productDesc: json["product_desc"],
        prodcutImagePat: json["prodcut_image_pat"],
        createdDt: json["created_dt"],
        updatedDt: json["updated_dt"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "procuct_id": procuctId,
        "product_name": productName,
        "product_price": productPrice,
        "product_category": productCategory,
        "product_owner": productOwner,
        "product_short_desc": productShortDesc,
        "product_desc": productDesc,
        "prodcut_image_pat": prodcutImagePat,
        "created_dt": createdDt,
        "updated_dt": updatedDt,
    };
}
