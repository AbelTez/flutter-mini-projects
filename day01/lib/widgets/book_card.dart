import 'package:flutter/material.dart';

import '../assets/colors/app_colors.dart' as app_colors;
import '../models/book.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    this.backgroundColor = app_colors.tabVarViewColor,
  });

  final Book book;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BookCoverImage(book: book),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: app_colors.starColor, size: 24),
                      const SizedBox(width: 10),
                      Text(
                        book.displayRating,
                        style: TextStyle(
                          color: app_colors.menu2Color,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    book.displayTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    book.displayDescription,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: app_colors.subTitleText,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 60,
                    height: 15,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: app_colors.loveColor,
                    ),
                    child: const Text(
                      'Love',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Avenir',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookCoverImage extends StatelessWidget {
  const _BookCoverImage({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(width: 90, height: 120, child: _buildCover()),
    );
  }

  Widget _buildCover() {
    if (!book.hasImage) {
      return const _MissingImagePlaceholder();
    }

    return Image.asset(
      book.imageAssetPath,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const _MissingImagePlaceholder(),
    );
  }
}

class _MissingImagePlaceholder extends StatelessWidget {
  const _MissingImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: app_colors.audioGreyBackground,
      alignment: Alignment.center,
      child: const Icon(
        Icons.menu_book_outlined,
        color: Colors.black45,
        size: 32,
      ),
    );
  }
}
