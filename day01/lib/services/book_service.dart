import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/book.dart';
import '../models/home_books_data.dart';

class BookService {
  static const String popularBooksAssetPath =
      'lib/assets/json/popularBooks.json';
  static const String booksAssetPath = 'lib/assets/json/books.json';

  Future<HomeBooksData> loadHomeBooks() async {
    final results = await Future.wait<List<Book>>([
      loadBooks(popularBooksAssetPath),
      loadBooks(booksAssetPath),
    ]);

    return HomeBooksData(popularBooks: results[0], books: results[1]);
  }

  Future<List<Book>> loadBooks(String assetPath) async {
    final trimmedPath = assetPath.trim();
    if (trimmedPath.isEmpty) {
      throw ArgumentError.value(assetPath, 'assetPath', 'Cannot be empty');
    }

    try {
      final jsonString = await rootBundle.loadString(trimmedPath);
      final decoded = json.decode(jsonString);

      if (decoded is! List) {
        throw const FormatException('Expected a JSON array of books.');
      }

      final books = <Book>[];
      for (final item in decoded) {
        if (item is! Map) {
          throw const FormatException('Each book entry must be a JSON object.');
        }

        books.add(Book.fromJson(Map<String, dynamic>.from(item)));
      }

      return List.unmodifiable(books);
    } on FlutterError catch (error) {
      throw BookDataException('Unable to load $trimmedPath: ${error.message}');
    } on FormatException catch (error) {
      throw BookDataException('Invalid book data in $trimmedPath: $error');
    } catch (error) {
      throw BookDataException('Failed to load $trimmedPath: $error');
    }
  }
}

class BookDataException implements Exception {
  const BookDataException(this.message);

  final String message;

  @override
  String toString() => message;
}
