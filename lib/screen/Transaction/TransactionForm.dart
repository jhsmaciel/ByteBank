import 'package:bytebanksqlite/api/apis/TransactionApi.dart';
import 'package:bytebanksqlite/component/InputEdit.dart';
import 'package:bytebanksqlite/component/Loading.dart';
import 'package:bytebanksqlite/component/ResponseDialog.dart';
import 'package:bytebanksqlite/component/TransactionAuthDialog.dart';
import 'package:bytebanksqlite/model/Contact.dart';
import 'package:bytebanksqlite/model/Transaction.dart';
import 'package:bytebanksqlite/screen/Constants.dart';
import 'package:bytebanksqlite/widget/AppDependecies.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = Uuid().v4();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final dependecies = AppDependecies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(TitleTransactionForm),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Loading(
                  textLoading: "Carregando",
                ),
                visible: _loading,
              ),
              Text(
                widget.contact.fullName,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              InputEdit(
                label: "Value",
                placeholder: "100.22",
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: _valueController,
                padding: 0.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated =
                          Transaction(transactionId, value, widget.contact);
                      save(dependecies.transactionApi, transactionCreated, context);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void save(TransactionApi transactionApi, Transaction transaction, BuildContext context) async {
    showDialog(
      context: context,
      builder: (c) {
        return TransactionAuthDialog(
          onConfirm: (String password) async {
            try {
              setState(() {
                _loading = true;
              });
              final resTransact =
                  await transactionApi.save(transaction, password);
              if (resTransact != null) {
                await showDialog(
                  context: context,
                  builder: (contextDialog) {
                    return SuccessDialog('Successfull transaction');
                  },
                );
                Navigator.pop(context);
              }
            } on Exception catch (e) {
              showDialog(
                context: context,
                builder: (contextDialog) {
                  return FailureDialog(e.toString());
                },
              );
            } finally {
              setState(() {
                _loading = false;
              });
            }
          },
        );
      },
    );
  }
}
