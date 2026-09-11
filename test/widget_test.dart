import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crypto_dashboard/main.dart';

void main() {
  testWidgets('Crypto Dashboard app smoke test', (WidgetTester tester) async {
    // Build our app and trigger an initial frame.
    await tester.pumpWidget(const MyApp());

    // Verify that MaterialApp is present with correct title
    final materialAppFinder = find.byType(MaterialApp);
    expect(materialAppFinder, findsOneWidget);

    final MaterialApp app = tester.widget(materialAppFinder);
    expect(app.title, 'Crypto Dashboard');
  });
}
