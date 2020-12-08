import 'dart:ffi';
import 'dart:io';

import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';

class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnalogClock(
      decoration:
          BoxDecoration(color: Colors.blue[300], shape: BoxShape.circle),
      width: 200.0,
      tickColor: Colors.black,
      showNumbers: false,
      showDigitalClock: false,
      datetime: DateTime.now(),
      key: GlobalObjectKey(1),
      isLive: true,
    );
  }
}
