import 'package:flutter/material.dart';
import 'package:hourteam/repository/db.dart';
import 'package:hourteam/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseCreator().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HourTeam',
      debugShowCheckedModeBanner: false,
      color: Colors.blue[500],
      theme: ThemeData(primaryColor: Colors.blue[500]),
      home: Home(),
    );
  }
}
