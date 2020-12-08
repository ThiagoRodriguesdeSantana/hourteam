import 'dart:async';

import 'package:hourteam/models/register.dart';

class RegisterBloc {
  List<Register> _listRegister;

  List<Register> get listRegister => _listRegister;

  final _blocController = StreamController<List<Register>>.broadcast();

  Sink get input => _blocController.sink;
  Stream get output => _blocController.stream;

  void setNewList(List<Register> newList) {
    _listRegister = newList;

    input.add(listRegister);
  }

  closeStream() {
    _blocController.close();
  }
}
