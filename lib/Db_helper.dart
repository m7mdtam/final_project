import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), 'translator1.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE IF NOT EXISTS words(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                english TEXT,
                turkish TEXT
              )''',
        );
        await db.execute(
          '''CREATE TABLE IF NOT EXISTS history(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                h_english TEXT,
                h_turkish TEXT
              )''',
        );
        await db.execute(
          '''CREATE TABLE IF NOT EXISTS favorite(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                f_english TEXT,
                f_turkish TEXT
              )''',
        );
        await _insertInitialData(db);
      },
    );
  }

  static Future<void> insertFavorite(String english, String turkish) async {
    final Database database = await db();
    await database.insert(
      'favorite',
      {
        'f_english': english,
        'f_turkish': turkish,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteFavorite(int id) async {
    final Database database = await db();
    await database.delete(
      'favorite',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>> fetchFavorites() async {
    final Database database = await db();
    return database.query('favorite');
  }

  static Future<void> insertWord(String english, String turkish) async {
    final Database database = await db();
    await database.insert(
      'words',
      {
        'english': english,
        'turkish': turkish,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> insertHistory(String english, String turkish) async {
    final Database database = await db();
    await database.insert(
      'history',
      {
        'h_english': english,
        'h_turkish': turkish,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> fetchHistory() async {
    final Database database = await db();
    return database.query('history');
  }

  static Future<void> deleteHistory(int id) async {
    final Database database = await db();
    await database.delete(
      'history',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> _insertInitialData(Database db) async {
    await db.insert('words', {
      'english': 'Hello',
      'turkish': 'Merhaba',
    });
    await db.insert('words', {
      'english': 'Goodbye',
      'turkish': 'Güle güle',
    });
    await db.insert('words', {
      'english': 'Please',
      'turkish': 'Lütfen',
    });
    await db.insert('words', {
      'english': 'Thank you',
      'turkish': 'Teşekkür ederim',
    });
  }

  static Future<Map<String, dynamic>?> getTranslation(String english) async {
    final Database database = await db();
    final List<Map<String, dynamic>> results = await database.query(
      'words',
      where: 'LOWER(english) = ?',
      whereArgs: [english.toLowerCase()],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  static Future<void> deleteWord(int id) async {
    final Database database = await db();
    await database.delete(
      'words',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
