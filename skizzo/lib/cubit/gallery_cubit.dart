import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skizzo/resources/res_repository.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  final ResRepository resRepository = ResRepository();

  GalleryCubit() : super(GalleryInitial());

  Future<void> getAllFilesPath() async {
    try {
      emit(GalleryLoading());
      List<String> paths = await resRepository.getAll();
      emit(GalleryLoaded(paths));
    } on NetworkException catch (exception) {
      emit(GalleryError(exception.message));
    }
  }
}
