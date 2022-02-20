import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Joystick extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Joystick(
            size: 100,
            isDraggable: true,
            iconColor: Colors.amber,
            backgroundColor: Colors.black,
            opacity: 0.5,
            joystickMode: JoystickModes.all,
            onUpPressed: () {},
            onLeftPressed: () {},
            onRightPressed: () {},
            onDownPressed: () {},
            onPressed: (_direction) {}
        ),
      ),
    );
  }
}
