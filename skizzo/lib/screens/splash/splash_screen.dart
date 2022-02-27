import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skizzo/cubit/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'body.dart';

class SplashScreen extends StatefulWidget {
  static const route = "/Splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: const Body(),
    );
  }
}
