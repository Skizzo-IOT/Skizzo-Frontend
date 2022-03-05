part of 'gallery_cubit.dart';

@immutable
abstract class GalleryState {}

class GalleryInitial extends GalleryState {}

class GalleryLoading extends GalleryState {}

class GalleryLoaded extends GalleryState {
  final List<String> files;
  GalleryLoaded(this.files);
}

class GalleryError extends GalleryState {
  final String msg;
  GalleryError(this.msg);
}
