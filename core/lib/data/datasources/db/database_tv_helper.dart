import 'dart:async';
import 'package:core/data/models/tv_series_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseTvHelper {
  static DatabaseTvHelper? _databaseTvHelper;
  DatabaseTvHelper._instance() {
    _databaseTvHelper = this;
  }

  factory DatabaseTvHelper() => _databaseTvHelper ?? DatabaseTvHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblTvWatchList = 'tv_watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton_tv.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreateTv);
    return db;
  }

  void _onCreateTv(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblTvWatchList (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertTvWatchlist(TvSeriesTable tvSeries) async {
    final db = await database;
    return await db!.insert(_tblTvWatchList, tvSeries.toJson());
  }

  Future<int> removeTvWatchlist(TvSeriesTable tvSeries) async {
    final db = await database;
    return await db!.delete(
      _tblTvWatchList,
      where: 'id = ?',
      whereArgs: [tvSeries.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTvWatchList,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getTvWatchlistTvSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblTvWatchList);

    return results;
  }
}
