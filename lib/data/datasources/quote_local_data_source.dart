import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/quote_model.dart';

abstract class QuoteLocalDataSource {
  Future<List<QuoteModel>> getFavoriteQuotes();
  Future<void> saveFavoriteQuote(QuoteModel quote);
  Future<void> removeFavoriteQuote(String id);
  Future<bool> isFavorite(String id);
}

class QuoteLocalDataSourceImpl implements QuoteLocalDataSource {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final pathString = join(dbPath, 'quotes.db');

    return await openDatabase(
      pathString,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            id TEXT PRIMARY KEY,
            content TEXT,
            author TEXT,
            isFavorite INTEGER
          )
        ''');
      },
    );
  }

  @override
  Future<List<QuoteModel>> getFavoriteQuotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return maps.map((map) => QuoteModel.fromMap(map)).toList();
  }

  @override
  Future<void> saveFavoriteQuote(QuoteModel quote) async {
    final db = await database;
    await db.insert(
      'favorites',
      quote.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFavoriteQuote(String id) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<bool> isFavorite(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty;
  }
}
