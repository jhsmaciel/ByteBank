import 'package:bytebanksqlite/database/app.dart';
import 'package:bytebanksqlite/model/Contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDAO {
  static const String tableCreate =
      "CREATE TABLE $_tableName ( id INTEGER PRIMARY KEY, name TEXT, account_number INTEGER)";
  static const String _tableName = "contacts";
  static const String _id = "id";
  static const String _name = "name";
  static const String _accountNumber = "account_number";

  Future<int> save(Contact contact) async {
    return (await getDatabase()).insert(_tableName, {
      _name: contact.fullName,
      _accountNumber: contact.accountNumber,
    });
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final result = await db.query(_tableName);
    return result
        .map((row) => Contact(row[_id], row[_name], row[_accountNumber]))
        .toList();
  }
}
