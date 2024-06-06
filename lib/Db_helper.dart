import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  // Open the database and store the reference.
  static Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), 'translator.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE IF NOT EXISTS words(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                english TEXT,
                turkish TEXT,
              )''',
        );
        await _insertInitialData(db);
      },
    );
  }

  // Insert a new word into the database.
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

  // Insert initial data into the database.
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
    // Add more initial data as needed
  }

  // Fetch the Turkish translation and image for a given English word.
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

  static Future<void> updateWord(
    int id,
    String english,
    String turkish,
  ) async {
    final Database database = await db();

    await database.update(
      'words',
      {
        'english': english,
        'turkish': turkish,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
