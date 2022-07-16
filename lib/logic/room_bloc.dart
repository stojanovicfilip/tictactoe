import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/data/services/socket_client.dart';
import 'package:tictactoe/logic/room_event.dart';
import 'package:tictactoe/logic/room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  // StreamSubscription socketStreamSubscription = SocketBloc.listen();
  final SocketClient? socketRepo = SocketClient?.instance;

  RoomBloc() : super(const CreateRoomInitialState()) {
    on<CreateNewRoom>(_onCreateNewRoom);
  }

  void _onCreateNewRoom(
    CreateNewRoom event,
    Emitter<RoomState> emitter,
  ) async {
    emitter(const CreateRoomLoadingState());
    Stream stream = socketRepo!.roomSuccessfullyCreated();
  }

  @override
  Future<void> close() {
    // socketStreamSubscription.cancel();
    return super.close();
  }
}
