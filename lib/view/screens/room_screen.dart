import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/logic/room_bloc.dart';
import 'package:tictactoe/logic/room_event.dart';
import 'package:tictactoe/logic/room_state.dart';
import 'package:tictactoe/view/screens/game_screen.dart';
import 'package:tictactoe/view/widgets/button.dart';

class RoomScreen extends StatefulWidget {
  const RoomScreen({Key? key}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  late TextEditingController _username;
  late RoomBloc _bloc;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _username = TextEditingController(text: "");
    _bloc = context.read<RoomBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<RoomBloc, RoomState>(
        listener: (_, __) {},
        builder: (BuildContext context, RoomState state) {
          if (state is CreateRoomLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CreateRoomSuccessState) {
            return const GameScreen();
          }
          if (state is CreateRoomErrorState) {
            return const Center(
              child: Text('Error'),
            );
          }
          return Form(
            key: _formKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text('Create new room'),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      controller: _username,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your username' : null,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: CustomButton(
                      text: 'Create',
                      onPressed: () {
                        _bloc.add(CreateNewRoom(username: _username.text));
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
