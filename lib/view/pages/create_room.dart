import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/logic/bloc/room_bloc.dart';
import 'package:tictactoe/logic/bloc/room_event.dart' as event;
import 'package:tictactoe/logic/bloc/room_state.dart';
import 'package:tictactoe/view/widgets/button.dart';

class CreateRoom extends StatefulWidget {
  const CreateRoom({Key? key}) : super(key: key);

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
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
    return BlocBuilder<RoomBloc, RoomState>(
      builder: (BuildContext context, RoomState state) {
        return Form(
          key: _formKey,
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
                    _bloc.add(event.CreateRoom(username: _username.text));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
