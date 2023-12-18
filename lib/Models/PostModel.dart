// To parse this JSON data, do
//
//     final getFirstModel = getFirstModelFromJson(jsonString);

import 'dart:convert';

List<GetFirstModel> getFirstModelFromJson(String str) => List<GetFirstModel>.from(json.decode(str).map((x) => GetFirstModel.fromJson(x)));

String getFirstModelToJson(List<GetFirstModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetFirstModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  GetFirstModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory GetFirstModel.fromJson(Map<String, dynamic> json) => GetFirstModel(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id,
    "title": title,
    "body": body,
  };
}
