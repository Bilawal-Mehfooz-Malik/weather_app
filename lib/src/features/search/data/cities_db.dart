import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/src/features/search/domain/city_model.dart';

class CitiesDatabase {
  Database? _db;

  // Method to open the database from the assets folder
  Future<Database> _openDb() async {
    if (_db != null) {
      return _db!; // Return cached database
    }

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cities.db');

    bool exists = await databaseExists(path);

    if (!exists) {
      ByteData data = await rootBundle.load('assets/cities.db');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }

    _db = await openDatabase(path);
    return _db!;
  }

  // Method to search cities by name and return a list of City objects
  Future<List<City>> searchCities(String query) async {
    final db = await _openDb();

    // Sort results: cities starting with the query should come first
    List<Map<String, dynamic>> results = await db.query(
      'cities',
      where: 'cityName LIKE ?',
      whereArgs: ['%$query%'],
      orderBy:
          "CASE WHEN cityName LIKE '$query%' THEN 0 ELSE 1 END, LENGTH(cityName)", // Sort by starting match first, then by length for better relevance
      limit: 10, // Limit results for performance
    );

    return results.map((cityMap) => City.fromMap(cityMap)).toList();
  }
}
