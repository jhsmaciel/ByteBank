import 'package:bytebanksqlite/component/CardCustom.dart';
import 'package:bytebanksqlite/component/InputEdit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Finder findCardWithLabelAndIcon(String label, IconData icon) {
  return find.byWidgetPredicate((widget) =>
      widget is CardCustom && widget.icon == icon && widget.label == label);
}

Finder findInputEditByLabelValue(String value) {
  return find.byWidgetPredicate((widget) => widget is InputEdit && widget.label == value);
}

void expectOne(Finder f) {
  expect(f, findsOneWidget);
}