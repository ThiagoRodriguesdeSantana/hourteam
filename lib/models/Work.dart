import 'package:hourteam/repository/db.dart';

class Work {
  int id;
  String name;

  Work(String name) {
    this.name = name;
  }

  Work.fromJson(Map<String, dynamic> json) {
    this.id = json[DatabaseCreator.id];
    this.name = json[DatabaseCreator.workName];
  }
}
