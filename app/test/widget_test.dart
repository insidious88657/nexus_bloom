// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nexus_bloom/main.dart';

void main() {
  testWidgets('Shows home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: NexusBloomApp()));
    // Pump initial frame
    await tester.pump();
    // Should show either loading indicator or the profile name after async load
    expect(
      find.byType(CircularProgressIndicator).evaluate().isNotEmpty ||
          find.text('Unnamed Bloom').evaluate().isNotEmpty,
      isTrue,
    );
  });
}
