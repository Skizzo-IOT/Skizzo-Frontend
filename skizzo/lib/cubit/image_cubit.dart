import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skizzo/resources/res_repository.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final ResRepository resRepository = ResRepository();

  ImageCubit() : super(ImageInitial());

  Future<String> uploadImage(Uint8List file, String filename) async {
    return await resRepository.uploadImage(file, filename);
  }
}
