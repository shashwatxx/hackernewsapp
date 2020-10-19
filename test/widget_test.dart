import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hackernewsapp/main.dart';

void main() {
  testWidgets('Click tiles open it', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    expect(find.byIcon(Icons.launch), findsNothing);
    await tester.tap(find.byType(ExpansionTile).first);
    await tester.pump();

    expect(find.byIcon(Icons.launch), findsOneWidget);
  }, skip: true);
}
