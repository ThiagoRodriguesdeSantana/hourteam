import 'package:hourteam/models/Work.dart';
import 'package:hourteam/repository/work_repo/work_repository_interface.dart';

import '../db.dart';

class RepositoryServiceWork implements IWorkRepository {
  Future<List<Work>> getAllWorks() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.tableNameWork}''';
    final dataListe = await db.rawQuery(sql);
    List<Work> registers = List();

    for (final data in dataListe) {
      print(data);
      final register = Work.fromJson(data);
      registers.add(register);
    }
    return registers;
  }

  Future<bool> addWork(Work work) async {
    try {
      final sql = '''INSERT INTO ${DatabaseCreator.tableNameWork}
    (
      ${DatabaseCreator.id},
      ${DatabaseCreator.workName}
    )
    VALUES (?,?)''';

      List<dynamic> params = [work.id, work.name];
      final result = await db.rawInsert(sql, params);
      DatabaseCreator.databaseLog('Add work', sql, null, result, params);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteWork(Work work) async {
    try {
      final sql =
          'DELETE FROM ${DatabaseCreator.tableNameWork} WHERE ${DatabaseCreator.id} = ?';

      List<dynamic> params = [work.id];
      final result = await db.rawUpdate(sql, params);

      DatabaseCreator.databaseLog('Delete register', sql, null, result, params);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateWork(Work work) async {
    try {
      final sql = '''UPDATE ${DatabaseCreator.tableNameWork}
    SET ${DatabaseCreator.workName} = ?
    WHERE ${DatabaseCreator.id} = ?
    ''';

      List<dynamic> params = [work.name, work.id];
      final result = await db.rawUpdate(sql, params);

      DatabaseCreator.databaseLog('update work', sql, null, result, params);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<Work> findByName(String name) async {
    print("entrou findByName");
    final sql =
        'SELECT * FROM ${DatabaseCreator.tableNameWork}  WHERE ${DatabaseCreator.workName} = ?';

    List<dynamic> params = [name];
    final result = await db.rawQuery(sql, params);

    if (result.length != 0) {
      final register = Work.fromJson(result.first);
      return register;
    }

    return null;
  }
}
