import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skizzo/constants.dart';
import 'package:skizzo/cubit/gallery_cubit.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    BlocProvider.of<GalleryCubit>(context).getAllFilesPath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GalleryCubit, GalleryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is GalleryLoaded) {
          return SingleChildScrollView(
            child: Wrap(
              runSpacing: 10,
              spacing: 10,
              children: <Widget>[
                for (var file in state.files)
                  Image.network(
                    "http://$kServer/api/res/data/$file",
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  )
              ],
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
