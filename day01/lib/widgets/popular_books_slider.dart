import 'package:flutter/material.dart';

import '../assets/colors/app_colors.dart' as app_colors;
import '../models/book.dart';

class PopularBooksSlider extends StatefulWidget {
  const PopularBooksSlider({super.key, required this.books});

  final List<Book> books;

  @override
  State<PopularBooksSlider> createState() => _PopularBooksSliderState();
}

class _PopularBooksSliderState extends State<PopularBooksSlider> {
  static const double _viewportFraction = 0.9;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: _viewportFraction);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.books.isEmpty) {
      return const SizedBox(height: 180, child: _EmptySliderState());
    }

    return SizedBox(
      height: 180,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.books.length,
        itemBuilder: (_, index) {
          return _PopularBookCover(book: widget.books[index]);
        },
      ),
    );
  }
}

class _PopularBookCover extends StatelessWidget {
  const _PopularBookCover({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: app_colors.audioGreyBackground,
            borderRadius: BorderRadius.circular(15),
          ),
          child: _buildCover(),
        ),
      ),
    );
  }

  Widget _buildCover() {
    if (!book.hasImage) {
      return const _EmptySliderState();
    }

    return Image.asset(
      book.imageAssetPath,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (_, __, ___) => const _EmptySliderState(),
    );
  }
}

class _EmptySliderState extends StatelessWidget {
  const _EmptySliderState();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: app_colors.audioGreyBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 36,
          color: Colors.black45,
        ),
      ),
    );
  }
}
