import 'package:equatable/equatable.dart';
import 'package:tictactoe/data/models/auth.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  final AuthStatus status;
  final AuthModel auth;

  const AppState._({
    required this.status,
    this.auth = AuthModel.empty,
  });

  const AppState.authenticated(AuthModel auth)
      : this._(
          status: AuthStatus.authenticated,
          auth: auth,
        );

  const AppState.unauthenticated()
      : this._(
          status: AuthStatus.unauthenticated,
        );

  @override
  List<Object?> get props => [status, auth];
}
