import 'package:bytebanksqlite/component/ResponseDialog.dart';
import 'package:bytebanksqlite/component/TransactionAuthDialog.dart';
import 'package:bytebanksqlite/main.dart';
import 'package:bytebanksqlite/model/Contact.dart';
import 'package:bytebanksqlite/model/Transaction.dart';
import 'package:bytebanksqlite/screen/Contacts/Contacts.dart';
import 'package:bytebanksqlite/screen/Dashboard.dart';
import 'package:bytebanksqlite/screen/Transaction/TransactionForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../iterations/index.dart';
import '../../matchers/index.dart';
import '../../mocks/index.dart';

void main() {
  testWidgets("Should transfer to a contact", (tester) async {
    await tester.runAsync(() async {
      final mockContactDao = MockContactDAO();
      final mockTransactionApi = MockTransactionApi();
      final cName = "João Henrique";
      final cAccountNumber = 1000;
      final password = "1000";

      final contactTest = Contact(0, cName, cAccountNumber);
      await tester.pumpWidget(BytebankApp(
        contactDAO: mockContactDao,
        transactionApi: mockTransactionApi,
      ));

      final dashboard = find.byType(Dashboard);
      expectOne(dashboard);

      when(mockContactDao.findAll()).thenAnswer((realInvocation) async {
        return [contactTest];
      });

      await clickCardOnDashboard(tester, "Transfer", Icons.attach_money);
      await tester.pumpAndSettle();

      final contactsList = find.byType(Contacts);
      expectOne(contactsList);

      verify(mockContactDao.findAll()).called(1);

      final contactItem = find.byWidgetPredicate((widget) =>
          widget is ContactItem &&
          widget.contact.fullName == cName &&
          widget.contact.accountNumber == cAccountNumber);
      expectOne(contactItem);

      await tester.tap(contactItem);
      await tester.pumpAndSettle();

      final transactionForm = find.byType(TransactionForm);
      expectOne(transactionForm);

      final contactName = find.text(cName);
      expectOne(contactName);

      final contactAccountNumber = find.text(cAccountNumber.toString());
      expectOne(contactAccountNumber);

      final inputEdit = findInputEditByLabelValue("Value");
      expectOne(inputEdit);
      await tester.enterText(inputEdit, "200");

      final transferButton = find.widgetWithText(RaisedButton, "Transfer");
      expectOne(transferButton);
      await tester.tap(transferButton);
      await tester.pumpAndSettle();

      final transaction = Transaction(null, 200, contactTest);
      when(mockTransactionApi.save(transaction, password))
          .thenAnswer((_) async => transaction);

      final transactionAuthDialog = find.byType(TransactionAuthDialog);
      expectOne(transactionAuthDialog);

      final inputPassword = find.byKey(TransactionAuthDialogKey);
      expectOne(inputPassword);
      await tester.enterText(inputPassword, password);

      final cancelButton = find.widgetWithText(FlatButton, "Cancel");
      expectOne(cancelButton);

      final confirmButton = find.widgetWithText(FlatButton, "Confirm");

      expectOne(confirmButton);

      await tester.tap(confirmButton);
      await tester.pumpAndSettle();


      final successDialog = find.byType(SuccessDialog);
      expectOne(successDialog);

      final okButton = find.widgetWithText(FlatButton, "Ok");
      expectOne(okButton);

      await tester.tap(okButton);
      await tester.pumpAndSettle();
      final contactsListBack = find.byType(Contacts);
      expectOne(contactsListBack);
    });
  });
}
