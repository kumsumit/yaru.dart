import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru/yaru.dart';

void main() {
  testWidgets('uses the input decoration theme fill color', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            fillColor: Colors.red,
          ),
        ),
        home: const Scaffold(body: YaruSearchField(autofocus: false)),
      ),
    );

    expect(
      tester.widget<TextField>(find.byType(TextField)).decoration!.fillColor,
      Colors.red,
    );
  });

  testWidgets('keeps a border in high contrast mode', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: yaruHighContrastLight,
        home: const Scaffold(body: YaruSearchField(autofocus: false)),
      ),
    );

    final decoration = tester
        .widget<TextField>(find.byType(TextField))
        .decoration!;
    expect(decoration.enabledBorder, isA<OutlineInputBorder>());
    expect(
      (decoration.enabledBorder! as OutlineInputBorder).borderSide,
      isNot(BorderSide.none),
    );
  });

  testWidgets('listens to a replacement controller', (tester) async {
    final firstController = TextEditingController();
    final secondController = TextEditingController(text: 'query');
    addTearDown(firstController.dispose);
    addTearDown(secondController.dispose);

    Widget build(TextEditingController controller) => MaterialApp(
      home: Scaffold(
        body: YaruSearchField(
          autofocus: false,
          controller: controller,
          onClear: () {},
        ),
      ),
    );

    await tester.pumpWidget(build(firstController));
    expect(find.byType(IconButton), findsNothing);

    await tester.pumpWidget(build(secondController));
    expect(find.byType(IconButton), findsOneWidget);

    secondController.clear();
    await tester.pump();
    expect(find.byType(IconButton), findsNothing);
  });

  testWidgets('accepts decoration overrides', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: YaruSearchField(
            autofocus: false,
            decoration: InputDecoration(hintText: 'Custom hint'),
          ),
        ),
      ),
    );

    expect(find.text('Custom hint'), findsOneWidget);
  });
}
