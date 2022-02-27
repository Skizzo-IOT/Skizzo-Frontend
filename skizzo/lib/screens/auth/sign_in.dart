import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skizzo/constants.dart';
import 'package:skizzo/cubit/sign_in_cubit.dart';
import 'package:skizzo/screens/auth/sign_in_form.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  static const route = "/SignIn";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1080) {
              return Center(
                child: SizedBox(
                  width: 500,
                  child: Card(
                    elevation: 10,
                    child: content(),
                  ),
                ),
              );
            } else {
              return content();
            }
          },
        ),
      ),
    );
  }

  Widget content() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(height: 30),
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
                    width: 100,
                    height: 100,
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
            const Text(
              "Connectez-vous avec vos identifiants",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            BlocProvider(
              create: (context) => SignInCubit(),
              child: SignInForm(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
