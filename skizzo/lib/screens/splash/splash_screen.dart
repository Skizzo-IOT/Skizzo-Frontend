import 'package:flutter/material.dart';
import 'package:skizzo/cubit/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'body.dart';

class SplashScreen extends StatelessWidget {
  static const route = "/Splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: const Body(),
    );
  }
}