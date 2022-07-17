import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/data/models/room.dart';
import 'package:tictactoe/data/services/socket_client.dart';
import 'package:tictactoe/logic/room_event.dart';
import 'package:tictactoe/logic/room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  SocketClient? socketClient = SocketClient.instance;

  RoomBloc() : super(const RoomInitialState()) {
    on<SwitchRoomPage>((event, emit) => emit(
          RoomInitialState(showCreateRoom: event.showCreateRoom),
        ));
    on<CreateNewRoom>(_onCreateNewRoom);
  }

  void _onCreateNewRoom(
    CreateNewRoom event,
    Emitter<RoomState> emit,
  ) async {
    emit(const RoomLoadingState());

    // Check if username is valid
    if (event.username.isNotEmpty) {
      // Establish a socket connection & Emit room creation event to the server
      socketClient?.createRoom(event.username);

      // Listen to emits from the server whether room has been created or not
      StreamController controller = socketClient!.createRoomStream;

      final RoomModel? room =
          await socketClient?.roomCreationResolution(controller.stream);

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
}
