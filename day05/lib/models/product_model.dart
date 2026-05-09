// class FoodModel {
//   String? imageCard, imageDetail, name;
//   double? price, rates;
//   String? specialItems;
//   String? category;

//   FoodModel({
//     required this.imageCard,
//     required this.imageDetail,
//     required this.name,
//     required this.price,
//     required this.rates,
//     required this.specialItems,
//     required this.category,
//   });
//   List<FoodModel> foodList = [
//     FoodModel(
//       imageCard: "assets/images/burger_card.png",
//       imageDetail: "assets/images/burger_detail.png",
//       name: "Burger",
//       price: 5.99,
//       rates: 4.5,
//       specialItems: "Special",
//       category: "Burger",
//     ),
//     FoodModel(
//       imageCard: "assets/images/pizza_card.png",
//       imageDetail: "assets/images/pizza_detail.png",
//       name: "Pizza",
//       price: 8.99,
//       rates: 4.7,
//       specialItems: "Special",
//       category: "Pizza",
//     ),
//     FoodModel(
//       imageCard: "assets/images/cup_cake_card.png",
//       imageDetail: "assets/images/cup_cake_detail.png",
//       name: "Cup Cake",
//       price: 3.99,
//       rates: 4.3,
//       specialItems: "Special",
//       category: "Cup Cake",
//     ),
//     FoodModel(
//       imageCard: "assets/images/pasta_card.png",
//       imageDetail: "assets/images/pasta_detail.png",
//       name: "Pasta",
//       price: 6.99,
//       rates: 4.6,
//       specialItems: "Special",
//       category: "Pasta",
//     ),
//     FoodModel(
//       imageCard: "assets/images/dero_wett_card.png",
//       imageDetail: "assets/images/dero_wett_detail.png",
//       name: "Dero Wett",
//       price: 4.99,
//       rates: 4.4,
//       specialItems: "Special",
//       category: "Dero Wett",
//     ),
//   ];
// }

import 'package:flutter/material.dart';

var desc =
    "this is a special types of tiems, often served with cheese, lettuce,tomato,onion and pickles, and usually accompanied by fries and a soft drink. It is a popular fast food item that is enjoyed by people of all ages.";

//this is the model
//first lets upload the csv file to supabase and then we will fetch the data from supabase and display it in our app
class FoodModel {
  final String? imageCard;
  final String? imageDetail;
  final String? name;
  final String? id;
  final double? price;
  final double? rates;
  final String? specialItems;
  final String? category;
  final String? kcal;
  final String time;

  FoodModel({
    required this.imageCard,
    required this.imageDetail,
    required this.name,
    required this.price,
    required this.rates,
    required this.specialItems,
    required this.category,
    required this.kcal,
    required this.time,
    required this.id,
  });
  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      imageCard: json['image_card'],
      imageDetail: json['image_detail'],
      name: json['name'],
      price: json['price'] != null ? double.parse(json['price'].toString()) : null,
      rates: json['rates'] != null ? double.parse(json['rates'].toString()) : null,
      specialItems: json['special_items'],
      category: json['category'],
      kcal: json['kcal'],
      time: json['time'],
      id: json['id'].toString(),
    );
  }
}
