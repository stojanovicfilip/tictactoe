import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/logic/socket_event.dart';
import 'package:tictactoe/logic/socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  SocketBloc() : super(const SocketInitialState());
}
