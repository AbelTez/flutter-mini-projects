import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon;
  final Color? color;
  final int categoryId;

  const Category({
    required this.name,
    required this.icon,
    this.color,
    required this.categoryId,
  });
}

/// Text style used by the category widgets.
const TextStyle categoryTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 12,
);

const TextStyle selectedCategoryTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 12,
  fontWeight: FontWeight.bold,
);

/// Sample categories used by the home page.
const List<Category> categories = [
  Category(name: 'All', icon: Icons.search, color: Colors.black, categoryId: 0),
  Category(
    name: 'Music',
    icon: Icons.music_note,
    color: Colors.purple,
    categoryId: 1,
  ),
  Category(
    name: 'Meetups',
    icon: Icons.event,
    color: Colors.redAccent,
    categoryId: 2,
  ),
  Category(
    name: 'Golf',
    icon: Icons.golf_course,
    color: Colors.green,
    categoryId: 3,
  ),
  Category(
    name: 'Food',
    icon: Icons.fastfood,
    color: Colors.orange,
    categoryId: 4,
  ),
];
