import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hourteam/business/register_business.dart';
import 'package:hourteam/locale_br.dart';
import 'package:hourteam/models/register.dart';

void main() {
  test("sum from only one day", () async {
    var business = RegisterBusiness(null);

    var list = new List<Register>();

    list.add(getNewRegister(true, 08, 11, 09, 00));

    list.add(getNewRegister(false, 08, 12, 00, 00));

    list.add(getNewRegister(true, 08, 13, 00, 00));

    list.add(getNewRegister(false, 08, 18, 00, 00));

    print("success");
  });
}

void getRegisterByOneDay(List<Register> list, int day) {
  list.add(getNewRegister(true, day, 08, 00, 00));
  list.add(getNewRegister(false, day, 12, 00, 00));
  list.add(getNewRegister(true, day, 13, 00, 00));
  list.add(getNewRegister(false, day, 18, 00, 00));
}

Register getNewRegister(bool entry, int day, int hour, int min, int secund) {
  var register1 = Register(1, entry);
  register1.date = DateTime(2020, 11, day, hour, min, secund);
  return register1;
}
