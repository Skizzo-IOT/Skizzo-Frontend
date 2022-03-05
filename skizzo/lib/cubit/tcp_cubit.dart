import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'tcp_state.dart';

class TcpCubit extends Cubit<TcpState> {
  late WebSocketChannel channel;
  Uint8List? dataLastImage;
  TcpCubit() : super(TcpInitial()) {
    connection();

    channel.stream.listen(
      (data) {
        if (data is Uint8List) {
          print("data received");
          dataLastImage = data;
          onImageReceived(data);
        } else {
          print("data received");
        }
      },
      onDone: () {
        print("Socket TCP DONE");
        connection();
      },
      onError: (error) {
        connection();
        print(error);
      },
    );
    sendDirection();
  }

  int directionX = 0;
  int directionY = 0;

  void connection() {
    channel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:3000/flutter'),
    );
  }

  Future<void> onImageReceived(Uint8List data) async {
    emit(TcpImageCameraLoaded(data));
  }

  Future<void> sendDirection() async {
    if (directionX > 1) directionX = 1;
    if (directionX < -1) directionX = -1;
    if (directionY > 1) directionY = 1;
    if (directionY < -1) directionY = -1;

    channel.sink.add(
      jsonEncode(
        <String, dynamic>{
          'type': 'direction',
          'directionX': directionX,
          'directionY': directionY,
        },
      ),
    );
  }
}
