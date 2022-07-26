import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/data/models/room.dart';
import 'package:tictactoe/data/services/socket_client.dart';
import 'package:tictactoe/logic/bloc/room_event.dart';
import 'package:tictactoe/logic/bloc/room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  SocketClient? socketClient = SocketClient.instance;

  RoomBloc() : super(const RoomInitialState()) {
    on<SwitchRoomPage>((event, emit) => emit(
          RoomInitialState(showCreateRoom: event.showCreateRoom),
        ));
    on<CreateRoom>(_onCreateNewRoom);
    on<JoinRoom>(_onJoinRoom);
    on<WaitingTimer>(_onWaitingTimer);
  }

  void _onCreateNewRoom(
    CreateRoom event,
    Emitter<RoomState> emit,
  ) async {
    emit(const RoomLoadingState());

    // Check if username is valid
    if (event.username.isNotEmpty) {
      // Establish a socket connection & Emit room creation event to the server
      socketClient?.createRoom(event.username);

      // Listen to emits from the server whether room has been created or not
      StreamController controller = socketClient!.createRoomController;

      final RoomModel? room =
          await socketClient?.roomCreateOrJoinEvent(controller.stream);

      controller.close();

      // Notify UI that room has been created or not
      if (room != null) {
        emit(
          const WaitingRoomState(),
        );
      } else {
        emit(
          const RoomInitialState(errorMessage: 'Room was not created'),
        );
      }
    } else {
      emit(
        const RoomInitialState(errorMessage: 'Please enter your username'),
      );
    }
  }

  void _onJoinRoom(
    JoinRoom event,
    Emitter<RoomState> emit,
  ) async {
    emit(const RoomLoadingState());

    // Check if roomId and username are not empty
    if (event.roomId.isNotEmpty && event.username.isNotEmpty) {
      // Establish a socket connection & Emit room join event to the server
      socketClient?.joinRoom(
        event.roomId,
        event.username,
      );

      // Listen to emits from the server whether room has been joined or not
      StreamController controller = socketClient!.joinRoomController;

      final RoomModel? room =
          await socketClient?.roomCreateOrJoinEvent(controller.stream);

      controller.close();

      // Notify UI that room has been joined or not
      if (room != null) {
        emit(
          const GameReadyState(),
        );
      } else {
        emit(
          const RoomInitialState(
            errorMessage: 'Room was not found',
            showCreateRoom: false,
          ),
        );
      }
    } else {
      if (event.username.isEmpty) {
        emit(
          const RoomInitialState(
            errorMessage: 'Please enter your username',
            showCreateRoom: false,
          ),
        );
      } else if (event.roomId.isEmpty) {
        emit(
          const RoomInitialState(
            errorMessage: 'Please enter room ID',
            showCreateRoom: false,
          ),
        );
      }
    }
  }

  void _onWaitingTimer(
    WaitingTimer event,
    Emitter<RoomState> emit,
  ) async {
    StreamController controller = socketClient!.gameStartController;

    final RoomModel? room =
        await socketClient?.gameStartEvent(controller.stream);

    if (room != null) {
      emit(
        const GameReadyState(),
      );
    } else {
      emit(
        const WaitingRoomState(),
      );
    }

    controller.close();
  }
}
