import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skizzo/resources/repository.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final Repository _repository = Repository();

  SignInCubit() : super(SignInInitial());

  Future<void> signin(String username, String password) async {
    try {
      emit(SignInLoading());

      await _repository.signin(username, password);

      emit(SignInLoaded());
    } on NetworkException catch (exception) {
      emit(SignInError(exception.message));
    } on UnknowUserException catch (exception) {
      emit(SignInInvalidUserError(exception.message));
    }
  }
}