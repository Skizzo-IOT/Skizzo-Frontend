import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skizzo/resources/repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final Repository _repository = Repository();

  SplashCubit() : super(SplashInitial());

  Future<void> checkToken() async {
    emit(SplashLoading());

    bool tokenFound = await _repository.checkToken();

    if (tokenFound) {
      emit(SplashLoaded());
    } else {
      emit(SplashErrorUnfound());
    }
  }
}