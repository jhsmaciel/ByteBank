import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;
  const TransactionAuthDialog({
    Key key,
    @required this.onConfirm,
  }) : super(key: key);

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        maxLength: 4,
        obscureText: true,
        textAlign: TextAlign.center,
        decoration: InputDecoration(border: OutlineInputBorder()),
        style: TextStyle(letterSpacing: 32),
        keyboardType: TextInputType.number,
        controller: _password,
      ),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancelar")),
        FlatButton(
            onPressed: () {
              widget.onConfirm(_password.text);
              Navigator.pop(context);
            },
            child: Text("Confirm")),
      ],
    );
  }
}
