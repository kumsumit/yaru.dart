import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru/yaru.dart';

import '../yaru_golden_tester.dart';

void main() {
  testWidgets('list tile has its own transparent material', (tester) async {
    await tester.pumpScaffold(
      const YaruMasterTile(selected: true, title: Text('title')),
    );

    Material? material;
    tester.element(find.byType(ListTile)).visitAncestorElements((element) {
      if (element.widget case final Material widget) {
        material = widget;
        return false;
      }
      return true;
    });

    expect(material?.color, Colors.transparent);
  });
}
