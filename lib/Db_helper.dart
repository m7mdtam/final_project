// ignore_for_file: file_names

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), "phoneBook.db"),
      version: 1,
      onCreate: (db, version) {
        db.execute("""CREATE TABLE IF NOT EXISTS users(
id TEXT PRIMARY KEY AUTOINCREMENT
)""");
      },
    );
  }
}
