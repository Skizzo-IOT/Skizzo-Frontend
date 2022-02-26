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
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade600,
                    child: Icon(Icons.arrow_drop_up),
                  ),
                  Spacer(),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade600,
                    child: Icon(Icons.arrow_left),
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade600,
                    child: Icon(Icons.arrow_right),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade600,
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
