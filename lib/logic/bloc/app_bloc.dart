import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/data/models/auth.dart';
import 'package:tictactoe/data/services/auth_repository.dart';
import 'package:tictactoe/logic/bloc/app_event.dart';
import 'package:tictactoe/logic/bloc/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  StreamSubscription<AuthModel>? _authSubscription;

  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(
          authRepository.currentUser.isNotEmpty
              ? AppState.authenticated(authRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    on<UserChangedEvent>(_onUserChanged);
    on<LogoutEvent>(_onLogout);
  }

  void _onUserChanged(
    UserChangedEvent event,
    Emitter<AppState> emit,
  ) {
    emit(
      event.auth.isNotEmpty
          ? AppState.authenticated(event.auth)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogout(
    LogoutEvent event,
    Emitter<AppState> emit,
  ) {
    unawaited(_authRepository.logout());
  }
}
