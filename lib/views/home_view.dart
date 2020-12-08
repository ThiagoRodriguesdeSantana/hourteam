import 'package:flutter/material.dart';
import 'package:hourteam/views/list_work.dart';
import 'package:hourteam/views/widget/app_load.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => ListWork()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppLoad();
  }
}
