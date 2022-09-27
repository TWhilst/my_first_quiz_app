import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CategoryModel{
  String? image;
  String? category;
  String? id;

  CategoryModel({this.image, this.category, this. id});

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "category": category,
      "id" : id,
    };
  }

  factory CategoryModel.fromJson(DocumentSnapshot snap) {
    return CategoryModel(
      image: snap["image"],
      id: snap["id"],
      category: snap["category"],
    );
  }
}