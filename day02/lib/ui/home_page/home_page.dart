import 'package:day02/app_state.dart';
import 'package:day02/model/event.dart';
import 'package:day02/ui/event_detail/event_detail_page.dart';
import 'package:day02/ui/home_page/event_widget.dart';
import 'package:flutter/material.dart';
import 'package:day02/ui/home_page/home_page_background.dart';
import 'package:day02/ui/home_page/category_widget.dart';
import 'package:day02/model/category.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => AppState(),
        child: Stack(
          children: <Widget>[
            HomePageBackground(
              screenHeight: MediaQuery.of(context).size.height,
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        children: [
                          Text(
                            "LOCAL EVENTS",
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                          ),
                          Spacer(),
                          Icon(
                            Icons.person_outline,
                            color: Color(0x99ffffff),
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        "What's Up",
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 22.0,
                        horizontal: 10.0,
                      ),
                      child: Consumer<AppState>(
                        builder: (context, appState, _) =>
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (final category in categories)
                                    CategoryWidget(category: category),
                                ],
                              ),
                            ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 10.0,
                        ),
                        child: Consumer<AppState>(
                          builder: (context, appState, _) => Column(
                            children: [
                              for (final event in events.where(
                                (e) => e.categoryIds.contains(
                                  appState.selectedCategoryId,
                                ),
                              ))
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EventDetailPage(event: event),
                                      ),
                                    );
                                  },
                                  child: EventWidget(event: event),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
