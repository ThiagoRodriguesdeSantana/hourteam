import 'package:hourteam/models/Work.dart';

abstract class IWorkRepository {
  // ignore: missing_return
  Future<List<Work>> getAllWorks() async {}
  // ignore: missing_return
  Future<bool> addWork(Work work) async {}
  Future<bool> deleteWork(Work work) async {}
  // ignore: missing_return
  Future<bool> updateWork(Work work) async {}
  // ignore: missing_return
  Future<Work> findByName(String name) async {}
}
