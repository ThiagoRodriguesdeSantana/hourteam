import 'dart:convert';

import 'package:hourteam/models/register.dart';
import 'package:hourteam/models/report.dart';
import 'package:hourteam/models/report_day.dart';
import 'package:hourteam/models/total_time.dart';
import 'package:hourteam/repository/register_repo/register_repository_interface.dart';

class RegisterBusiness {
  final IRegisterRepository registerRepository;

  TotalTime totalWork = TotalTime();
  TotalTime totalPause = TotalTime();

  RegisterBusiness(this.registerRepository);

  Future<Register> addRegister(Register register) async {
    await registerRepository.addRegister(register);

    return register;
  }

  Future<void> deleteRegister(int registerId) async {
    await registerRepository.deleteRegister(registerId);
  }

  Future<List<Register>> getRegister(workId) async {
    return await registerRepository.getAllRegister(workId);
  }

  Map<int, List<Register>> group(List<Register> register, groupType type) {
    switch (type) {
      case groupType.Day:
        return groupByDay(register);
      case groupType.Week:
        return null;
        break;
      case groupType.Month:
        return null;
        break;
      case groupType.Year:
        return null;
        break;
    }
    return null;
  }

  Map<int, List<Register>> groupByDay(List<Register> listRegister) {
    var listGroup = new Map<int, List<Register>>();
    var list = new Map<String, List<Register>>();

    listRegister.sort((a, b) => b.date.compareTo(a.date));

    for (var item in listRegister) {
      List<Register> groupdDate = listRegister.where((element) {
        return item.getDate() == element.getDate();
      }).toList();

      list[item.getDate()] = groupdDate;
    }

    var index = 0;

    for (var key in list.keys) {
      var value = list[key];
      listGroup[index] = value;
      index++;
    }

    return listGroup;
  }

  Report getReport(List<Register> reports) {
    var groupList = group(reports, groupType.Day);

    var report = Report();
    report.report = new List<ReportDay>();

    groupList.forEach((key, value) {
      var total = getTotalHour(value, value.first.getDate());
      report.report.add(total);
    });

    var total = getTotalHour(reports, "");

    report.totalTime = total.totalHoursWork;

    return report;
  }

  ReportDay getTotalHour(List<Register> listRegister, String day) {
    var report = ReportDay();

    listRegister.sort((a, b) => a.date.compareTo(b.date));
    List<Register> register = validateRegiser(listRegister);

    var timesCaculate = getTotal(register);
    report.day = day;

    report.totalHoursWork = timesCaculate[0];
    report.totalHoursPause = timesCaculate[1];
    return report;
  }

  List<TotalTime> getTotal(List<Register> registers) {
    DateTime totalPause = DateTime(0, 0, 0, 0, 0, 0);
    DateTime totalWork = DateTime(0, 0, 0, 0, 0, 0);

    for (var i = 0; i < registers.length; i++) {
      if (i == 0) {
        continue;
      }

      var last = registers[i - 1];
      var total = registers[i].date.difference(last.date);

      if (registers[i].entry) {
        totalPause = totalPause.add(total);
      } else {
        totalWork = totalWork.add(total);
      }
    }

    var worked = TotalTime(time: totalWork);
    var paused = TotalTime(time: totalPause);

    this.totalWork.sumTime(worked);
    this.totalPause.sumTime(paused);

    return [worked, paused];
  }

  String formatTime(DateTime total) {
    var hh = total.hour;
    var min = total.minute;
    var sec = total.second;

    return hh.toString().padLeft(2, "0") +
        ":" +
        min.toString().padLeft(2, "0") +
        ":" +
        sec.toString().padLeft(2, "0");
  }

  DateTime calculateTime(DateTime date01, DateTime date02, DateTime total) {
    var time = date01.difference(date02);
    total = total.add(time);
    return total;
  }

  bool isExit(Register item, Register last) => !item.entry && last.entry;

  bool isEntry(Register item, Register last) => item.entry && !last.entry;

  List<Register> validateRegiser(List<Register> registers) {
    var newRegisters = new List<Register>.from(registers);
    var first = newRegisters.first;
    var last = newRegisters.last;

    if (!first.entry) {
      var newRegister = Register(first.workId, true);
      newRegister.date = DateTime(
        first.date.year,
        first.date.month,
        first.date.day,
        00,
        00,
        00,
      );
      newRegisters.insert(0, newRegister);
      // newRegisters.add(newRegister);
    }

    if (last.entry) {
      var now = DateTime.now();
      var yesterday = now.add(Duration(days: -1));

      var newRegister = Register(first.workId, false);
      var compareDate = last.date.compareTo(yesterday);
      if (compareDate <= 0) {
        DateTime nextDay = last.date.add(Duration(days: 1));
        newRegister.date = DateTime(
          nextDay.year,
          nextDay.month,
          nextDay.day,
          00,
          00,
          00,
        );
      }

      newRegisters.add(newRegister);
    }
    return newRegisters;
  }
}
