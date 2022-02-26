import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skizzo/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skizzo/cubit/splash_cubit.dart';
import 'package:skizzo/screens/auth/sign_in.dart';
import 'package:skizzo/screens/video/video_screen.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..forward();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutBack,
  )..addStatusListener(
      (AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          BlocProvider.of<SplashCubit>(context).checkToken();
        }
      },
    );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                VideoPage.route, (Route<dynamic> route) => false);
          } else if (state is SplashErrorUnfound) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                SignIn.route, (Route<dynamic> route) => false);
          }
        },
        child: ScaleTransition(
          scale: _animation,
          child: content(),
        ),
      ),
    );
  }
}

Widget content() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: kDefaultBorderRadius,
          ),
          child: ClipRRect(
            borderRadius: kDefaultBorderRadius,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(25),
              child: Image.asset(
                "assets/robot.png",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          'Skizzo',
          style: GoogleFonts.abrilFatface(fontSize: 50)
              .copyWith(color: kSecondaryColor),
        ),
      ],
    ),
  );
}