import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skizzo/constants.dart';
import 'package:skizzo/screens/auth/sign_in.dart';
import 'package:skizzo/screens/video/joystick.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  static const route = "/Video";

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            bottom: 0,
            right: 0,
            child: FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {},
              backgroundColor: kSecondaryColor,
              child: const Icon(Icons.photo_camera),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 71, 71, 71),
              border: Border.all(
                color: Colors.red,
                width: 5,
              ),
            ),
            alignment: Alignment.center,
          ),
          const Positioned(
            bottom: 10,
            left: 10,
            child: Joystick(),
          ),
        ],
      ),
    );
  }
}
