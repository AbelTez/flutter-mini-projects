import 'package:flutter/material.dart';

import 'assets/colors/app_colors.dart' as app_colors;
import 'models/book.dart';
import 'models/home_books_data.dart';
import 'my_tabs.dart';
import 'services/book_service.dart';
import 'widgets/book_list.dart';
import 'widgets/popular_books_slider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  static final List<_TabConfig> _tabs = [
    _TabConfig(label: 'new', color: app_colors.menu1Color),
    _TabConfig(label: 'trending', color: app_colors.menu2Color),
    _TabConfig(label: 'best seller', color: app_colors.menu3Color),
  ];

  final BookService _bookService = BookService();
  late final TabController _tabController;
  late Future<HomeBooksData> _homeBooksFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _homeBooksFuture = _bookService.loadHomeBooks();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _reloadData() {
    if (!mounted) {
      return;
    }

    setState(() {
      _homeBooksFuture = _bookService.loadHomeBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: app_colors.background,
      child: SafeArea(
        child: Scaffold(
          body: FutureBuilder<HomeBooksData>(
            future: _homeBooksFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return _ErrorState(
                  message: snapshot.error.toString(),
                  onRetry: _reloadData,
                );
              }

              final data = snapshot.data;
              if (data == null) {
                return _ErrorState(
                  message: 'No book data could be loaded.',
                  onRetry: _reloadData,
                );
              }

              return _HomeContent(
                tabController: _tabController,
                tabs: _tabs,
                popularBooks: data.popularBooks,
                books: data.books,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.tabController,
    required this.tabs,
    required this.popularBooks,
    required this.books,
  });

  final TabController tabController;
  final List<_TabConfig> tabs;
  final List<Book> popularBooks;
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _TopBar(),
        const _SectionHeader(title: 'Popular Books'),
        const SizedBox(height: 20),
        PopularBooksSlider(books: popularBooks),
        Expanded(
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool isScrollingDown) {
              return [
                SliverAppBar(
                  pinned: true,
                  backgroundColor: app_colors.silverBackground,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(30),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20, left: 1),
                      child: TabBar(
                        indicatorPadding: EdgeInsets.zero,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelPadding: const EdgeInsets.only(right: 10),
                        controller: tabController,
                        isScrollable: true,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 7,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        tabs: tabs
                            .map(
                              (tab) =>
                                  AppTabs(color: tab.color, text: tab.label),
                            )
                            .toList(growable: false),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: tabController,
              children: tabs
                  .map((_) => BookList(books: books))
                  .toList(growable: false),
            ),
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageIcon(
            AssetImage('lib/assets/icons/menu-60.png'),
            size: 24,
            color: Colors.black,
          ),
          Row(
            children: [
              Icon(Icons.search),
              SizedBox(width: 20),
              Icon(Icons.notifications),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      width: double.infinity,
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.black54),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: app_colors.subTitleText, fontSize: 14),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}

class _TabConfig {
  _TabConfig({required this.label, required this.color});

  final String label;
  final Color color;
}
