part of 'tcp_cubit.dart';

@immutable
abstract class TcpState extends Equatable {}

class TcpInitial extends TcpState {
  @override
  List<Object> get props => [];
}

class TcpImageCameraLoaded extends TcpState {
  final Uint8List buffer;
  TcpImageCameraLoaded(this.buffer);

  @override
  List<Object> get props => [buffer];
}
