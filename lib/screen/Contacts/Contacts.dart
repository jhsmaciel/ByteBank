import 'package:bytebanksqlite/component/Loading.dart';
import 'package:bytebanksqlite/dao/ContactDAO.dart';
import 'package:bytebanksqlite/model/Contact.dart';
import 'package:bytebanksqlite/screen/Constants.dart';
import 'package:bytebanksqlite/screen/Contacts/ContactsForm.dart';
import 'package:bytebanksqlite/screen/Transaction/TransactionForm.dart';
import 'package:bytebanksqlite/widget/AppDependecies.dart';
import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    final dependecies = AppDependecies.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Transfer),
      ),
      body: FutureBuilder<List<Contact>>(
        future: dependecies.contactDAO.findAll(),
        initialData: [],
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Loading(
                textLoading: 'Loading...',
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return ContactItem(
                    contact: contact,
                    onClick: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TransactionForm(contact),
                      ));
                    },
                  );
                },
                itemCount: contacts.length,
              );
          }
          return Center(child: Text("Ops, unknown error."));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactsForm(),
            ),
          );
        },
        child: Icon(Icons.add_circle_outline),
        tooltip: 'Add',
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  const ContactItem({
    Key key,
    this.contact,
    @required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contact.fullName,
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
