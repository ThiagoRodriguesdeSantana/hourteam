import 'package:flutter/material.dart';
import 'package:hourteam/business/register_business.dart';
import 'package:hourteam/models/register.dart';
import 'package:hourteam/models/report_day.dart';

class ListRegister extends StatelessWidget {
  // final RegisterBloc registerBloc;
  final RegisterBusiness registerBusiness;
  final List<Register> listRegister;

  ListRegister(this.registerBusiness, this.listRegister);

  final _pageController = PageController(
    initialPage: 0,
  );

  Map<int, List<Register>> group(List<Register> list) {
    return registerBusiness.group(list, groupType.Day);
  }

  List<Widget> getRegisterByDay(List<Register> date) {
    List<Card> registerByDay = new List<Card>();

    registerByDay.add(Card(
      color: Colors.blue[200],
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100))),
      child: Container(
        height: 35,
        width: 350,
        margin: EdgeInsets.only(top: 10),
        child: Text(
          date[0].getDate(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ));

    for (var item in date) {
      registerByDay.add(
        Card(
          child: Container(
            width: 200,
            child: Text(
              item.getHour(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
    }

    return registerByDay;
  }

  @override
  Widget build(BuildContext context) {
    var listGroup = group(listRegister);

    if (listGroup == null) {
      return Container();
    }

    return ListView.builder(
      itemCount: listGroup.length,
      itemBuilder: (context, index) {
        return Column(
          children: getRegisterByDay(listGroup[index]),
        );
      },
    );
  }
}
