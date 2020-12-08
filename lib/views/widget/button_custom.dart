import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final VoidCallback onPressedCustom;
  final double withSize;
  final double heightSize;
  final String title;
  const ButtonCustom(
      {this.onPressedCustom, this.withSize, this.heightSize, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.withSize,
      height: this.heightSize,
      child: Card(
        elevation: 10,
        shadowColor: Colors.grey[600],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: RaisedButton(
          color: Colors.blue[300],
          child: Text(
            this.title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          onPressed: this.onPressedCustom,
        ),
      ),
    );
  }
}
