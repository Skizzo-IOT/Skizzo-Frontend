import 'package:flutter/material.dart';
import 'package:skizzo/joystick.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Joystick(),
      ),
    );
  }
}
