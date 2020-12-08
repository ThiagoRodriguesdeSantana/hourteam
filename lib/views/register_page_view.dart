import 'package:flutter/material.dart';
import 'package:hourteam/bloc/register_bloc.dart';
import 'package:hourteam/business/register_business.dart';
import 'package:hourteam/models/register.dart';
import 'package:hourteam/views/report.dart';

import 'filter_register.dart';
import 'list_register.dart';

class RegisterPageView extends StatelessWidget {
  final List<Register> listRegister;
  final RegisterBusiness registerBusiness;

  final RegisterBloc registerBloc;

  final _pageController = PageController(
    initialPage: 0,
  );

  RegisterPageView(this.listRegister, this.registerBusiness, this.registerBloc);

  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text("Registros"),
              actions: [
                Container(
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              FilterRegister(registerBloc, listRegister),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            body: StreamBuilder<List>(
              stream: registerBloc.output,
              builder: (context, snapshot) {
                return ListRegister(
                    registerBusiness, registerBloc.listRegister);
              },
            ),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text("Relatorio"),
            ),
            body: StreamBuilder<List>(
              stream: registerBloc.output,
              builder: (context, snapshot) {
                return ReportView(registerBusiness, registerBloc.listRegister);
              },
            ),
          )
        ]);
  }
}
