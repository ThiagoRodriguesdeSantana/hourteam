import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AppLoad extends StatelessWidget {
  AppLoad();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 500,
            height: 500,
            child: FlareActor(
              "assets/ht_animation.flr",
              animation: "giro_do_relogio",
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
