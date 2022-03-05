import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skizzo/resources/res_repository.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final ResRepository resRepository = ResRepository();

  ImageCubit() : super(ImageInitial());

  Future<void> uploadImage(Uint8List file) async {
    emit(ImageLoading());
    String f = await resRepository.uploadImage(file, "file.jpg");
    emit(ImageLoaded(f));
  }
}
