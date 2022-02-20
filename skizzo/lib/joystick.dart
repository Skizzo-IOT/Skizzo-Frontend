import 'package:flutter/material.dart';
import 'package:control_pad/control_pad.dart';

class Joystick extends StatelessWidget {
  const Joystick({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text('Control Pad Example'),
      ),
      body: Container(
        color: Colors.white,
        child: JoystickView(),
      ),
    );
  }
}