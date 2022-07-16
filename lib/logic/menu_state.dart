import 'package:equatable/equatable.dart';

abstract class MenuState extends Equatable {
  const MenuState();
}

class HomeInitialState extends MenuState {
  const HomeInitialState();

  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends MenuState {
  const HomeLoadingState();

  @override
  List<Object?> get props => [];
}

class HomeConnectionErrorState extends MenuState {
  final String errorMessage;

  const HomeConnectionErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [];
}

class HomeConnectionAvailableState extends MenuState {
  const HomeConnectionAvailableState();

  @override
  List<Object?> get props => [];
}
