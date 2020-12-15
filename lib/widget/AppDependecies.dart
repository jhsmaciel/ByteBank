import 'package:bytebanksqlite/api/apis/TransactionApi.dart';
import 'package:bytebanksqlite/dao/ContactDAO.dart';
import 'package:flutter/material.dart';

class AppDependecies extends InheritedWidget {
  final ContactDAO contactDAO;
  final Widget child;
  final TransactionApi transactionApi;

  AppDependecies({
    @required this.contactDAO,
    @required this.transactionApi,
    @required this.child,
  }): super(child: child);

  static AppDependecies of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppDependecies>();
  }

  @override
  bool updateShouldNotify(AppDependecies oldWidget) {
    return contactDAO != oldWidget.contactDAO || transactionApi != oldWidget.transactionApi;
  }
}
