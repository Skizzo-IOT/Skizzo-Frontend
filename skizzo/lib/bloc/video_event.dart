part of 'video_bloc.dart';

@immutable
abstract class VideoEvent {}

class NewImageEvent extends VideoEvent {
  final Uint8List buffer;
  NewImageEvent(this.buffer);
}
