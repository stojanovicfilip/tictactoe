import 'package:equatable/equatable.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();
}

class SwitchRoomPage extends RoomEvent {
  final bool showCreateRoom;

  const SwitchRoomPage({
    required this.showCreateRoom,
  });

  @override
  List<Object?> get props => [showCreateRoom];
}

class CreateRoom extends RoomEvent {
  final String username;

  const CreateRoom({
    required this.username,
  });

  @override
  List<Object?> get props => [username];
}

class JoinRoom extends RoomEvent {
  final String roomId;
  final String username;

  const JoinRoom({
    required this.roomId,
    required this.username,
  });

  @override
  List<Object?> get props => [roomId, username];
}

class WaitingTimer extends RoomEvent {
  const WaitingTimer();

  @override
  List<Object?> get props => [];
}
