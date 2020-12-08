import 'package:hourteam/models/register.dart';
import 'package:hourteam/models/total_time.dart';

class ReportDay {
  String day;
  TotalTime totalHoursWork;
  TotalTime totalHoursPause;
}

enum groupType {
  Day,
  Week,
  Month,
  Year,
}
