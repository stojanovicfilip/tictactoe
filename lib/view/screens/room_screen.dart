import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/logic/bloc/room_bloc.dart';
import 'package:tictactoe/logic/bloc/room_event.dart';
import 'package:tictactoe/logic/bloc/room_state.dart';
import 'package:tictactoe/view/pages/create_room.dart' as screen;
import 'package:tictactoe/view/pages/join_room.dart' as screen;
import 'package:tictactoe/view/pages/waiting_room.dart';
import 'package:tictactoe/view/screens/game_screen.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late RoomBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<RoomBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<RoomBloc, RoomState>(
        listener: (BuildContext context, RoomState state) {
          if (state is RoomInitialState) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
            }
          }
          if (state is GameReadyState) {
            // TODO: pass bloc value
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const GameScreen();
                },
              ),
            );
          }
        },
        builder: (BuildContext context, RoomState state) {
          if (state is RoomInitialState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: TextButton(
                          child: const Text('Create room'),
                          onPressed: () {
                            _bloc.add(
                                const SwitchRoomPage(showCreateRoom: true));
                          },
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: TextButton(
                          child: const Text('Join room'),
                          onPressed: () {
                            _bloc.add(
                                const SwitchRoomPage(showCreateRoom: false));
                          },
                        ),
                      ),
                    ],
                  ),
                  state.showCreateRoom
                      ? const Expanded(child: screen.CreateRoom())
                      : const Expanded(child: screen.JoinRoom()),
                ],
              ),
            );
          }
          if (state is RoomLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            );
          }
          if (state is WaitingRoomState) {
            return const WaitingRoom();
          }
          return const SizedBox();
        },
      ),
    );
  }
}
