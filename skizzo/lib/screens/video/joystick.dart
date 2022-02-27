import 'package:flutter/material.dart';

class Joystick extends StatelessWidget {
  const Joystick({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.shade600.withOpacity(0.5),
      ),
      width: 100,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  JoystickButton(icon: Icons.arrow_drop_up),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  JoystickButton(icon: Icons.arrow_left),
                  Spacer(),
                  JoystickButton(icon: Icons.arrow_right),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Spacer(),
                  JoystickButton(icon: Icons.arrow_drop_down),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class JoystickButton extends StatefulWidget {
  const JoystickButton({
    Key? key,
    required this.icon,
  }) : super(key: key);

  final IconData icon;

  @override
  State<JoystickButton> createState() => _JoystickButtonState();
}

class _JoystickButtonState extends State<JoystickButton> {
  bool pressAttention = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          pressAttention = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          pressAttention = false;
        });
      },
      onTapCancel: () {
        setState(() {
          pressAttention = false;
        });
      },
      child: CircleAvatar(
        backgroundColor: pressAttention ? Colors.grey.shade600 : Colors.grey,
        child: Icon(widget.icon),
      ),
    );
  }
}
