import 'package:equatable/equatable.dart';

abstract class RoomState extends Equatable {
  const RoomState();
}

class CreateRoomInitialState extends RoomState {
  const CreateRoomInitialState();

  @override
  List<Object?> get props => [];
}

class CreateRoomLoadingState extends RoomState {
  const CreateRoomLoadingState();

  @override
  List<Object?> get props => [];
}

class CreateRoomErrorState extends RoomState {
  final String errorMessage;
  const CreateRoomErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [];
}

class CreateRoomSuccessState extends RoomState {
  const CreateRoomSuccessState();

  @override
  List<Object?> get props => [];
}
