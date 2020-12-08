import 'package:flutter/material.dart';
import 'package:hourteam/models/Work.dart';

class WorkCard extends StatelessWidget {
  final Work work;
  final GestureTapCallback onTap;
  final GestureTapCallback onLongPress;

  const WorkCard({this.work, this.onTap, this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.red,
      onTap: this.onTap,
      onLongPress: this.onLongPress,
      child: Container(
        height: 80,
        width: 350,
        child: Card(
          elevation: 10,
          shadowColor: Colors.grey[600],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: Colors.blue[300],
          child: Center(
            child: Text(
              work.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
