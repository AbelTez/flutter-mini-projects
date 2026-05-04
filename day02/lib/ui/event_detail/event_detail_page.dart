import 'package:day02/model/event.dart';
import 'package:day02/ui/event_detail/event_detail_background.dart';
import 'package:day02/ui/event_detail/event_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;
  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider<Event>.value(
        value: event,
        child: Stack(
          children: [
            EventDetailBackground(),
            EventDetailContent()
          ],
        ),
      ),
    );
  }
}
