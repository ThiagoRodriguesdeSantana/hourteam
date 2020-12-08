import 'package:hourteam/repository/db.dart';

class Register {
  int id;
  int workId;
  DateTime date;
  bool entry;
  String type;

  static const typeEntry = 'E';
  static const typeExit = 'S';

  Register(int workId, bool entry) {
    this.workId = workId;
    this.entry = entry;
    this.type = this.getType();
    this.date = DateTime.now();
  }

  String getHour() {
    var hour = this.date.hour.toString();
    var minuts = this.date.minute.toString();
    var secunds = this.date.second.toString();
    var description = "Saida";
    if (this.entry) {
      description = "Entrada";
    }
    return hour.toString().padLeft(2, "0") +
        ":" +
        minuts.toString().padLeft(2, "0") +
        ":" +
        secunds.toString().padLeft(2, "0") +
        " - " +
        description;
  }

  String getDate() {
    var dateString = this.date.day.toString().padLeft(2, "0") +
        "/" +
        this.date.month.toString().padLeft(2, "0") +
        "/" +
        this.date.year.toString();
    return dateString;
  }

  String getFullDateTime() {
    return getDate() + " " + getHour();
  }

  Register.fromJson(Map<String, dynamic> json) {
    var date = DateTime.parse(json[DatabaseCreator.dateTime]);
    this.workId = json[DatabaseCreator.workId];
    this.id = json[DatabaseCreator.id];
    this.entry = json[DatabaseCreator.entry] == 0 ? false : true;
    this.date = date;
    this.type = this.getType();
  }

  String getType() {
    return this.entry ? typeEntry : typeExit;
  }
}
