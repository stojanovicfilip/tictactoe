import 'package:equatable/equatable.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();
}

class CheckConnectionEvent extends MenuEvent {
  @override
  List<Object?> get props => [];
}
