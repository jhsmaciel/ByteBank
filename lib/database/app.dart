import 'package:bytebanksqlite/dao/ContactDAO.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  return openDatabase(join(dbPath, 'bytebank.db'),
    onCreate: (db, version) {
      db.execute(ContactDAO.tableCreate);
    },
    version: 1
  );
}

