import 'package:flutter/material.dart';

class Joystick extends StatelessWidget {
  const Joystick({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
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
                children: const [
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.arrow_drop_up),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.arrow_left),
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.arrow_right),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.arrow_drop_down),
                  ),
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
