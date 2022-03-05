import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skizzo/bloc/video_bloc.dart';
import 'package:skizzo/cubit/tcp_cubit.dart';

class MyImageVideo extends StatefulWidget {
  const MyImageVideo({Key? key}) : super(key: key);

  @override
  State<MyImageVideo> createState() => _MyImageVideoState();
}

class _MyImageVideoState extends State<MyImageVideo> {
  // Uint8List? bytes = null;
  Image? image;
  // final _bloc = VideoBloc();

  Future<void> laodImg(Uint8List bytes) async {
    setState(() {
      image = Image.memory(
        bytes,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 71, 71, 71),
        border: Border.all(
          color: Colors.red,
          width: 5,
        ),
      ),
      child: BlocConsumer<TcpCubit, TcpState>(
        listener: (context, state) {
          if (state is TcpImageCameraLoaded) {
            laodImg(state.buffer);
          }
        },
        builder: (context, state) {
          if (image == null) {
            return const SizedBox.shrink();
          }

          return image!;
        },
      ),
      alignment: Alignment.center,
    );
  }
}
