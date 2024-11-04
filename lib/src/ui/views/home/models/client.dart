// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
  int id;
  String firstname;
  String lastname;
  String email;
  String? address;
  String? photo;
  dynamic caption;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;

  Client({
    this.id = 0,
    required this.firstname,
    required this.lastname,
    required this.email,
    this.address,
    this.photo,
    this.caption,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.userId = 0,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Client copyWith({
    int? id,
    String? firstname,
    String? lastname,
    String? email,
    String? address,
    dynamic photo,
    dynamic caption,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? userId,
  }) =>
      Client(
        id: id ?? this.id,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        address: address ?? this.address,
        photo: photo ?? this.photo,
        caption: caption ?? this.caption,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
      );

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        firstname: json["firstname"] ?? '',
        lastname: json["lastname"] ?? '',
        email: json["email"] ?? '',
        address: json["address"],
        photo: json["photo"],
        caption: json["caption"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"] ?? 0,
      );

  Map<String, String> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
       // if(photo!=null) "photo": photo! ,
         if(address!=null) "address": address! ,
         
      };
}
