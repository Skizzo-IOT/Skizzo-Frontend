import 'package:flutter/material.dart';
import 'package:skizzo/screens/video/joystick.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({Key? key}) : super(key: key);

  static const route = "/Video";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Joystick(),
      ),
    );
  }

}
