import 'dart:convert';

Authmodel authmodelFromJson(String str) => Authmodel.fromJson(json.decode(str));

String authmodelToJson(Authmodel data) => json.encode(data.toJson());

class Authmodel {
  Authmodel({
    this.phoneNumber,
    this.name,
    this.password,
  });

  String phoneNumber;
  String name;
  String password;

  factory Authmodel.fromJson(Map<String, dynamic> json) => Authmodel(
        phoneNumber: json["phone_number"],
        name: json["name"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "name": name,
        "password": password,
      };
}
