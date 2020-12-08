import 'package:flutter/material.dart';
import 'package:hourteam/bloc/register_bloc.dart';
import 'package:hourteam/models/date_filter.dart';
import 'package:hourteam/models/register.dart';
import 'package:hourteam/views/field_date.dart';
import 'package:hourteam/views/widget/button_custom.dart';

class FilterRegister extends StatefulWidget {
  final RegisterBloc registerBloc;
  final List<Register> listRegister;

  FilterRegister(this.registerBloc, this.listRegister);

  @override
  _FilterRegisterState createState() => _FilterRegisterState();
}

class _FilterRegisterState extends State<FilterRegister> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  DateFilter dateFilter = new DateFilter();

  void callSnackBar(String info, Color color, Color backGroudColor) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          info,
          style: TextStyle(color: color),
        ),
        duration: Duration(seconds: 5),
        backgroundColor: backGroudColor,
      ),
    );
  }

  List<Register> filter() {
    var newList = widget.listRegister.where((element) {
      var onlyDate =
          DateTime(element.date.year, element.date.month, element.date.day);

      if (onlyDate.compareTo(dateFilter.dateInit) >= 0 &&
          onlyDate.compareTo(dateFilter.dateEnd) <= 0) {
        return true;
      } else {
        return false;
      }
    }).toList();

    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Filtrar Por Data"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(35),
        width: 350,
        child: Column(
          children: [
            Text(
              "De",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FieldDate(
              onDate: (value) {
                this.dateFilter.dateInit = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Ate",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FieldDate(
              onDate: (value) {
                this.dateFilter.dateEnd = value;
              },
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ButtonCustom(
                  withSize: 140,
                  heightSize: 50,
                  title: "Cancelar",
                  onPressedCustom: () {
                    Navigator.pop(context, null);
                  },
                ),
                StreamBuilder<List<Register>>(
                  stream: widget.registerBloc.output,
                  builder: (context, snapshot) {
                    return ButtonCustom(
                      withSize: 140,
                      heightSize: 50,
                      title: "Filtrar",
                      onPressedCustom: () {
                        if (this.dateFilter.dateEnd != null &&
                            this.dateFilter.dateInit != null &&
                            this
                                .dateFilter
                                .dateEnd
                                .isBefore(this.dateFilter.dateInit)) {
                          callSnackBar(
                              "Data final deve ser superior a data inicial",
                              Colors.white,
                              Colors.red);
                        } else {
                          if (dateFilter.dateInit == null ||
                              dateFilter.dateEnd == null) {
                            widget.registerBloc.setNewList(widget.listRegister);
                          } else {
                            var newList = filter();

                            print(newList.length);

                            widget.registerBloc.setNewList(newList);
                          }

                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
