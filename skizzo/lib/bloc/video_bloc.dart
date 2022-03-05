import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc {
  late WebSocketChannel channel;
  int directionX = 0;
  int directionY = 0;

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

  void connection() {
    channel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:3000/flutter'),
    );
  }

  // VideoBloc() : super(VideoInitial()) {
  //   on<VideoEvent>((event, emit) {
  //     // TODO: implement event handler
  //   });
  // }

  Uint8List? buffer;
  final _imageStateController = StreamController<Uint8List>();
  StreamSink<Uint8List> get _imageSink => _imageStateController.sink;
  Stream<Uint8List> get imageStream => _imageStateController.stream;

  final _imageEventController = StreamController<NewImageEvent>();

  Sink<NewImageEvent> get newImageSink => _imageEventController.sink;

  VideoBloc() {
    connection();
    channel.stream.listen(
      (data) {
        if (data is Uint8List) {
          print("data received");
          newImageSink.add(NewImageEvent(data));
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

    _imageEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(VideoEvent event) {
    if (event is NewImageEvent) {
      _imageSink.add(event.buffer);
    }
  }

  void dispose() {
    _imageStateController.close();
    _imageEventController.close();
  }
}
