import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/data/services/auth_repository.dart';
import 'package:tictactoe/logic/cubit/login_cubit.dart';
import 'package:tictactoe/view/pages/login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginScreen());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthRepository>()),
          child: const Login(),
        ),
      ),
    );
  }
}
