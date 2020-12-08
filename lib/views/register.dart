import 'package:flutter/material.dart';
import 'package:hourteam/bloc/register_bloc.dart';
import 'package:hourteam/business/register_business.dart';
import 'package:hourteam/models/register.dart';
import 'package:hourteam/views/clock.dart';
import 'package:hourteam/views/register_page_view.dart';

class RegisterView extends StatefulWidget {
  final int work;
  final RegisterBusiness business;

  const RegisterView({this.work, this.business});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterBloc registerBloc = RegisterBloc();
  Register lastRegister;
  List<Register> listRegister;

  @override
  void initState() {
    this.widget.business.getRegister(this.widget.work).then((value) {
      this.listRegister = value;
      getLastRegister();
    }).catchError((error) {
      print(error);
    });
  }

  void getLastRegister() {
    setState(() {
      this.lastRegister = this.listRegister?.last;
    });
  }

  void register() {
    var entry = this.lastRegister == null ? true : !this.lastRegister.entry;

    var newRegister = Register(this.widget.work, entry);

    this.widget.business.addRegister(newRegister).then((value) {
      this.listRegister.add(newRegister);
      getLastRegister();
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Registro",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 50,
            ),
            child: Text(
              "Clique e segure para registrar a hora",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onLongPress: () {
                register();
              },
              child: Center(
                child: Clock(),
              ),
            ),
          ),
          Container(
              width: 250,
              child: Center(
                child: Text(
                  lastRegister == null ? "" : lastRegister.getFullDateTime(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )),
          SizedBox(
            height: 80,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
        onPressed: () {
          registerBloc.setNewList(this.listRegister);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => RegisterPageView(
                      this.listRegister, widget.business, registerBloc)));
        },
      ),
    );
  }
}
