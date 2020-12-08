import 'package:flutter/material.dart';
import 'package:hourteam/business/work_business.dart';
import 'package:hourteam/models/Work.dart';

class CreateWork extends StatefulWidget {
  final WorkBusiness business;
  final Work work;
  final String title;

  const CreateWork(this.business, this.work, this.title);

  @override
  _CreateWorkState createState() => _CreateWorkState();
}

class _CreateWorkState extends State<CreateWork> {
  final _formeKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void addWork() {
    var name = _nameController.text.trim();

    var work = Work(name);
    this.widget.business.createNewWork(work).then((value) {
      callSnackBar("Salvo", Colors.white, Colors.pinkAccent);
    }).catchError((error) {
      callSnackBar(getMesageError(error), Colors.white, Colors.red);
    });
  }

  String getMesageError(Object error) {
    return error.toString().split("Exception:")[1];
  }

  void updateWork() {
    this.widget.work.name = _nameController.text.trim();

    this.widget.business.alterWork(this.widget.work).then((value) {
      callSnackBar("Salvo", Colors.white, Colors.pinkAccent);
    }).catchError((error) {
      callSnackBar(getMesageError(error), Colors.white, Colors.red);
    });
  }

  void callSnackBar(String info, Color color, Color backGroudColor) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        info,
        style: TextStyle(color: color),
      ),
      duration: Duration(seconds: 5),
      backgroundColor: backGroudColor,
    ));
  }

  @override
  void initState() {
    super.initState();

    if (this.widget.work != null) {
      _nameController.text = this.widget.work.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(this.widget.title),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
          key: _formeKey,
          child: Container(
            margin: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Nome da atividade"),
                  validator: (text) {
                    if (text.isEmpty) {
                      return "Nome obrigatorio!";
                    }
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                RaisedButton(
                  color: Colors.blue[300],
                  child: Text("Salvar"),
                  onPressed: () {
                    if (this.widget.work == null) {
                      addWork();
                      _nameController.clear();
                    } else {
                      updateWork();
                    }
                  },
                )
              ],
            ),
          )),
    );
  }
}
