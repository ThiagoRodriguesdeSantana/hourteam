import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hourteam/business/register_business.dart';
import 'package:hourteam/business/work_business.dart';
import 'package:hourteam/models/Work.dart';
import 'package:hourteam/repository/register_repo/register_repository.dart';
import 'package:hourteam/repository/work_repo/work_repository.dart';
import 'package:hourteam/views/register.dart';
import 'package:hourteam/views/widget/work_card.dart';

import 'add_work.dart';

class ListWork extends StatefulWidget {
  @override
  _ListWorkState createState() => _ListWorkState();
}

class _ListWorkState extends State<ListWork> {
  WorkBusiness workBusiness;
  RegisterBusiness registerBusiness;

  Future<List<Work>> works;

  @override
  void initState() {
    super.initState();

    var repository = RepositoryServiceWork();
    var register = RepositoryServiceRegister();

    workBusiness = WorkBusiness(repository, register);

    registerBusiness = RegisterBusiness(register);

    loadWorks();
  }

  void loadWorks() {
    this.works = this.workBusiness.listWorks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HourTeam"),
        leading: Container(
          child: CircleAvatar(
            radius: 25,
            backgroundImage:
                AssetImage("assets/images/logo_main_menor_100.png"),
          ),
        ),
      ),
      body: FutureBuilder<List<Work>>(
        future: this.works,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              var work = snapshot.data[index];
              return Dismissible(
                key: Key(work.name),
                direction: DismissDirection.startToEnd,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    WorkCard(
                      work: work,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => RegisterView(
                              business: registerBusiness,
                              work: work.id,
                            ),
                          ),
                        );
                      },
                      onLongPress: () {
                        navigateToAddOrCreateWork(work, "Editar Atividade");
                      },
                    ),
                  ],
                ),
                background: Container(
                  color: Colors.red,
                ),
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("AVISO!"),
                        content: const Text(
                            "Voce esta prestes a excluir esta tarefa, com isso ira excluir todos os registros vinculados a ela, realmente deseja fazer isso?"),
                        actions: <Widget>[
                          FlatButton(
                              onPressed: () {
                                this.workBusiness.removeWork(work);
                                Navigator.of(context).pop(true);
                              },
                              child: const Text("SIM")),
                          FlatButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("NAO"),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddOrCreateWork(null, "Nova Atividade");
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[300],
      ),
    );
  }

  void navigateToAddOrCreateWork(Work work, String title) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                CreateWork(workBusiness, work, title))).then((value) {
      setState(() {
        this.loadWorks();
      });
    });
  }
}
