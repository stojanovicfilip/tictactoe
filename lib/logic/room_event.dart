import 'package:equatable/equatable.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();
}

class CreateNewRoom extends RoomEvent {
  final String username;

  const CreateNewRoom({
    required this.username,
  });

  @override
  List<Object?> get props => [username];
}
