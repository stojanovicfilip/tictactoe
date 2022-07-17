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

class CreateNewRoom extends RoomEvent {
  final String username;

  const CreateNewRoom({
    required this.username,
  });

  @override
  List<Object?> get props => [username];
}
