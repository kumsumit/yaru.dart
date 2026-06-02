import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaru/yaru.dart';

void main() {
  test('parses GTK window control layout', () {
    final layout = YaruWindowControlLayout.parseGTKSetting(
      'close:minimize,maximize,menu',
    );

    expect(layout.leftItems, [YaruWindowControlType.close]);
    expect(layout.rightItems, [
      YaruWindowControlType.minimize,
      YaruWindowControlType.maximize,
    ]);
  });

  testWidgets('right button layout filters enabled title bar controls', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: YaruTheme(
          data: YaruThemeData(rightButtonLayout: ['close']),
          child: Scaffold(
            appBar: YaruTitleBar(
              style: YaruTitleBarStyle.onlyRightWindowControls,
              isClosable: true,
              isMinimizable: true,
            ),
          ),
        ),
      ),
    );

    final control = tester.widget<YaruWindowControl>(
      find.byType(YaruWindowControl),
    );
    expect(control.type, YaruWindowControlType.close);
  });
}
