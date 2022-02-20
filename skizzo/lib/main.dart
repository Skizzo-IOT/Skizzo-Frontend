import 'package:flutter/material.dart';
import 'package:skizzo/screens/auth/home.dart';
import 'package:skizzo/video.dart';

import 'login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: VideoPage(),
    );
  }
}
