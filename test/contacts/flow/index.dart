import 'package:bytebanksqlite/main.dart';
import 'package:bytebanksqlite/model/Contact.dart';
import 'package:bytebanksqlite/screen/Contacts/Contacts.dart';
import 'package:bytebanksqlite/screen/Contacts/ContactsForm.dart';
import 'package:bytebanksqlite/screen/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/index.dart';
import '../../iterations/index.dart';
import '../../matchers/index.dart';

void main() {
  testWidgets("Should save a contact", (tester) async {
    final dao = MockContactDAO();
    await tester.pumpWidget(BytebankApp(contactDAO: dao,));

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);

    await clickCardOnDashboard(tester, "Transfer", Icons.attach_money);
    await tester.pumpAndSettle();

    final contactsList = find.byType(Contacts);
    expect(contactsList, findsOneWidget);

    final fabNewContact =
        find.widgetWithIcon(FloatingActionButton, Icons.add_circle_outline);
    expect(fabNewContact, findsOneWidget);

    verify(dao.findAll()).called(1);

    await tester.tap(fabNewContact);
    await tester.pumpAndSettle();

    final contactForm = find.byType(ContactsForm);
    expect(contactForm, findsOneWidget);

    final nameTextField = findInputEditByLabelValue("Full name");
    expect(nameTextField, findsOneWidget);
    await tester.enterText(nameTextField, "João Henrique");

    final accountTextField = findInputEditByLabelValue("Account number");
    expect(accountTextField, findsOneWidget);

    await tester.enterText(accountTextField, "1000");

    final createButton = find.widgetWithText(RaisedButton, "Create");
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();


    verify(dao.save(Contact(0, "João Henrique", 1000))).called(1);
    final contcsList = find.byType(Contacts);
    expect(contcsList , findsOneWidget);

//    verify(dao.findAll()).called(1);
  });
}
