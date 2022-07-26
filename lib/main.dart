import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tictactoe/data/services/auth_repository.dart';
import 'package:tictactoe/logic/bloc/app_bloc.dart';
import 'package:tictactoe/logic/bloc/app_state.dart';
import 'package:tictactoe/routes.dart';
import 'package:tictactoe/view/screens/login_screen.dart';
import 'package:tictactoe/view/screens/menu_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) async {
      await Firebase.initializeApp();
      final authRepository = AuthRepository();
      runApp(MyApp(authRepository: authRepository));
    },
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;

  const MyApp({Key? key, required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (context) => AppBloc(authRepository: _authRepository),
        child: MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            routes: Routes.routes,
            home: FlowBuilder(
                state: context.select((AppBloc bloc) => bloc.state.status),
                onGeneratePages: (AuthStatus state, List<Page<dynamic>> pages) {
                  switch (state) {
                    case AuthStatus.authenticated:
                      return [MenuScreen.page()];
                    case AuthStatus.unauthenticated:
                      return [LoginScreen.page()];
                  }
                })),
      ),
    );
  }
}
