import 'package:hourteam/models/register.dart';

abstract class IRegisterRepository {
  Future<Register> getRegister(int id) async {}
  Future<void> addRegister(Register register) async {}
  Future<List<Register>> getRegisterInperiod(
      DateTime init, DateTime end, int workId) async {}
  Future<void> deleteRegister(int id) async {}
  Future<bool> deleteAllRegister(int workId) async {}
  Future<List<Register>> getAllRegister(int workId) async {}
}
