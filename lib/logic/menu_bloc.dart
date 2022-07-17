import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/logic/menu_event.dart';
import 'package:tictactoe/logic/menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(const HomeInitialState());
}
