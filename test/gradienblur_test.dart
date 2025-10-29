import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Correctly import your package's main file
import 'package:gradient_blur/gradient_blur.dart';

void main() {
  // We use `testWidgets` for testing widgets, not the basic `test`.
  testWidgets('GradienBlur builds correctly and contains its child', (WidgetTester tester) async {
    // Define a simple child widget to test with.
    const String testText = 'Hello World';

    // 1. Build our widget.
    // `pumpWidget` tells the test environment to build and render a widget tree.
    await tester.pumpWidget(
      const MaterialApp( // MaterialApp provides a standard app environment (theming, directionality).
        home: Scaffold(
          body: GradientBlur(
            maxBlur: 10.0,
            child: Text(testText),
          ),
        ),
      ),
    );

    // 2. Create "Finders" to locate widgets in the tree.
    final blurFinder = find.byType(GradientBlur);
    final textFinder = find.text(testText);

    // 3. Use `expect` to verify that the widgets exist.
    // `findsOneWidget` is a "Matcher" that confirms exactly one widget was found.

    // Verify that our GradienBlur widget is on the screen.
    expect(blurFinder, findsOneWidget);

    // Verify that the child Text widget is also on the screen.
    expect(textFinder, findsOneWidget);
  });
}