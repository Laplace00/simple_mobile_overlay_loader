import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:simple_mobile_overlay_loader/simple_mobile_overlay_loader.dart';

void main() {
  testWidgets('Loader overlay appears and disappears', (
    WidgetTester tester,
  ) async {
    // Build a simple app with a button to show the loader
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  final loader = showLoaderOverlay(
                    context,
                    message: 'Loading…',
                  );
                  Future.delayed(const Duration(seconds: 1), () {
                    if (loader.mounted) loader.remove();
                  });
                },
                child: const Text('Show Loader'),
              );
            },
          ),
        ),
      ),
    );

    // Tap the button to show the loader
    await tester.tap(find.text('Show Loader'));
    await tester.pump(); // Start the animation

    // Verify that the loader overlay is shown
    expect(find.text('Loading…'), findsOneWidget);

    // Wait for the loader to be removed
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // Verify that the loader overlay is removed
    expect(find.text('Loading…'), findsNothing);
  });
}
