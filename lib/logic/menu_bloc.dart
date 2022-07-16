import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/logic/menu_event.dart';
import 'package:tictactoe/logic/menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(const HomeInitialState()) {
    on<CheckConnectionEvent>(_onCheckConnectionEvent);
  }

  void _onCheckConnectionEvent(
    CheckConnectionEvent event,
    Emitter<MenuState> emitter,
  ) async {
    emitter(const HomeLoadingState());
    // TODO: check if there is a internet connection

    // TODO: if there is a internet connection, then route to the join game screen. Else show the error message
    // if (isSucceed) {
    //   List<Food> dummyFoods = FoodGenerator.generateDummyFoods();
    //   emitter(HomeSuccessFetchDataState(foods: dummyFoods));
    // } else {
    //   emitter(const HomeErrorFetchDataState(
    //     errorMessage: "something went very wrong :(",
    //   ));
    // }
  }
}
