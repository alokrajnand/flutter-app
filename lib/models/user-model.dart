// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);

import 'dart:convert';

Usermodel usermodelFromJson(String str) => Usermodel.fromJson(json.decode(str));

String usermodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
    Usermodel({
        this.id,
        this.name,
        this.userDesignation,
        this.userTagLine,
        this.userTagLineDesc,
        this.userDateOfBirth,
        this.userProfilePicLink,
        this.userBannerPicLink,
        this.userAddressLandmark,
        this.userCity,
        this.userDistrict,
        this.userState,
        this.userCountry,
        this.userPincode,
        this.userTwitterLink,
        this.userGitHubLink,
        this.userLinkdinLink,
        this.userFaebookLink,
        this.userInstagramLink,
        this.createdDt,
        this.updatedDt,
        this.phoneNumber,
    });

    int id;
    String name;
    dynamic userDesignation;
    dynamic userTagLine;
    dynamic userTagLineDesc;
    dynamic userDateOfBirth;
    dynamic userProfilePicLink;
    dynamic userBannerPicLink;
    dynamic userAddressLandmark;
    String userCity;
    String userDistrict;
    String userState;
    String userCountry;
    int userPincode;
    dynamic userTwitterLink;
    dynamic userGitHubLink;
    dynamic userLinkdinLink;
    dynamic userFaebookLink;
    dynamic userInstagramLink;
    DateTime createdDt;
    DateTime updatedDt;
    String phoneNumber;

    factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
        id: json["id"],
        name: json["name"],
        userDesignation: json["user_designation"],
        userTagLine: json["user_tag_line"],
        userTagLineDesc: json["user_tag_line_desc"],
        userDateOfBirth: json["user_date_of_birth"],
        userProfilePicLink: json["user_profile_pic_link"],
        userBannerPicLink: json["user_banner_pic_link"],
        userAddressLandmark: json["user_address_landmark"],
        userCity: json["user_city"],
        userDistrict: json["user_district"],
        userState: json["user_state"],
        userCountry: json["user_country"],
        userPincode: json["user_pincode"],
        userTwitterLink: json["user_twitter_link"],
        userGitHubLink: json["user_git_hub_link"],
        userLinkdinLink: json["user_linkdin_link"],
        userFaebookLink: json["user_faebook_link"],
        userInstagramLink: json["user_instagram_link"],
        createdDt: DateTime.parse(json["created_dt"]),
        updatedDt: DateTime.parse(json["updated_dt"]),
        phoneNumber: json["phone_number"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "user_designation": userDesignation,
        "user_tag_line": userTagLine,
        "user_tag_line_desc": userTagLineDesc,
        "user_date_of_birth": userDateOfBirth,
        "user_profile_pic_link": userProfilePicLink,
        "user_banner_pic_link": userBannerPicLink,
        "user_address_landmark": userAddressLandmark,
        "user_city": userCity,
        "user_district": userDistrict,
        "user_state": userState,
        "user_country": userCountry,
        "user_pincode": userPincode,
        "user_twitter_link": userTwitterLink,
        "user_git_hub_link": userGitHubLink,
        "user_linkdin_link": userLinkdinLink,
        "user_faebook_link": userFaebookLink,
        "user_instagram_link": userInstagramLink,
        "created_dt": createdDt.toIso8601String(),
        "updated_dt": updatedDt.toIso8601String(),
        "phone_number": phoneNumber,
    };
}
