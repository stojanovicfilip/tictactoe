import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/logic/bloc/room_bloc.dart';
import 'package:tictactoe/logic/bloc/room_event.dart';
import 'package:tictactoe/logic/bloc/room_state.dart';

class WaitingRoom extends StatefulWidget {
  const WaitingRoom({Key? key}) : super(key: key);

  @override
  State<WaitingRoom> createState() => _WaitingRoomState();
}

class _WaitingRoomState extends State<WaitingRoom> {
  late RoomBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<RoomBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomBloc, RoomState>(
      builder: (context, state) {
        if (state is WaitingRoomState) {
          _bloc.add(const WaitingTimer());
        }
        return const Center(
          child: Text('Waiting room'),
        );
      },
    );
  }
}
