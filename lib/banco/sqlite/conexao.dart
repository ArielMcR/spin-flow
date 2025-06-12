import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:spin_flow/banco/sqlite/script.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class Conexao {
  static Database? _db;

  static Future<Database> get() async {
    if (_db != null) return _db!;

    try {
      if (kIsWeb) {
        databaseFactory = databaseFactoryFfiWeb;
        _db = await databaseFactory.openDatabase('db_web.sqlite');
        for (final sql in criarTabelas) {
          await _db!.execute(sql);
        }
        for (final insert in insertFabricante) {
          await _db!.execute(insert);
        }
        return _db!;
      }

      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'app.db');
      await deleteDatabase(path);

      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          for (final sql in criarTabelas) {
            await db.execute(sql);
          }
          for (final insert in insertFabricante) {
            await db.execute(insert);
          }
        },
      );
      return _db!;
    } catch (e) {
      rethrow;
    }
  }
}
