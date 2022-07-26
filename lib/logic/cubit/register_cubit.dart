// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tictactoe/data/services/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterCubit(this._authRepository) : super(RegisterState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: RegisterStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: RegisterStatus.initial));
  }

  Future<void> registerWithEmailAndPassword() async {
    if (state.status == RegisterStatus.submitting) return;
    emit(state.copyWith(status: RegisterStatus.submitting));
    try {
      await _authRepository.register(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: RegisterStatus.success));
    } catch (_) {}
  }

  Future<void> registerWithGoogleAccount() async {
    if (state.status == RegisterStatus.submitting) return;
    emit(state.copyWith(status: RegisterStatus.submitting));
    try {
      await _authRepository.signInWithGoogleAccount();
      emit(state.copyWith(status: RegisterStatus.success));
    } catch (_) {}
  }
}
