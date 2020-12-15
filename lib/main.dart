import 'package:bytebanksqlite/screen/Dashboard.dart';
import 'package:bytebanksqlite/theme/themes.dart';
import 'package:bytebanksqlite/widget/AppDependecies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api/apis/TransactionApi.dart';
import 'dao/ContactDAO.dart';

void main() {
  runApp(BytebankApp(
    transactionApi: TransactionApi(),
    contactDAO: ContactDAO(),
  ));
}

class BytebankApp extends StatelessWidget {
  final ContactDAO contactDAO;
  final TransactionApi transactionApi;

  const BytebankApp(
      {Key key, @required this.contactDAO, @required this.transactionApi})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDependecies(
      transactionApi: transactionApi,
      contactDAO: contactDAO,
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: darkTheme,
        home: Dashboard(),
      ),
    );
  }
}
