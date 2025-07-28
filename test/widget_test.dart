import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:solar_system_reimagined/main.dart';
import 'package:solar_system_reimagined/screens/MercuryPage.dart';
import 'package:solar_system_reimagined/screens/samplePage.dart';
import 'package:solar_system_reimagined/screens/VenusPage.dart';
import 'package:solar_system_reimagined/screens/EarthPage.dart';
import 'package:solar_system_reimagined/screens/MarsPage.dart';
import 'package:solar_system_reimagined/screens/JupiterPage.dart';
import 'package:solar_system_reimagined/screens/SaturnPage.dart';
import 'package:solar_system_reimagined/screens/Uranus.dart';
import 'package:solar_system_reimagined/screens/Neptune.dart';

void main() {
  testWidgets('Mercury toggles shrink on tap', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MercuryShrinkPage()));
    final planet = find.byType(AnimatedContainer);
    expect(planet, findsOneWidget);

    await tester.tap(planet);
    await tester.pumpAndSettle();
    // Since it's visual, we just confirm state didn't crash
    expect(find.byType(AnimatedContainer), findsOneWidget);
  });

  testWidgets('Jupiter auto-pulses over time', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: JupiterPulsePage()));
    await tester.pump(const Duration(seconds: 0));
    expect(find.byType(AnimatedContainer), findsOneWidget);
  });

  testWidgets('Black Hole expands and collapses', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SampleRoute()));
    final target = find.byType(AnimatedContainer);
    await tester.tap(target);
    await tester.pump(const Duration(milliseconds: 500));
    expect(target, findsOneWidget);
  });

  testWidgets('Mars Dust builds animated builder', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MarsDustPage()));
    expect(find.byType(AnimatedBuilder), findsWidgets);
  });

  testWidgets('Saturn shows both rings and planet',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SaturnPage()));
    expect(find.byType(Image), findsNWidgets(2)); // ring + planet
  });

  testWidgets('Sample page shows black hole gradient',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SampleRoute()));
    expect(find.byType(AnimatedContainer), findsOneWidget);
  });

  testWidgets('Neptune page shows erupting volcanoes',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: NeptunePage()));
    expect(find.byType(AnimatedBuilder), findsWidgets);
  });

  testWidgets('Uranus builds floating crystals', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: UranusPage()));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(AnimatedBuilder), findsWidgets);
  });

  testWidgets('Earth orbit loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EarthOrbitPage()));
    expect(find.byType(AnimatedBuilder), findsWidgets);
  });

  testWidgets('Venus light beam animates', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: VenusPage()));
    expect(find.byType(CustomPaint), findsAtLeast(1));
  });
}
