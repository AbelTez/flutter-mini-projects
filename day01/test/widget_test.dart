//import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tutor3/main.dart';

void main() {
  testWidgets('home page loads book content', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Popular Books'), findsOneWidget);
    expect(find.text('new'), findsOneWidget);
    expect(find.text('trending'), findsOneWidget);
    expect(find.text('best seller'), findsOneWidget);
  });
}
