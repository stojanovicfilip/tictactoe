import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/logic/cubit/login_cubit.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state.status == LoginStatus.error) {
          // TODO: handle error state
        }
      },
      builder: (BuildContext context, LoginState state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: state.status == LoginStatus.submitting
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      child: Text(
                        'SignUp with your Google account',
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context.read<LoginCubit>().loginWithGoogleAccount();
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
