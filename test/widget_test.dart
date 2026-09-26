// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:instagram_ui1/main.dart';

void main() {
  testWidgets('opens inbox and a conversation from the airplane button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.send_outlined));
    await tester.pumpAndSettle();
    expect(find.text('Pesan'), findsOneWidget);
    expect(find.text('sarah_dev'), findsOneWidget);

    await tester.tap(find.text('sarah_dev'));
    await tester.pumpAndSettle();
    expect(find.text('Aktif sekarang'), findsOneWidget);
    expect(find.text('Kirim pesan...'), findsOneWidget);
  });
}
