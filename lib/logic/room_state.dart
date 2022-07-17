import 'package:equatable/equatable.dart';

abstract class RoomState extends Equatable {
  const RoomState();
}

class RoomInitialState extends RoomState {
  final String? errorMessage;
  final bool showCreateRoom;

  const RoomInitialState({
    this.errorMessage,
    this.showCreateRoom = true,
  });

  @override
  List<Object?> get props => [errorMessage, showCreateRoom];
}

class RoomLoadingState extends RoomState {
  const RoomLoadingState();

  @override
  List<Object?> get props => [];
}

class WaitingRoomState extends RoomState {
  const WaitingRoomState();

  @override
  List<Object?> get props => [];
}
