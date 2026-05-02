import 'package:flutter/foundation.dart';

import 'book.dart';

@immutable
class HomeBooksData {
  const HomeBooksData({
    required this.popularBooks,
    required this.books,
  });

  final List<Book> popularBooks;
  final List<Book> books;
}