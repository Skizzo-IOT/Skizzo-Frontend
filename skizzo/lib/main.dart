import 'package:flutter/material.dart';
import 'package:skizzo/screens/auth/sign_in.dart';
import 'package:skizzo/screens/gallery/gallery_screen.dart';
import 'package:skizzo/screens/splash/splash_screen.dart';
import 'package:skizzo/screens/video/video_screen.dart';
import 'package:skizzo/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skizzo',
      theme: theme(),
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        SignIn.route: (context) => const SignIn(),
        VideoPage.route: (context) => const VideoPage(),
        GalleryScreen.route: (context) => const GalleryScreen(),
      },
    );
  }
}
