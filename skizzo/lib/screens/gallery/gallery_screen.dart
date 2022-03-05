import 'package:flutter/material.dart';
import 'package:skizzo/cubit/gallery_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'body.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  static const route = "/Gallery";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Photos d'espionnages")),
      body: BlocProvider(
        create: (context) => GalleryCubit(),
        child: const Body(),
      ),
    );
  }
}
