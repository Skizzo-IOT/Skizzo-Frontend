import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skizzo/cubit/sign_in_cubit.dart';
import 'package:skizzo/screens/shared/my_text_field.dart';
import 'package:skizzo/screens/shared/row_btn.dart';
import 'package:skizzo/screens/video/video_screen.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignInForm extends StatelessWidget {
  
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // EmailFormField(_emailController),
          MyTextField(
            text: "Adresse email",
            icon: Icons.mail_outline,
            controller: _emailController,
            isEmail: true,
            fontSize: 24,
            iconSize: 35,
          ),
          const SizedBox(height: 30),
          // PwdFormField(_passwordController),
          MyTextField(
            text: "Mot de passe",
            icon: Icons.lock,
            controller: _passwordController,
            isPassword: true,
            fontSize: 24,
            iconSize: 35,
          ),
          const SizedBox(height: 30),
          BlocConsumer<SignInCubit, SignInState>(
            listener: (context, state) {
              if (state is SignInError) {
                showTopSnackBar(
                  context,
                  const CustomSnackBar.error(
                    message: "Une erreur est survenue",
                  ),
                );
              } else if (state is SignInInvalidUserError) {
                showTopSnackBar(
                  context,
                  const CustomSnackBar.error(
                    message: "Identifiants incorrects",
                  ),
                );
              } else if (state is SignInLoaded) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    VideoPage.route, (Route<dynamic> route) => false);
              }
            },
            builder: (context, state) {
              return RowBtn(
                text: "CONNEXION",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    BlocProvider.of<SignInCubit>(context).signin(
                        _emailController.text, _passwordController.text);
                  }
                },
                isLoading: state is SignInLoading,
              );
            },
          ),
        ],
      ),
    );
  }
}