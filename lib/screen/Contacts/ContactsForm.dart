import 'package:bytebanksqlite/component/InputEdit.dart';
import 'package:bytebanksqlite/model/Contact.dart';
import 'package:bytebanksqlite/screen/Constants.dart';
import 'package:bytebanksqlite/widget/AppDependecies.dart';
import 'package:flutter/material.dart';

class ContactsForm extends StatelessWidget {
  final TextEditingController _controlFullname = TextEditingController();
  final TextEditingController _controlAccountNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dependecies = AppDependecies.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(TitleFormContacts),
      ),
      body: Column(
        children: [
          InputEdit(
            label: "Full name",
            keyboardType: TextInputType.text,
            placeholder: "João Henrique da Silva Maciel",
            controller: _controlFullname,
          ),
          InputEdit(
            label: "Account number",
            placeholder: "1000",
            controller: _controlAccountNumber,
            maxLength: 4,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.maxFinite,
              child: RaisedButton(
                onPressed: () async {
                  final String fullName = _controlFullname.text;
                  final int accountNumber =
                      int.tryParse(_controlAccountNumber.text);
                  if (fullName != null && accountNumber != null) {
                    final contact = Contact(0, fullName, accountNumber);
                    await dependecies.contactDAO.save(contact);
                    Navigator.pop(context);
                  }
                },
                child: Text("Create"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
