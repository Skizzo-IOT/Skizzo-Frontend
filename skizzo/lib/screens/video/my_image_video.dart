import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skizzo/cubit/tcp_cubit.dart';

class MyImageVideo extends StatefulWidget {
  const MyImageVideo({Key? key}) : super(key: key);

  @override
  State<MyImageVideo> createState() => _MyImageVideoState();
}

class _MyImageVideoState extends State<MyImageVideo> {
  Uint8List? bytes = null;

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
            setState(() {
              bytes = state.buffer;
            });
          }
        },
        builder: (context, state) {
          print(state);

          if (bytes == null) {
            return const SizedBox.shrink();
          }

          return Image.memory(
            bytes!,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          );
        },
      ),
      alignment: Alignment.center,
    );
  }
}
