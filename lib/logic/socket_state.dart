import 'package:equatable/equatable.dart';

abstract class SocketState extends Equatable {
  const SocketState();
}

class SocketInitialState extends SocketState {
  const SocketInitialState();

  @override
  List<Object?> get props => [];
}
