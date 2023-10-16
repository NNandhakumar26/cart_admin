// To parse this JSON data, do
//
//     final adminModel = adminModelFromJson(jsonString);

import 'dart:convert';

List<AdminModel> adminModelFromJson(String str) =>
    List<AdminModel>.from(json.decode(str).map((x) => AdminModel.fromJson(x)));

String adminModelToJson(List<AdminModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AdminModel {
  AdminModel({
    required this.defaultGst,
    required this.id,
    required this.email,
    required this.name,
    required this.emailVerified,
    required this.phoneNumber1,
    required this.phoneNumber2,
    required this.photoUrl,
    required this.address1,
    required this.address2,
    required this.openingTime,
    required this.closingTime,
    required this.gelocation,
    required this.active,
    required this.gallery,
    required this.updatedAt,
    required this.createdAt,
    required this.dcChennai,
    required this.dcOuterChennai,
  });

  final int defaultGst;
  final String id;
  final String email;
  final String name;
  final bool emailVerified;
  final String phoneNumber1;
  final String phoneNumber2;
  final String photoUrl;
  final String address1;
  final String address2;
  final dynamic openingTime;
  final dynamic closingTime;
  final String gelocation;
  final bool active;
  final List<String> gallery;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int dcChennai;
  final int dcOuterChennai;

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        defaultGst: json["defaultGst"],
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        emailVerified: json["emailVerified"],
        phoneNumber1: json["phoneNumber1"],
        phoneNumber2: json["phoneNumber2"],
        photoUrl: json["photoUrl"],
        address1: json["address1"],
        address2: json["address2"],
        openingTime: json["openingTime"] ?? '',
        closingTime: json["closingTime"] ?? '',
        gelocation: json["gelocation"],
        active: json["active"],
        gallery: List<String>.from(json["gallery"].map((x) => x)),
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        dcChennai: json["dcChennai"] ?? 0,
        dcOuterChennai: json["dcOuterChennai"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "defaultGst": defaultGst,
        "_id": id,
        "email": email,
        "name": name,
        "emailVerified": emailVerified,
        "phoneNumber1": phoneNumber1,
        "phoneNumber2": phoneNumber2,
        "photoUrl": photoUrl,
        "address1": address1,
        "address2": address2,
        "openingTime": openingTime,
        "closingTime": closingTime,
        "gelocation": gelocation,
        "active": active,
        "gallery": List<dynamic>.from(gallery.map((x) => x)),
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "dc_chennai": dcChennai,
        "dc_outerChennai": dcOuterChennai,
      };
}
