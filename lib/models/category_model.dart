// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

CategoryModel? categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel? data) => json.encode(data!.toJson());

class CategoryModel {
  CategoryModel({
    this.id,
    this.categoryName,
    this.status,
    this.imageUrl,
  });

  String? id;
  String? categoryName;
  String? status;
  String? imageUrl;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    categoryName: json["categoryName"],
    status: json["status"],
    imageUrl: json["imageUrl"],
  );

  factory CategoryModel.fromFirebaseSnapshot(DocumentSnapshot<Map<String, dynamic>>? snapshot) {
    final data = snapshot?.data();
    if (data == null) return CategoryModel(); // Return an empty CategoryModel if the data is null or if the snapshot is null.

    return CategoryModel(
      id: snapshot?.id,
      categoryName: data["categoryName"],
      status: data["status"],
      imageUrl: data["imageUrl"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryName": categoryName,
    "status": status,
    "imageUrl": imageUrl,
  };
}