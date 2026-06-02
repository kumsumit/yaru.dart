import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru/yaru.dart';

void main() {
  testWidgets('day picker stays within its date range', (tester) async {
    DateTime? selectedDay;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: YaruDayPicker(
            initialDate: DateTime(2026, 1, 15),
            firstDate: DateTime(2026, 1, 10),
            lastDate: DateTime(2026, 2, 20),
            onDaySelected: (day) => selectedDay = day,
          ),
        ),
      ),
    );

    expect(find.text('Jan 2026'), findsOneWidget);

    await tester.tap(find.byTooltip('Previous month'));
    await tester.pump();
    expect(find.text('Jan 2026'), findsOneWidget);

    await tester.tap(find.byTooltip('Next month'));
    await tester.pump();
    expect(find.text('Feb 2026'), findsOneWidget);

    await tester.tap(find.text('25').last);
    await tester.pump();
    expect(selectedDay, isNull);

    await tester.tap(find.text('20').last);
    await tester.pump();
    expect(selectedDay, DateTime(2026, 2, 20));
  });
}
