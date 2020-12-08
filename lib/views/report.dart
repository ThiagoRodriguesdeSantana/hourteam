import 'package:flutter/material.dart';
import 'package:hourteam/business/register_business.dart';
import 'package:hourteam/models/register.dart';
import 'package:hourteam/models/report.dart';
import 'package:hourteam/models/report_day.dart';
import 'package:hourteam/models/total_time.dart';

class ReportView extends StatelessWidget {
  final RegisterBusiness registerBusiness;
  final List<Register> listRegister;
  Report report;

  ReportView(this.registerBusiness, this.listRegister);

  Map<int, List<Register>> group(List<Register> list) {
    return registerBusiness.group(list, groupType.Day);
  }

  void setReport() {
    report = this.registerBusiness.getReport(this.listRegister);
  }

  @override
  Widget build(BuildContext context) {
    // var listGroup = group(listRegister);

    // print("total agrupado: " + listGroup.length.toString());

    // if (listGroup == null) {
    //   return Container();
    // }

    setReport();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      // mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: report.report.length,
            itemBuilder: (context, index) {
              Color color = Colors.grey[300];

              if ((index % 2) != 0) {
                color = Colors.grey[400];
              }

              var totalDay = report.report[index];
              return registerRow(totalDay.day, totalDay.totalHoursWork, color);
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Card(
            child: Text(
              report.totalTime.toString(),
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget registerRow(String day, TotalTime total, Color color) {
    return Container(
      color: color,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            total.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
