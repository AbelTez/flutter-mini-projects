import 'package:flutter/material.dart';

// class Category {
//   String? name, imageUrl;

//   Category({required this.name, required this.imageUrl});
// }

// List<Category> categories = [
//   Category(name: "Burger", imageUrl: "assets/images/burger.png"),
//   Category(name: "Pizza", imageUrl: "assets/images/pizza.png"),
//   Category(name: "Cup Cake", imageUrl: "assets/images/cup_cake.png"),
//   Category(name: "Pasta", imageUrl: "assets/images/pasta.png"),
//   Category(name: "Dero Wett", imageUrl: "assets/images/dero_wett.png"),
// ];
// // this is our category model where we have fetch data from supabase


class CategoryModel {
  String? name, imageUrl;

  CategoryModel({required this.name, required this.imageUrl});
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }
}