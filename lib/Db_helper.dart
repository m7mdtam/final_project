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
                image TEXT
              )''',
        );
        await _insertInitialData(db);
      },
    );
  }

  // Insert a new word into the database.
  static Future<void> insertWord(
      String english, String turkish, String image) async {
    final Database database = await db();

    await database.insert(
      'words',
      {
        'english': english,
        'turkish': turkish,
        'image': image,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Insert initial data into the database.
  static Future<void> _insertInitialData(Database db) async {
    await db.insert('words', {
      'english': 'Hello',
      'turkish': 'Merhaba',
      'image': 'path_to_image_hello',
    });
    await db.insert('words', {
      'english': 'Goodbye',
      'turkish': 'Güle güle',
      'image': 'path_to_image_goodbye',
    });
    await db.insert('words', {
      'english': 'Please',
      'turkish': 'Lütfen',
      'image': 'path_to_image_please',
    });
    await db.insert('words', {
      'english': 'Thank you',
      'turkish': 'Teşekkür ederim',
      'image': 'path_to_image_thank_you',
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
}
