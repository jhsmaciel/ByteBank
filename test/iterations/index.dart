import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/index.dart';

clickCardOnDashboard(WidgetTester tester, String label, IconData icon) async {
  final transferCardCustom = findCardWithLabelAndIcon(label, icon);
  expect(transferCardCustom, findsOneWidget);
  await tester.tap(transferCardCustom);
}
