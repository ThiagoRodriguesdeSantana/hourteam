import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

Database db;

class DatabaseCreator {

  static const tableNameWork = 'work_ht';
  static const tableNameRegister = 'register_ht';
  static const id = 'id';
  static const workId = 'work_id';
  static const workName = "name";
  static const dateTime = 'date';
  static const entry = 'entry';
  static const date = 'hour';
  // static const isDeleted = 'isDeleted';


  Future<void> createWorkTable(Database db) async {
    final todoSql = '''CREATE TABLE $tableNameWork
    (
      $id INTEGER PRIMARY KEY,
      $workName TEXT
    )''';

    await db.execute(todoSql);
  }

  Future<void> createRegisterTable(Database db) async {
    final registerSql = '''CREATE TABLE $tableNameRegister
    (
      $id INTEGER PRIMARY KEY,
      $dateTime TEXT,
      $date TEXT,
      $entry BOOL,
      $workId INTEGER
    )''';

    await db.execute(registerSql);
  }

  static void databaseLog(String functionName, String sql,
      [List<Map<String, dynamic>> selectQueryResult,
      int insertAndUpdateQueryResult,
      List<dynamic> params]) {
    print(functionName);
    print(sql);
    if (params != null) {
      print(params);
    }
    if (selectQueryResult != null) {
      print(selectQueryResult);
    } else if (insertAndUpdateQueryResult != null) {
      print(insertAndUpdateQueryResult);
    }
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    //make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      //await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('hourteam_db');
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createRegisterTable(db);
    await createWorkTable(db);
  }
}


