import 'package:bytebanksqlite/component/CardCustom.dart';
import 'package:bytebanksqlite/screen/Constants.dart';
import 'package:bytebanksqlite/screen/Contacts/Contacts.dart';
import 'package:bytebanksqlite/screen/Transaction/TransactionList.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TitleDashboard),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CardCustom(
                  icon: Icons.attach_money,
                  label: Transfer,
                  route: Contacts(),
                ),
                CardCustom(
                  icon: Icons.description,
                  label: TransactionFeed,
                  route: TransactionsList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
