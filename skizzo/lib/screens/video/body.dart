import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skizzo/constants.dart';
import 'package:skizzo/cubit/image_cubit.dart';
import 'package:skizzo/cubit/tcp_cubit.dart';
import 'package:skizzo/screens/auth/sign_in.dart';
import 'package:skizzo/screens/gallery/gallery_screen.dart';
import 'package:skizzo/screens/video/joystick.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skizzo/screens/video/my_image_video.dart';
import 'package:skizzo/screens/video/photo.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    BlocProvider.of<TcpCubit>(context).directionX = 0;
    BlocProvider.of<TcpCubit>(context).directionY = 0;
    BlocProvider.of<TcpCubit>(context).sendDirection();
    _focusNode.dispose();
    BlocProvider.of<TcpCubit>(context).channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);

    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyEvent,
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton: Stack(
          children: [
            Positioned(
              top: 50,
              right: 0,
              child: FloatingActionButton(
                heroTag: "btn1",
                onPressed: () async {
                  final pref = await SharedPreferences.getInstance();
                  pref.setString(kTokenPref, "");

                  Navigator.of(context).pushNamedAndRemoveUntil(
                      SignIn.route, (Route<dynamic> route) => false);
                },
                backgroundColor: kSecondaryColor,
                child: const Icon(Icons.logout_outlined),
              ),
            ),
            Positioned(
              bottom: 100,
              right: 0,
              child: FloatingActionButton(
                heroTag: "btn3",
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GalleryScreen()),
                  );
                },
                backgroundColor: kSecondaryColor,
                child: const Icon(Icons.photo),
              ),
            ),
            BlocProvider(
              create: (context) => ImageCubit(),
              child: const Photo(),
            ),
          ],
        ),
        body: Stack(
          children: const [
            MyImageVideo(),
            Positioned(
              bottom: 10,
              left: 10,
              child: Joystick(),
            ),
          ],
        ),
      ),
    );
  }

  Type? lastRuntimeType = null;

  LogicalKeyboardKey? lastLogicalKeyboardKey = null;

  List<LogicalKeyboardKey> keysPressed = [];

  void _handleKeyEvent(RawKeyEvent event) {
    if (event.runtimeType == RawKeyDownEvent) {
      if (!keysPressed.contains(event.logicalKey)) {
        keysPressed.add(event.logicalKey);
      }
    } else if (event.runtimeType == RawKeyUpEvent) {
      if (keysPressed.contains(event.logicalKey)) {
        keysPressed.remove(event.logicalKey);
      }
    }

    int nextDirectionX = 0;
    int nextDirectionY = 0;
    for (var key in keysPressed) {
      if (key == LogicalKeyboardKey.keyZ) {
        print("Z");
        nextDirectionY += 1;
      }
      if (key == LogicalKeyboardKey.keyQ) {
        print("Q");
        nextDirectionX -= 1;
      }
      if (key == LogicalKeyboardKey.keyS) {
        print("S");
        nextDirectionY -= 1;
      }
      if (key == LogicalKeyboardKey.keyD) {
        print("D");
        nextDirectionX += 1;
      }
    }
    int directionX = BlocProvider.of<TcpCubit>(context).directionX;
    int directionY = BlocProvider.of<TcpCubit>(context).directionY;

    if (nextDirectionX != directionX || nextDirectionY != directionY) {
      BlocProvider.of<TcpCubit>(context).directionX = nextDirectionX;
      BlocProvider.of<TcpCubit>(context).directionY = nextDirectionY;
      BlocProvider.of<TcpCubit>(context).sendDirection();
    }
  }
}
