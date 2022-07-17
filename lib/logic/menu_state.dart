import 'package:equatable/equatable.dart';

abstract class MenuState extends Equatable {
  const MenuState();
}

class HomeInitialState extends MenuState {
  const HomeInitialState();

  @override
  List<Object?> get props => [];
}
