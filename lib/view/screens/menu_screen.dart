import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/logic/menu_bloc.dart';
import 'package:tictactoe/logic/menu_state.dart';
import 'package:tictactoe/logic/room_bloc.dart';
import 'package:tictactoe/logic/room_event.dart';
import 'package:tictactoe/routes.dart';
import 'package:tictactoe/view/constants/transitions.dart';
import 'package:tictactoe/view/screens/room_screen.dart';
import 'package:tictactoe/view/widgets/button.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late MenuBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<MenuBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<MenuBloc, MenuState>(
        listener: (_, __) {},
        builder: (BuildContext context, MenuState state) {
          if (state is HomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: CustomButton(
                    text: 'Create new room',
                    onPressed: () {
                      Navigator.push(
                        context,
                        SlideRoute(
                          enterPage: BlocProvider(
                            create: (context) => RoomBloc(),
                            child: const RoomScreen(),
                          ),
                          begin: const Offset(0, 1),
                          end: const Offset(0, 0),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: CustomButton(
                    text: 'Join a room',
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.join);
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: CustomButton(
                    text: 'Settings',
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.settings);
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: CustomButton(
                    text: 'Quit',
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
