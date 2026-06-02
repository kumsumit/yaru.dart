import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadAppFonts();
  return testMain();
}

Future<void> loadAppFonts() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final fontManifest = await rootBundle.loadStructuredData<List<dynamic>>(
    'FontManifest.json',
    (data) async => jsonDecode(data) as List<dynamic>,
  );

  for (final font in fontManifest.cast<Map<String, dynamic>>()) {
    final loader = FontLoader(font['family'] as String);
    for (final fontType in (font['fonts'] as List<dynamic>).cast<Map>()) {
      loader.addFont(rootBundle.load(fontType['asset'] as String));
    }
    await loader.load();
  }
}
