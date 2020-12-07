import 'package:bytebanksqlite/api/apis/TransactionApi.dart';
import 'package:bytebanksqlite/component/CenteredMessage.dart';
import 'package:bytebanksqlite/component/Loading.dart';
import 'package:bytebanksqlite/model/Transaction.dart';
import 'package:bytebanksqlite/screen/Constants.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final TransactionApi _transactionApi = TransactionApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TransactionFeed),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _transactionApi.findAll(),
        initialData: [],
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Loading(
                textLoading: 'Find transact list...',
              );
            case ConnectionState.done:
              if (snapshot.hasError || snapshot.data.isEmpty) {
                return CenteredMessage(
                  snapshot.hasError  ? "Error :(" : "No transactions found",
                  icon: Icons.adb,
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Transaction transaction = snapshot.data[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.monetization_on),
                      title: Text(
                        transaction.value.toString(),
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        transaction.contact.fullName + "\n" +transaction.contact.accountNumber.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data.length,
              );
          }
          return CenteredMessage('Ops... Unknown error');
        },
      ),
    );
  }
}
