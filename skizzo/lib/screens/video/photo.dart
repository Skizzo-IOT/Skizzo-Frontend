import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:skizzo/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skizzo/cubit/image_cubit.dart';
import 'package:skizzo/cubit/tcp_cubit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Photo extends StatelessWidget {
  const Photo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: FloatingActionButton(
        heroTag: "btn2",
        onPressed: () {
          Uint8List? data = BlocProvider.of<TcpCubit>(context).dataLastImage;

          if (data != null) {
            BlocProvider.of<ImageCubit>(context).uploadImage(data);
          } else {
            showTopSnackBar(
              context,
              const CustomSnackBar.error(
                message: "Une erreur est survenue",
              ),
            );
          }
        },
        backgroundColor: kSecondaryColor,
        child: BlocConsumer<ImageCubit, ImageState>(
          listener: (context, state) {
            if (state is ImageLoaded) {
              showTopSnackBar(
                context,
                const CustomSnackBar.success(
                  message: "Image upload avec succès !",
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ImageLoading) {
              return CircularProgressIndicator();
            }
            return Icon(Icons.photo_camera);
          },
        ),
      ),
    );
  }
}
