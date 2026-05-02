import 'package:flutter/foundation.dart';

@immutable
class Book {
  const Book({
    required this.rating,
    required this.title,
    required this.description,
    required this.imageAssetPath,
    required this.audioAssetPath,
  });

  final double rating;
  final String title;
  final String description;
  final String imageAssetPath;
  final String audioAssetPath;

  bool get hasImage => imageAssetPath.trim().isNotEmpty;

  String get displayTitle => title.trim().isEmpty ? 'Untitled book' : title;

  String get displayDescription =>
      description.trim().isEmpty ? 'No description available.' : description;

  String get displayRating => rating.toStringAsFixed(1);

  factory Book.fromJson(Map<String, dynamic> json) {
    final ratingValue = json['rating'];

    return Book(
      rating: ratingValue is num
          ? ratingValue.toDouble()
          : double.tryParse('$ratingValue') ?? 0,
      title: (json['title'] as String? ?? '').trim(),
      description: (json['text'] as String? ?? '').trim(),
      imageAssetPath: (json['img'] as String? ?? '').trim(),
      audioAssetPath: (json['audio'] as String? ?? '').trim(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'title': title,
      'text': description,
      'img': imageAssetPath,
      'audio': audioAssetPath,
    };
  }
}