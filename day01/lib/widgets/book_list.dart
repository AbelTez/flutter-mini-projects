import 'package:flutter/material.dart';

import '../assets/colors/app_colors.dart' as app_colors;
import '../models/book.dart';
import 'book_card.dart';

class BookList extends StatelessWidget {
  const BookList({
    super.key,
    required this.books,
    this.emptyMessage = 'No books available right now.',
  });

  final List<Book> books;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.library_books_outlined,
                size: 48,
                color: app_colors.subTitleText,
              ),
              const SizedBox(height: 12),
              Text(
                emptyMessage,
                textAlign: TextAlign.center,
                style: TextStyle(color: app_colors.subTitleText, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
      physics: const BouncingScrollPhysics(),
      itemCount: books.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BookCard(book: books[index]),
        );
      },
    );
  }
}
