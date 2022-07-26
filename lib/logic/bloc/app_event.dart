import 'package:equatable/equatable.dart';
import 'package:tictactoe/data/models/auth.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AppEvent {
  const LoginEvent();
}

class RegisterEvent extends AppEvent {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class LogoutEvent extends AppEvent {
  const LogoutEvent();

  @override
  List<Object?> get props => [];
}

class UserChangedEvent extends AppEvent {
  final AuthModel auth;

  const UserChangedEvent(this.auth);

  @override
  List<Object?> get props => [auth];
}
