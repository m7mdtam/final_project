import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<Database> db() async {
    return openDatabase(
      join(await getDatabasesPath(), 'translator2.db'),
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
    await db.insert('words', {'english': 'Hello', 'turkish': 'Merhaba'});
    await db.insert('words', {'english': 'Goodbye', 'turkish': 'Hoşça kal'});
    await db.insert('words', {'english': 'Please', 'turkish': 'Lütfen'});
    await db.insert(
        'words', {'english': 'Thank you', 'turkish': 'Teşekkür ederim'});
    await db.insert('words', {'english': 'Yes', 'turkish': 'Evet'});
    await db.insert('words', {'english': 'No', 'turkish': 'Hayır'});
    await db
        .insert('words', {'english': 'Excuse me', 'turkish': 'Affedersiniz'});
    await db.insert('words', {'english': 'Sorry', 'turkish': 'Üzgünüm'});
    await db
        .insert('words', {'english': 'How are you?', 'turkish': 'Nasılsınız?'});
    await db.insert('words', {'english': 'I am fine', 'turkish': 'İyiyim'});
    await db.insert(
        'words', {'english': 'What is your name?', 'turkish': 'Adınız ne?'});
    await db.insert(
        'words', {'english': 'My name is...', 'turkish': 'Benim adım...'});
    await db.insert(
        'words', {'english': 'Where are you from?', 'turkish': 'Nerelisiniz?'});
    await db.insert(
        'words', {'english': 'I am from...', 'turkish': 'Ben ...liyim'});
    await db.insert('words', {
      'english': 'Do you speak English?',
      'turkish': 'İngilizce konuşuyor musunuz?'
    });
    await db.insert(
        'words', {'english': 'I don\'t understand', 'turkish': 'Anlamıyorum'});
    await db.insert('words', {'english': 'Help', 'turkish': 'Yardım'});
    await db.insert('words',
        {'english': 'Where is the bathroom?', 'turkish': 'Banyo nerede?'});
    await db.insert('words', {'english': 'How much?', 'turkish': 'Ne kadar?'});
    await db.insert('words', {'english': 'Open', 'turkish': 'Açık'});
    await db.insert('words', {'english': 'Closed', 'turkish': 'Kapalı'});
    await db.insert('words', {'english': 'Today', 'turkish': 'Bugün'});
    await db.insert('words', {'english': 'Tomorrow', 'turkish': 'Yarın'});
    await db.insert('words', {'english': 'Yesterday', 'turkish': 'Dün'});
    await db.insert('words', {'english': 'Morning', 'turkish': 'Sabah'});
    await db.insert('words', {'english': 'Evening', 'turkish': 'Akşam'});
    await db.insert('words', {'english': 'Night', 'turkish': 'Gece'});
    await db.insert('words', {'english': 'Breakfast', 'turkish': 'Kahvaltı'});
    await db.insert('words', {'english': 'Lunch', 'turkish': 'Öğle yemeği'});
    await db.insert('words', {'english': 'Dinner', 'turkish': 'Akşam yemeği'});
    await db.insert('words', {'english': 'Water', 'turkish': 'Su'});
    await db.insert('words', {'english': 'Food', 'turkish': 'Yemek'});
    await db.insert('words', {'english': 'Left', 'turkish': 'Sol'});
    await db.insert('words', {'english': 'Right', 'turkish': 'Sağ'});
    await db.insert('words', {'english': 'Straight', 'turkish': 'Düz'});
    await db.insert('words', {'english': 'Back', 'turkish': 'Geri'});
    await db.insert('words', {'english': 'Stop', 'turkish': 'Dur'});
    await db.insert('words', {'english': 'Go', 'turkish': 'Git'});
    await db.insert('words', {'english': 'One', 'turkish': 'Bir'});
    await db.insert('words', {'english': 'Two', 'turkish': 'İki'});
    await db.insert('words', {'english': 'Three', 'turkish': 'Üç'});
    await db.insert('words', {'english': 'Four', 'turkish': 'Dört'});
    await db.insert('words', {'english': 'Five', 'turkish': 'Beş'});
    await db.insert('words', {'english': 'Six', 'turkish': 'Altı'});
    await db.insert('words', {'english': 'Seven', 'turkish': 'Yedi'});
    await db.insert('words', {'english': 'Eight', 'turkish': 'Sekiz'});
    await db.insert('words', {'english': 'Nine', 'turkish': 'Dokuz'});
    await db.insert('words', {'english': 'Ten', 'turkish': 'On'});
    await db.insert('words', {'english': 'Eleven', 'turkish': 'On bir'});
    await db.insert('words', {'english': 'Twelve', 'turkish': 'On iki'});
    await db.insert('words', {'english': 'Thirteen', 'turkish': 'On üç'});
    await db.insert('words', {'english': 'Fourteen', 'turkish': 'On dört'});
    await db.insert('words', {'english': 'Fifteen', 'turkish': 'On beş'});
    await db.insert('words', {'english': 'Sixteen', 'turkish': 'On altı'});
    await db.insert('words', {'english': 'Seventeen', 'turkish': 'On yedi'});
    await db.insert('words', {'english': 'Eighteen', 'turkish': 'On sekiz'});
    await db.insert('words', {'english': 'Nineteen', 'turkish': 'On dokuz'});
    await db.insert('words', {'english': 'Twenty', 'turkish': 'Yirmi'});
    await db.insert('words', {'english': 'Thirty', 'turkish': 'Otuz'});
    await db.insert('words', {'english': 'Forty', 'turkish': 'Kırk'});
    await db.insert('words', {'english': 'Fifty', 'turkish': 'Elli'});
    await db.insert('words', {'english': 'Sixty', 'turkish': 'Altmış'});
    await db.insert('words', {'english': 'Seventy', 'turkish': 'Yetmiş'});
    await db.insert('words', {'english': 'Eighty', 'turkish': 'Seksen'});
    await db.insert('words', {'english': 'Ninety', 'turkish': 'Doksan'});
    await db.insert('words', {'english': 'Hundred', 'turkish': 'Yüz'});
    await db.insert('words', {'english': 'Thousand', 'turkish': 'Bin'});
    await db.insert('words', {'english': 'Million', 'turkish': 'Milyon'});
    await db.insert('words', {'english': 'Monday', 'turkish': 'Pazartesi'});
    await db.insert('words', {'english': 'Tuesday', 'turkish': 'Salı'});
    await db.insert('words', {'english': 'Wednesday', 'turkish': 'Çarşamba'});
    await db.insert('words', {'english': 'Thursday', 'turkish': 'Perşembe'});
    await db.insert('words', {'english': 'Friday', 'turkish': 'Cuma'});
    await db.insert('words', {'english': 'Saturday', 'turkish': 'Cumartesi'});
    await db.insert('words', {'english': 'Sunday', 'turkish': 'Pazar'});
    await db.insert('words', {'english': 'January', 'turkish': 'Ocak'});
    await db.insert('words', {'english': 'February', 'turkish': 'Şubat'});
    await db.insert('words', {'english': 'March', 'turkish': 'Mart'});
    await db.insert('words', {'english': 'April', 'turkish': 'Nisan'});
    await db.insert('words', {'english': 'May', 'turkish': 'Mayıs'});
    await db.insert('words', {'english': 'June', 'turkish': 'Haziran'});
    await db.insert('words', {'english': 'July', 'turkish': 'Temmuz'});
    await db.insert('words', {'english': 'August', 'turkish': 'Ağustos'});
    await db.insert('words', {'english': 'September', 'turkish': 'Eylül'});
    await db.insert('words', {'english': 'October', 'turkish': 'Ekim'});
    await db.insert('words', {'english': 'November', 'turkish': 'Kasım'});
    await db.insert('words', {'english': 'December', 'turkish': 'Aralık'});
    await db.insert('words', {'english': 'Red', 'turkish': 'Kırmızı'});
    await db.insert('words', {'english': 'Blue', 'turkish': 'Mavi'});
    await db.insert('words', {'english': 'Green', 'turkish': 'Yeşil'});
    await db.insert('words', {'english': 'Yellow', 'turkish': 'Sarı'});
    await db.insert('words', {'english': 'Black', 'turkish': 'Siyah'});
    await db.insert('words', {'english': 'White', 'turkish': 'Beyaz'});
    await db.insert('words', {'english': 'Orange', 'turkish': 'Turuncu'});
    await db.insert('words', {'english': 'Purple', 'turkish': 'Mor'});
    await db.insert('words', {'english': 'Brown', 'turkish': 'Kahverengi'});
    await db.insert('words', {'english': 'Pink', 'turkish': 'Pembe'});
    await db.insert('words', {'english': 'Gray', 'turkish': 'Gri'});
    await db.insert('words', {'english': 'Gold', 'turkish': 'Altın'});
    await db.insert('words', {'english': 'Silver', 'turkish': 'Gümüş'});
    await db.insert('words', {'english': 'Beige', 'turkish': 'Bej'});
    await db.insert('words', {'english': 'Maroon', 'turkish': 'Bordo'});
    await db.insert('words', {'english': 'Father', 'turkish': 'Baba'});
    await db.insert('words', {'english': 'Mother', 'turkish': 'Anne'});
    await db.insert('words', {'english': 'Brother', 'turkish': 'Erkek kardeş'});
    await db.insert('words', {'english': 'Sister', 'turkish': 'Kız kardeş'});
    await db.insert('words', {'english': 'Son', 'turkish': 'Oğul'});
    await db.insert('words', {'english': 'Daughter', 'turkish': 'Kız evlat'});
    await db.insert('words', {'english': 'Grandfather', 'turkish': 'Dede'});
    await db
        .insert('words', {'english': 'Grandmother', 'turkish': 'Büyükanne'});
    await db.insert('words', {'english': 'Uncle', 'turkish': 'Amca/Dayı'});
    await db.insert('words', {'english': 'Aunt', 'turkish': 'Teyze/Hala'});
    await db.insert('words', {'english': 'Cousin', 'turkish': 'Kuzen'});
    await db.insert('words', {'english': 'Nephew', 'turkish': 'Yeğen (erkek)'});
    await db.insert('words', {'english': 'Niece', 'turkish': 'Yeğen (kız)'});
    await db.insert('words', {'english': 'Husband', 'turkish': 'Koca'});
    await db.insert('words', {'english': 'Wife', 'turkish': 'Eş'});
    await db.insert('words', {'english': 'Dog', 'turkish': 'Köpek'});
    await db.insert('words', {'english': 'Cat', 'turkish': 'Kedi'});
    await db.insert('words', {'english': 'Bird', 'turkish': 'Kuş'});
    await db.insert('words', {'english': 'Fish', 'turkish': 'Balık'});
    await db.insert('words', {'english': 'Horse', 'turkish': 'At'});
    await db.insert('words', {'english': 'Cow', 'turkish': 'İnek'});
    await db.insert('words', {'english': 'Sheep', 'turkish': 'Koyun'});
    await db.insert('words', {'english': 'Goat', 'turkish': 'Keçi'});
    await db.insert('words', {'english': 'Pig', 'turkish': 'Domuz'});
    await db.insert('words', {'english': 'Chicken', 'turkish': 'Tavuk'});
    await db.insert('words', {'english': 'Duck', 'turkish': 'Ördek'});
    await db.insert('words', {'english': 'Rabbit', 'turkish': 'Tavşan'});
    await db.insert('words', {'english': 'Lion', 'turkish': 'Aslan'});
    await db.insert('words', {'english': 'Tiger', 'turkish': 'Kaplan'});
    await db.insert('words', {'english': 'Elephant', 'turkish': 'Fil'});
    await db.insert('words', {'english': 'Monkey', 'turkish': 'Maymun'});
    await db.insert('words', {'english': 'Bear', 'turkish': 'Ayı'});
    await db.insert('words', {'english': 'Wolf', 'turkish': 'Kurt'});
    await db.insert('words', {'english': 'Fox', 'turkish': 'Tilki'});
    await db.insert('words', {'english': 'Deer', 'turkish': 'Geyik'});
    await db.insert('words', {'english': 'Bread', 'turkish': 'Ekmek'});
    await db.insert('words', {'english': 'Butter', 'turkish': 'Tereyağı'});
    await db.insert('words', {'english': 'Cheese', 'turkish': 'Peynir'});
    await db.insert('words', {'english': 'Milk', 'turkish': 'Süt'});
    await db.insert('words', {'english': 'Coffee', 'turkish': 'Kahve'});
    await db.insert('words', {'english': 'Tea', 'turkish': 'Çay'});
    await db.insert('words', {'english': 'Juice', 'turkish': 'Meyve suyu'});
    await db.insert('words', {'english': 'Fruit', 'turkish': 'Meyve'});
    await db.insert('words', {'english': 'Apple', 'turkish': 'Elma'});
    await db.insert('words', {'english': 'Banana', 'turkish': 'Muz'});
    await db.insert('words', {'english': 'Orange', 'turkish': 'Portakal'});
    await db.insert('words', {'english': 'Grapes', 'turkish': 'Üzüm'});
    await db.insert('words', {'english': 'Strawberry', 'turkish': 'Çilek'});
    await db.insert('words', {'english': 'Vegetable', 'turkish': 'Sebze'});
    await db.insert('words', {'english': 'Tomato', 'turkish': 'Domates'});
    await db.insert('words', {'english': 'Potato', 'turkish': 'Patates'});
    await db.insert('words', {'english': 'Carrot', 'turkish': 'Havuç'});
    await db.insert('words', {'english': 'Onion', 'turkish': 'Soğan'});
    await db.insert('words', {'english': 'Garlic', 'turkish': 'Sarımsak'});
    await db.insert('words', {'english': 'Pepper', 'turkish': 'Biber'});
    await db.insert('words', {'english': 'Sun', 'turkish': 'Güneş'});
    await db.insert('words', {'english': 'Moon', 'turkish': 'Ay'});
    await db.insert('words', {'english': 'Star', 'turkish': 'Yıldız'});
    await db.insert('words', {'english': 'Sky', 'turkish': 'Gökyüzü'});
    await db.insert('words', {'english': 'Cloud', 'turkish': 'Bulut'});
    await db.insert('words', {'english': 'Rain', 'turkish': 'Yağmur'});
    await db.insert('words', {'english': 'Snow', 'turkish': 'Kar'});
    await db.insert('words', {'english': 'Wind', 'turkish': 'Rüzgar'});
    await db.insert('words', {'english': 'Mountain', 'turkish': 'Dağ'});
    await db.insert('words', {'english': 'River', 'turkish': 'Nehir'});
    await db.insert('words', {'english': 'Lake', 'turkish': 'Göl'});
    await db.insert('words', {'english': 'Sea', 'turkish': 'Deniz'});
    await db.insert('words', {'english': 'Ocean', 'turkish': 'Okyanus'});
    await db.insert('words', {'english': 'Forest', 'turkish': 'Orman'});
    await db.insert('words', {'english': 'Tree', 'turkish': 'Ağaç'});
    await db.insert('words', {'english': 'Flower', 'turkish': 'Çiçek'});
    await db.insert('words', {'english': 'Grass', 'turkish': 'Çimen'});
    await db.insert('words', {'english': 'Sand', 'turkish': 'Kum'});
    await db.insert('words', {'english': 'Rock', 'turkish': 'Kaya'});
    await db.insert('words', {'english': 'Island', 'turkish': 'Ada'});
    await db.insert('words', {'english': 'Book', 'turkish': 'Kitap'});
    await db.insert('words', {'english': 'Pen', 'turkish': 'Kalem'});
    await db.insert('words', {'english': 'Table', 'turkish': 'Masa'});
    await db.insert('words', {'english': 'Chair', 'turkish': 'Sandalye'});
    await db.insert('words', {'english': 'Computer', 'turkish': 'Bilgisayar'});
    await db.insert('words', {'english': 'Phone', 'turkish': 'Telefon'});
    await db.insert('words', {'english': 'Car', 'turkish': 'Araba'});
    await db.insert('words', {'english': 'Bicycle', 'turkish': 'Bisiklet'});
    await db.insert('words', {'english': 'House', 'turkish': 'Ev'});
    await db.insert('words', {'english': 'Building', 'turkish': 'Bina'});
    await db.insert('words', {'english': 'Road', 'turkish': 'Yol'});
    await db.insert('words', {'english': 'Bridge', 'turkish': 'Köprü'});
    await db.insert('words', {'english': 'Door', 'turkish': 'Kapı'});
    await db.insert('words', {'english': 'Window', 'turkish': 'Pencere'});
    await db.insert('words', {'english': 'Clock', 'turkish': 'Saat'});
    await db.insert('words', {'english': 'Watch', 'turkish': 'Kol saati'});
    await db.insert('words', {'english': 'Bag', 'turkish': 'Çanta'});
    await db.insert('words', {'english': 'Wallet', 'turkish': 'Cüzdan'});
    await db.insert('words', {'english': 'Key', 'turkish': 'Anahtar'});
    await db.insert('words', {'english': 'Light', 'turkish': 'Işık'});
    await db.insert('words', {'english': 'Big', 'turkish': 'Büyük'});
    await db.insert('words', {'english': 'Small', 'turkish': 'Küçük'});
    await db.insert('words', {'english': 'Tall', 'turkish': 'Uzun'});
    await db.insert('words', {'english': 'Short', 'turkish': 'Kısa'});
    await db.insert('words', {'english': 'Good', 'turkish': 'İyi'});
    await db.insert('words', {'english': 'Bad', 'turkish': 'Kötü'});
    await db.insert('words', {'english': 'Hot', 'turkish': 'Sıcak'});
    await db.insert('words', {'english': 'Cold', 'turkish': 'Soğuk'});
    await db.insert('words', {'english': 'Fast', 'turkish': 'Hızlı'});
    await db.insert('words', {'english': 'Slow', 'turkish': 'Yavaş'});
    await db.insert('words', {'english': 'Happy', 'turkish': 'Mutlu'});
    await db.insert('words', {'english': 'Sad', 'turkish': 'Üzgün'});
    await db.insert('words', {'english': 'Beautiful', 'turkish': 'Güzel'});
    await db.insert('words', {'english': 'Ugly', 'turkish': 'Çirkin'});
    await db.insert('words', {'english': 'New', 'turkish': 'Yeni'});
    await db.insert('words', {'english': 'Old', 'turkish': 'Eski'});
    await db.insert('words', {'english': 'Strong', 'turkish': 'Güçlü'});
    await db.insert('words', {'english': 'Weak', 'turkish': 'Zayıf'});
    await db.insert('words', {'english': 'Rich', 'turkish': 'Zengin'});
    await db.insert('words', {'english': 'Poor', 'turkish': 'Fakir'});
    await db.insert('words', {'english': 'Clean', 'turkish': 'Temiz'});
    await db.insert('words', {'english': 'Dirty', 'turkish': 'Kirli'});
    await db.insert('words', {'english': 'Heavy', 'turkish': 'Ağır'});
    await db.insert('words', {'english': 'Light', 'turkish': 'Hafif'});
    await db.insert('words', {'english': 'Full', 'turkish': 'Dolu'});
    await db.insert('words', {'english': 'Empty', 'turkish': 'Boş'});
    await db.insert('words', {'english': 'Early', 'turkish': 'Erken'});
    await db.insert('words', {'english': 'Late', 'turkish': 'Geç'});
    await db.insert('words', {'english': 'Easy', 'turkish': 'Kolay'});
    await db.insert('words', {'english': 'Difficult', 'turkish': 'Zor'});
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
