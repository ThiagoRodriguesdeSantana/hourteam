import 'package:hourteam/models/register.dart';
import 'package:hourteam/repository/register_repo/register_repository_interface.dart';

import '../db.dart';

class RepositoryServiceRegister implements IRegisterRepository {
  Future<List<Register>> getAllRegister(int workId) async {
    final sql = '''SELECT * FROM ${DatabaseCreator.tableNameRegister} 
                   WHERE ${DatabaseCreator.workId} = ?''';

    List<dynamic> params = [workId];
    final dataListe = await db.rawQuery(sql, params);
    List<Register> registers = List();

    for (final data in dataListe) {
      print(data);
      final register = Register.fromJson(data);
      registers.add(register);
    }
    return registers;
  }

  Future<Register> getRegister(int id) async {
    final sql = '''SELECT * FROM ${DatabaseCreator.tableNameRegister}
    WHERE ${DatabaseCreator.id} = ?''';

    List<dynamic> params = [id];
    final data = await db.rawQuery(sql, params);

    final register = Register.fromJson(data.first);
    return register;
  }

  Future<void> addRegister(Register register) async {
    String date = getDateDb(register.date);

    final sql = '''INSERT INTO ${DatabaseCreator.tableNameRegister}
    (
      ${DatabaseCreator.id},
      ${DatabaseCreator.dateTime},
      ${DatabaseCreator.date},
      ${DatabaseCreator.entry},
      ${DatabaseCreator.workId}
    )
    VALUES (?,?,?,?,?)''';
    List<dynamic> params = [
      register.id,
      register.date.toString(),
      date,
      register.entry ? 1 : 0,
      register.workId
    ];
    final result = await db.rawInsert(sql, params);
    DatabaseCreator.databaseLog('Add register', sql, null, result, params);
  }

  Future<List<Register>> getRegisterInperiod(
      DateTime init, DateTime end, int workId) async {
    final sql = '''SELECT * FROM ${DatabaseCreator.tableNameRegister}
    WHERE ${DatabaseCreator.date} BETWEEN ? AND  ?  
    AND ${DatabaseCreator.workId} = ?''';

    String initS = getDateDb(init);
    String endS = getDateDb(end);
    List<dynamic> params = [initS, endS, workId];
    print(params);
    final dataList = await db.rawQuery(sql, params);
    print(dataList.length);

    List<Register> registers = List();

    for (final data in dataList) {
      final register = Register.fromJson(data);
      registers.add(register);
    }
    return registers;
  }

  Future<void> deleteRegister(int id) async {
    final sql = ''''DELETE FROM  ${DatabaseCreator.tableNameRegister}
    WHERE ${DatabaseCreator.id} = ?
    ''';
    List<dynamic> params = [id];
    final result = await db.rawUpdate(sql, params);

    DatabaseCreator.databaseLog('Delete register', sql, null, result, params);
  }

  static String getDateDb(DateTime date) {
    var dateString = date.year.toString() +
        "-" +
        date.month.toString() +
        "-" +
        date.day.toString();
    return dateString;
  }

  Future<bool> deleteAllRegister(int workId) async {
    try {
      final sql = '''DELETE FROM  ${DatabaseCreator.tableNameRegister}
    WHERE ${DatabaseCreator.workId} = ?''';

      List<dynamic> params = [workId];
      final result = await db.rawUpdate(sql, params);

      DatabaseCreator.databaseLog('Delete register', sql, null, result, params);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
