import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/bloom_models.dart';

abstract class StorageProvider {
  Future<void> saveBloomData(Map<String, dynamic> data);
  Future<Map<String, dynamic>?> loadBloomData();
  Future<void> saveBloomProfile(BloomProfile profile);
  Future<BloomProfile?> loadBloomProfile();
  Future<void> clear();
}

class LocalStorageProvider implements StorageProvider {
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'bloom.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE bloom (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            data TEXT NOT NULL
          )
        ''');
      },
    );
  }

  @override
  Future<void> saveBloomData(Map<String, dynamic> data) async {
    final db = await database;
    final json = jsonEncode(data);
    await db.insert('bloom', {'data': json}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<Map<String, dynamic>?> loadBloomData() async {
    final db = await database;
    final List<Map> maps = await db.query('bloom', limit: 1);
    if (maps.isEmpty) return null;
    return jsonDecode(maps.first['data'] as String) as Map<String, dynamic>;
  }

  @override
  Future<void> saveBloomProfile(BloomProfile profile) async {
    await saveBloomData(profile.toJson());
  }

  @override
  Future<BloomProfile?> loadBloomProfile() async {
    final data = await loadBloomData();
    if (data == null) return null;
    return BloomProfile.fromJson(data);
  }

  @override
  Future<void> clear() async {
    final db = await database;
    await db.delete('bloom');
  }
}
