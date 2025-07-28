import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:solar_system_reimagined/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App loads and shows home screen', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.text("Solar System Reimagined"), findsOneWidget);
  });

  testWidgets('Tap Mercury navigates and animates',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mercury'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Shrinking Mercury'), findsOneWidget);
  });

  testWidgets('Mars card is visible on scroll', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final pageFinder = find.text('Mars');
    await tester.scrollUntilVisible(pageFinder, 500.0);
    expect(pageFinder, findsOneWidget);
  });

  testWidgets('Black Hole card is visible on scroll',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final pageFinder = find.text('Black Hole');
    await tester.scrollUntilVisible(pageFinder, 500.0);
    expect(pageFinder, findsOneWidget);
  });

  testWidgets('Earth card is visible on scroll', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final pageFinder = find.text('Earth');
    await tester.scrollUntilVisible(pageFinder, 500.0);
    expect(pageFinder, findsOneWidget);
  });

  testWidgets('Jupiter card is visible on scroll', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final pageFinder = find.text('Jupiter');
    await tester.scrollUntilVisible(pageFinder, 500.0);
    expect(pageFinder, findsOneWidget);
  });

  testWidgets('Navigate to Black Hole and collapse works',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final blackHoleFinder = find.text('Black Hole');
    await tester.scrollUntilVisible(blackHoleFinder, 500.0);
    await tester.tap(blackHoleFinder);
    await tester.pumpAndSettle(); // ensure SampleRoute is loaded

    // black hole's AnimatedContainer is present
    final blackHole = find.byType(AnimatedContainer);
    expect(blackHole, findsOneWidget);

    await tester.tap(blackHole);
    await tester.pump(const Duration(milliseconds: 500));

    expect(blackHole, findsOneWidget);
  });

  testWidgets('Jupiter page exist only once', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final pageFinder = find.text('Jupiter');
    await tester.scrollUntilVisible(pageFinder, 500.0);
    expect(pageFinder, findsOneWidget);

    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 4));
  });
}
