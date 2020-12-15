import 'package:bytebanksqlite/component/CardCustom.dart';
import 'package:bytebanksqlite/screen/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../matchers/index.dart';

void main() {
  testWidgets("Should render dashboard image", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Dashboard(),
    ));
    final dashBoardImage = find.byType(Image);
    expect(dashBoardImage, findsOneWidget);
  });

  testWidgets("Should render transfer card in first dashboard.",
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Dashboard(),
    ));
    final transferCardCustom =
        findCardWithLabelAndIcon("Transfer", Icons.attach_money);
    expect(transferCardCustom, findsOneWidget);
  });

  testWidgets("Should render transaction feed card.", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Dashboard(),
    ));
    final transactionFeedCardCustom =
        findCardWithLabelAndIcon("Transaction feed", Icons.description);
    expect(transactionFeedCardCustom, findsOneWidget);
  });
}
